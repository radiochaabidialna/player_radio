'use strict';
/* ═══════════════════════════════════════════════════════════════
   RADIO CHAÂBI — shared.js  v5
   ✓ Barre LIVE au-dessus de la navbar (toujours visible)
   ✓ Player persistant via localStorage (survit aux changements de page)
   ✓ Envoi automatique à live.php à chaque lecture
═══════════════════════════════════════════════════════════════ */

const API_BASE  = './api/media.php';
const LIVE_BASE = './api/live.php';
const NO_IMG    = '/music/img_chaabi/default.png';
const BADGE_LABELS = { songs:'Chanson', emissions:'Émission', interviews:'Interview' };

// ════════════════════════════════════════════════════════════════
//  HELPERS GLOBAUX
// ════════════════════════════════════════════════════════════════
window.esc = str => {
  const d = document.createElement('div');
  d.textContent = str ?? '';
  return d.innerHTML;
};
window.fmt = n => Number(n || 0).toLocaleString('fr-FR');
window.fmtTime = s => {
  if (!s || isNaN(s)) return '0:00';
  return `${Math.floor(s / 60)}:${String(Math.floor(s % 60)).padStart(2, '0')}`;
};

// ── API helpers ──────────────────────────────────────────────────
window.rcApi = async function (params) {
  try {
    const r = await fetch(`${API_BASE}?${new URLSearchParams(params)}`);
    const j = await r.json();
    if (!j.success) throw new Error(j.error || 'Erreur API');
    return j.data;
  } catch (e) { console.error('[API]', e.message); return null; }
};
window.rcApiIncrement = async function (type, id, action) {
  try { await fetch(`${API_BASE}?type=${type}&action=${action}&id=${id}`); } catch (_) {}
};

// ── Toast ────────────────────────────────────────────────────────
window.rcToast = function (msg, type = 'info') {
  let c = document.getElementById('toastContainer');
  if (!c) {
    c = document.createElement('div');
    c.id = 'toastContainer';
    c.className = 'toast-container';
    document.body.appendChild(c);
  }
  const t = document.createElement('div');
  t.className = `toast${type === 'error' ? ' toast-error' : type === 'success' ? ' toast-success' : ''}`;
  const icon = type === 'error' ? 'fa-circle-xmark' : type === 'success' ? 'fa-circle-check' : 'fa-circle-info';
  t.innerHTML = `<i class="fa-solid ${icon}"></i><span>${esc(msg)}</span>`;
  c.appendChild(t);
  setTimeout(() => {
    t.style.cssText = 'opacity:0;transform:translateX(20px);transition:.3s';
    setTimeout(() => t.remove(), 320);
  }, 2800);
};

// ── URL params ───────────────────────────────────────────────────
window.rcParams = {
  get: key => new URLSearchParams(location.search).get(key),
  set(key, val) {
    const p = new URLSearchParams(location.search);
    if (val) p.set(key, val); else p.delete(key);
    history.replaceState(null, '', `${location.pathname}?${p}`);
  }
};

// ── Pagination ───────────────────────────────────────────────────
window.buildPagination = function (container, { current, total, perPage, onChange }) {
  const pages = Math.ceil(total / perPage);
  if (!container || pages <= 1) { if (container) container.innerHTML = ''; return; }
  let html = `<button class="page-btn" id="pp-prev" ${current <= 1 ? 'disabled' : ''}><i class="fa-solid fa-chevron-left"></i></button>`;
  const range = [];
  for (let i = 1; i <= pages; i++) {
    if (i === 1 || i === pages || (i >= current - 2 && i <= current + 2)) range.push(i);
    else if (range[range.length - 1] !== '…') range.push('…');
  }
  range.forEach(p => {
    if (p === '…') html += `<button class="page-btn dots">…</button>`;
    else html += `<button class="page-btn ${p === current ? 'active' : ''}" data-p="${p}">${p}</button>`;
  });
  html += `<button class="page-btn" id="pp-next" ${current >= pages ? 'disabled' : ''}><i class="fa-solid fa-chevron-right"></i></button>`;
  container.innerHTML = html;
  container.querySelectorAll('.page-btn[data-p]').forEach(btn =>
    btn.addEventListener('click', () => onChange(+btn.dataset.p))
  );
  container.querySelector('#pp-prev')?.addEventListener('click', () => onChange(current - 1));
  container.querySelector('#pp-next')?.addEventListener('click', () => onChange(current + 1));
};

// ── Scroll reveal ────────────────────────────────────────────────
function initReveal() {
  const obs = new IntersectionObserver(entries => {
    entries.forEach(e => { if (e.isIntersecting) { e.target.classList.add('visible'); obs.unobserve(e.target); } });
  }, { threshold: .1 });
  document.querySelectorAll('.reveal').forEach(el => obs.observe(el));
}

// ════════════════════════════════════════════════════════════════
//  BARRE LIVE — injectée AU-DESSUS de la navbar
//  Toujours dans le DOM, visible dès qu'il y a des auditeurs
// ════════════════════════════════════════════════════════════════
function injectLiveBar() {
  if (document.getElementById('rcLiveBar')) return;
  const bar = document.createElement('div');
  bar.id = 'rcLiveBar';
  bar.innerHTML = `
    <div class="live-badge">
      <span class="live-dot"></span>
      <span class="live-label">EN DIRECT</span>
      <span class="live-count" id="liveCount">0 auditeur</span>
    </div>
    <div class="live-ticker-wrap" id="liveTickerWrap">
      <div class="live-ticker" id="liveTicker">
        <span class="live-empty">Aucune écoute en cours…</span>
      </div>
    </div>`;
  // Insérer AVANT tout autre élément du body
  document.body.insertBefore(bar, document.body.firstChild);
}

// Met à jour la barre avec les données du feed
function updateLiveBar(data) {
  const bar       = document.getElementById('rcLiveBar');
  const ticker    = document.getElementById('liveTicker');
  const countEl   = document.getElementById('liveCount');
  const tickerWrap= document.getElementById('liveTickerWrap');
  if (!bar || !ticker) return;

  const count   = data.count   || 0;
  const entries = data.entries || [];

  // Mettre à jour le compteur
  if (countEl) {
    countEl.textContent = count === 0 ? '0 auditeur'
      : count === 1 ? '1 auditeur'
      : `${count} auditeurs`;
  }

  if (entries.length === 0) {
    // Aucune écoute : barre discrète
    ticker.innerHTML = '<span class="live-empty">Aucune écoute en cours…</span>';
    ticker.style.animation = 'none';
    bar.classList.remove('live-has-items');
    return;
  }

  bar.classList.add('live-has-items');

  // Construire les items du ticker — on duplique pour l'effet infini
  const buildItem = (e) => {
    const icon  = e.icon  || '🎵';
    const label = e.label || 'Audio';
    const title = e.titre || '—';
    const artist= e.artiste ? ` — ${e.artiste}` : '';
    return `
      <span class="live-item">
        <span class="live-item-icon">${icon}</span>
        <span class="live-item-text">
          <span class="live-item-type">${esc(label)}</span>
          <span class="live-item-title">${esc(title)}${esc(artist)}</span>
        </span>
      </span>
      <span class="live-sep">◆</span>`;
  };

  const itemsHTML = entries.map(buildItem).join('');
  // Dupliquer pour boucle infinie fluide
  ticker.innerHTML = itemsHTML + itemsHTML;

  // Durée = 6s par item, min 20s max 90s
  const dur = Math.min(90, Math.max(20, entries.length * 6));
  ticker.style.setProperty('--ticker-duration', `${dur}s`);
  ticker.style.animation = `ticker-scroll ${dur}s linear infinite`;
}

// Polling du feed (toutes les 8 secondes)
let liveTimer = null;
async function pollLiveFeed() {
  try {
    const r = await fetch(`${LIVE_BASE}?action=feed`);
    const j = await r.json();
    if (j.success) updateLiveBar(j.data);
  } catch (_) {}
}

function startLivePolling() {
  pollLiveFeed();
  liveTimer = setInterval(pollLiveFeed, 8000);
}

// Envoyer "en écoute" à l'API live
async function livePlay(meta) {
  if (!meta || !meta.title) return;
  try {
    await fetch(`${LIVE_BASE}?action=play`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        type:    meta.type    || 'songs',
        title:   meta.title   || '—',
        artist:  meta.artist  || '',
        item_id: meta.item_id || null,
      })
    });
    // Rafraîchir immédiatement
    pollLiveFeed();
  } catch (_) {}
}

// Heartbeat toutes les 20s quand lecture en cours
let pingTimer = null;
function startPing() {
  stopPing();
  pingTimer = setInterval(async () => {
    try { await fetch(`${LIVE_BASE}?action=ping`); } catch (_) {}
  }, 20000);
}
function stopPing() {
  if (pingTimer) { clearInterval(pingTimer); pingTimer = null; }
}
async function liveStop() {
  stopPing();
  try { await fetch(`${LIVE_BASE}?action=stop`); } catch (_) {}
}

// ════════════════════════════════════════════════════════════════
//  PLAYER GLOBAL — PERSISTANT VIA localStorage
//  L'état est sauvegardé à chaque action et restauré au chargement
// ════════════════════════════════════════════════════════════════
const PS_KEY = 'rc_player_state';   // clé localStorage

const PlayerState = {
  src:    '',
  title:  '',
  artist: '',
  type:   'songs',
  img:    NO_IMG,
  time:   0,
  volume: 80,
  paused: true,
  items:  [],
  idx:    0,
  shuffle: false,
  repeat:  false,
};

function savePS() {
  const s = Object.assign({}, PlayerState);
  delete s.items;           // trop lourd pour localStorage
  try { localStorage.setItem(PS_KEY, JSON.stringify(s)); } catch (_) {}
}

function loadPS() {
  try {
    const s = JSON.parse(localStorage.getItem(PS_KEY) || '{}');
    Object.assign(PlayerState, s);
  } catch (_) {}
}

function injectPlayerHTML() {
  if (document.getElementById('globalPlayer')) return;
  const el = document.createElement('div');
  el.className = 'global-player';
  el.id = 'globalPlayer';
  el.innerHTML = `
    <audio id="gAudio" preload="auto"></audio>
    <div class="now-playing">
      <img id="np-img" src="${NO_IMG}" alt="">
      <div class="np-text">
        <div id="np-title">Sélectionne un titre</div>
        <div id="np-artist">—</div>
        <span id="np-badge">—</span>
      </div>
    </div>
    <div class="player-center">
      <div class="ctrl">
        <i class="fa-solid fa-shuffle"  id="shuffleBtn" title="Aléatoire"></i>
        <i class="fa-solid fa-backward" id="prevBtn"    title="Précédent"></i>
        <button id="playPauseBtn"><i class="fa-solid fa-play" id="playPauseIcon"></i></button>
        <i class="fa-solid fa-forward"  id="nextBtn"    title="Suivant"></i>
        <i class="fa-solid fa-repeat"   id="repeatBtn"  title="Répéter"></i>
      </div>
      <div class="progress-wrap">
        <span id="timeCur">0:00</span>
        <input type="range" id="progressBar" value="0" min="0" step=".1">
        <span id="timeTotal">0:00</span>
      </div>
    </div>
    <div class="player-right">
      <div class="volume-wrap">
        <i class="fa-solid fa-volume-high" id="volIcon"></i>
        <input type="range" id="volumeBar" min="0" max="100" value="80">
      </div>
    </div>`;
  document.body.appendChild(el);
}

function initPlayer() {
  const audio       = document.getElementById('gAudio');
  const ppBtn       = document.getElementById('playPauseBtn');
  const ppIcon      = document.getElementById('playPauseIcon');
  const prevBtn     = document.getElementById('prevBtn');
  const nextBtn     = document.getElementById('nextBtn');
  const shuffleBtn  = document.getElementById('shuffleBtn');
  const repeatBtn   = document.getElementById('repeatBtn');
  const progressBar = document.getElementById('progressBar');
  const volumeBar   = document.getElementById('volumeBar');
  const timeCur     = document.getElementById('timeCur');
  const timeTotal   = document.getElementById('timeTotal');
  const npImg       = document.getElementById('np-img');
  const npTitle     = document.getElementById('np-title');
  const npArtist    = document.getElementById('np-artist');
  const npBadge     = document.getElementById('np-badge');
  if (!audio) return;

  // ─ Restaurer l'état sauvegardé ─
  loadPS();
  volumeBar.value = PlayerState.volume;
  audio.volume    = PlayerState.volume / 100;
  audio.loop      = PlayerState.repeat;
  shuffleBtn.classList.toggle('active-ctrl', PlayerState.shuffle);
  repeatBtn.classList.toggle('active-ctrl', PlayerState.repeat);

  if (PlayerState.src) {
    npImg.src           = PlayerState.img    || NO_IMG;
    npTitle.textContent = PlayerState.title  || '—';
    npArtist.textContent= PlayerState.artist || '—';
    npBadge.textContent = BADGE_LABELS[PlayerState.type] || 'Audio';

    // Reprendre à l'endroit où l'utilisateur était
    audio.src = PlayerState.src;
    audio.currentTime = PlayerState.time || 0;

    if (!PlayerState.paused) {
      // Autoplay peut être bloqué par le navigateur → on tente silencieusement
      audio.play().then(() => {
        ppIcon.className = 'fa-solid fa-pause';
        startPing();
      }).catch(() => {
        ppIcon.className = 'fa-solid fa-play';
        PlayerState.paused = true;
      });
    } else {
      ppIcon.className = 'fa-solid fa-play';
    }
  }

  // ─ Fonctions internes ─
  function setIcon(playing) {
    ppIcon.className = `fa-solid ${playing ? 'fa-pause' : 'fa-play'}`;
  }

  function playTrack(src, meta) {
    audio.src = src;
    audio.currentTime = 0;
    audio.play().catch(() => {});
    setIcon(true);

    // Mettre à jour l'affichage
    if (meta) {
      npImg.src             = meta.img    || NO_IMG;
      npTitle.textContent   = meta.title  || '—';
      npArtist.textContent  = meta.artist || '—';
      npBadge.textContent   = BADGE_LABELS[meta.type] || 'Audio';
      document.title        = `▶ ${meta.title} — Radio Chaâbi`;

      // Sauvegarder dans PlayerState
      PlayerState.src    = src;
      PlayerState.title  = meta.title  || '';
      PlayerState.artist = meta.artist || '';
      PlayerState.type   = meta.type   || 'songs';
      PlayerState.img    = meta.img    || NO_IMG;
      PlayerState.time   = 0;
      PlayerState.paused = false;
      savePS();

      // Envoyer à la barre live
      livePlay(meta);
      startPing();
    }
  }

  // ─ API publique (appelée par les pages) ─
  window.rcPlay = function (src, meta, items, idx, type) {
    if (items)     PlayerState.items = items;
    if (idx != null) PlayerState.idx = idx;
    if (type)      PlayerState.type  = type;
    if (meta)      meta.type = type || meta.type;
    playTrack(src, meta);
  };

  // ─ Contrôles ─
  ppBtn.addEventListener('click', () => {
    if (!audio.src || audio.src === location.href) return;
    if (audio.paused) {
      audio.play().catch(() => {});
      setIcon(true);
      PlayerState.paused = false;
      startPing();
    } else {
      audio.pause();
      setIcon(false);
      PlayerState.paused = true;
      stopPing();
    }
    savePS();
  });

  function adjacent(dir) {
    const len = PlayerState.items.length;
    if (!len) return;
    if (PlayerState.shuffle) {
      PlayerState.idx = Math.floor(Math.random() * len);
    } else {
      PlayerState.idx = dir === 'next'
        ? (PlayerState.idx + 1) % len
        : (PlayerState.idx - 1 + len) % len;
    }
    const it = PlayerState.items[PlayerState.idx];
    if (!it) return;
    playTrack(it.audio_url, {
      img:    it.image_url  || NO_IMG,
      title:  it.titre      || it.artiste_nom || '—',
      artist: it.artiste_nom || '',
      type:   PlayerState.type,
    });
    rcApiIncrement(PlayerState.type, it.id, 'view');
  }

  nextBtn.addEventListener('click', () => adjacent('next'));
  prevBtn.addEventListener('click', () => {
    if (audio.currentTime > 3) { audio.currentTime = 0; return; }
    adjacent('prev');
  });
  shuffleBtn.addEventListener('click', () => {
    PlayerState.shuffle = !PlayerState.shuffle;
    shuffleBtn.classList.toggle('active-ctrl', PlayerState.shuffle);
    savePS();
    rcToast(PlayerState.shuffle ? 'Lecture aléatoire activée' : 'Désactivée');
  });
  repeatBtn.addEventListener('click', () => {
    PlayerState.repeat = !PlayerState.repeat;
    audio.loop = PlayerState.repeat;
    repeatBtn.classList.toggle('active-ctrl', PlayerState.repeat);
    savePS();
    rcToast(PlayerState.repeat ? 'Répétition activée' : 'Désactivée');
  });

  // ─ Progression ─
  audio.addEventListener('timeupdate', () => {
    if (audio.duration) progressBar.value = audio.currentTime;
    timeCur.textContent = fmtTime(audio.currentTime);
    // Sauvegarder la position toutes les 5s
    if (Math.round(audio.currentTime) % 5 === 0) {
      PlayerState.time = audio.currentTime;
      savePS();
    }
  });
  audio.addEventListener('loadedmetadata', () => {
    progressBar.max = audio.duration;
    timeTotal.textContent = fmtTime(audio.duration);
  });
  audio.addEventListener('ended', () => {
    if (!PlayerState.repeat) adjacent('next');
  });
  progressBar.addEventListener('input', () => {
    audio.currentTime = progressBar.value;
    timeCur.textContent = fmtTime(audio.currentTime);
  });

  // ─ Volume ─
  volumeBar.addEventListener('input', () => {
    audio.volume = volumeBar.value / 100;
    PlayerState.volume = +volumeBar.value;
    savePS();
    const vi = document.getElementById('volIcon');
    if (vi) vi.className = `fa-solid ${audio.volume === 0 ? 'fa-volume-xmark' : audio.volume < .5 ? 'fa-volume-low' : 'fa-volume-high'}`;
  });

  // ─ Clavier ─
  document.addEventListener('keydown', e => {
    if (['INPUT', 'TEXTAREA', 'SELECT'].includes(e.target.tagName)) return;
    if (e.code === 'Space')      { e.preventDefault(); ppBtn.click(); }
    if (e.code === 'ArrowRight') nextBtn.click();
    if (e.code === 'ArrowLeft')  prevBtn.click();
  });

  // ─ Arrêter live quand la page se ferme ─
  window.addEventListener('pagehide', () => {
    PlayerState.time   = audio.currentTime;
    PlayerState.paused = audio.paused;
    savePS();
    // arrêter le live proprement si en pause
    if (audio.paused) liveStop();
  });
}

// ════════════════════════════════════════════════════════════════
//  NAVBAR
// ════════════════════════════════════════════════════════════════
function injectNavHTML() {
  const el = document.getElementById('navbar');
  if (!el) return;
  el.innerHTML = `
    <div class="nav-inner">
      <a class="nav-logo" href="accueil.html">
        <div class="logo-icon"><i class="fa-solid fa-tower-broadcast"></i></div>
        <div class="logo-text">
          <span class="logo-main">Radio</span>
          <span class="logo-sub">Chaâbi</span>
        </div>
      </a>
      <ul class="nav-links">
        <li><a href="accueil.html"    class="nav-link"><i class="fa-solid fa-house"></i> Accueil</a></li>
        <li><a href="artistes.html"   class="nav-link"><i class="fa-solid fa-user-music"></i> Artistes</a></li>
        <li><a href="chansons.html"   class="nav-link"><i class="fa-solid fa-headphones"></i> Chansons</a></li>
        <li><a href="emissions.html"  class="nav-link"><i class="fa-solid fa-radio"></i> Émissions</a></li>
        <li><a href="interviews.html" class="nav-link"><i class="fa-solid fa-microphone-lines"></i> Interviews</a></li>
        <li><a href="bouqalla.html"   class="nav-link"><i class="fa-solid fa-scroll"></i> Bouqalla</a></li>
      </ul>
      <div class="nav-search">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" id="navSearchInput" placeholder="Rechercher…" autocomplete="off">
      </div>
      <div class="nav-actions">
        <a href="chansons.html" class="nav-cta"><i class="fa-solid fa-headphones"></i> Écouter</a>
        <button class="burger" id="burgerBtn"><span></span><span></span><span></span></button>
      </div>
    </div>
    <div class="mobile-menu" id="mobileMenu">
      <a href="accueil.html"    class="mob-link"><i class="fa-solid fa-house"></i> Accueil</a>
      <a href="artistes.html"   class="mob-link"><i class="fa-solid fa-user-music"></i> Artistes</a>
      <a href="chansons.html"   class="mob-link"><i class="fa-solid fa-headphones"></i> Chansons</a>
      <a href="emissions.html"  class="mob-link"><i class="fa-solid fa-radio"></i> Émissions</a>
      <a href="interviews.html" class="mob-link"><i class="fa-solid fa-microphone-lines"></i> Interviews</a>
      <a href="bouqalla.html"   class="mob-link"><i class="fa-solid fa-scroll"></i> Bouqalla</a>
    </div>`;
}

function initNavbar() {
  const navbar  = document.getElementById('navbar');
  const burger  = document.getElementById('burgerBtn');
  const mobMenu = document.getElementById('mobileMenu');
  const searchI = document.getElementById('navSearchInput');
  if (!navbar) return;

  window.addEventListener('scroll', () => {
    navbar.classList.toggle('scrolled', window.scrollY > 10);
  }, { passive: true });

  if (burger && mobMenu) {
    burger.addEventListener('click', () => {
      burger.classList.toggle('open');
      mobMenu.classList.toggle('open');
    });
    document.addEventListener('click', e => {
      if (!e.target.closest('.navbar')) {
        burger.classList.remove('open');
        mobMenu.classList.remove('open');
      }
    });
  }

  // Lien actif
  const page = location.pathname.split('/').pop() || 'accueil.html';
  document.querySelectorAll('.nav-link, .mob-link').forEach(a => {
    const href = a.getAttribute('href') || '';
    a.classList.toggle('active',
      href.includes(page) || (page === 'accueil.html' && href.includes('accueil'))
    );
  });

  if (searchI) {
    searchI.addEventListener('keydown', e => {
      if (e.key === 'Enter' && searchI.value.trim()) {
        window.location.href = `chansons.html?q=${encodeURIComponent(searchI.value.trim())}`;
      }
    });
  }

  const yearEl = document.getElementById('year');
  if (yearEl) yearEl.textContent = new Date().getFullYear();
}

// ════════════════════════════════════════════════════════════════
//  FOOTER
// ════════════════════════════════════════════════════════════════
function injectFooterHTML() {
  const el = document.getElementById('footer');
  if (!el) return;
  el.className = 'footer';
  el.innerHTML = `
    <div class="footer-body">
      <div class="footer-brand">
        <div class="footer-logo">
          <div class="logo-icon"><i class="fa-solid fa-tower-broadcast"></i></div>
          <div class="logo-text">
            <span class="logo-main">Radio</span>
            <span class="logo-sub">Chaâbi</span>
          </div>
        </div>
        <p>La première radio dédiée à la musique chaâbi algérienne. Un patrimoine musical vivant, préservé et partagé avec passion.</p>
        <div class="social-icons">
          <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
          <a href="#" aria-label="YouTube"><i class="fa-brands fa-youtube"></i></a>
          <a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
          <a href="#" aria-label="TikTok"><i class="fa-brands fa-tiktok"></i></a>
        </div>
      </div>
      <div class="footer-col">
        <h4>Navigation</h4>
        <a href="accueil.html">Accueil</a>
        <a href="artistes.html">Artistes</a>
        <a href="chansons.html">Chansons</a>
        <a href="emissions.html">Émissions</a>
        <a href="interviews.html">Interviews</a>
        <a href="bouqalla.html">Bouqalla</a>
      </div>
      <div class="footer-col">
        <h4>Catégories</h4>
        <a href="chansons.html?cat=1">Chaâbi</a>
        <a href="chansons.html?cat=4">Andalou</a>
        <a href="chansons.html?cat=6">Hawzi</a>
        <a href="chansons.html?cat=7">Malouf</a>
        <a href="chansons.html?cat=2">Fêtes</a>
      </div>
      <div class="footer-col">
        <h4>Contact</h4>
        <p class="footer-contact"><i class="fa-solid fa-envelope"></i> contact@radiochaabi.dz</p>
        <p class="footer-contact"><i class="fa-solid fa-phone"></i> +213 XX XX XX XX</p>
        <p class="footer-contact"><i class="fa-solid fa-location-dot"></i> Alger, Algérie</p>
      </div>
    </div>
    <div class="footer-bottom">
      <p>© <span id="year"></span> Radio Chaâbi — Tous droits réservés</p>
      <p>Fait avec <i class="fa-solid fa-heart" style="color:var(--nav-acc)"></i> pour la musique algérienne</p>
    </div>`;
}

// ════════════════════════════════════════════════════════════════
//  BOOT — ordre précis d'initialisation
// ════════════════════════════════════════════════════════════════
document.addEventListener('DOMContentLoaded', () => {
  // 1. Barre live en tout premier (au-dessus de tout)
  injectLiveBar();

  // 2. Navbar et footer
  injectNavHTML();
  injectFooterHTML();

  // 3. Player
  injectPlayerHTML();
  initNavbar();
  initPlayer();

  // 4. Effets
  initReveal();

  // 5. Démarrer le polling live
  startLivePolling();
});
