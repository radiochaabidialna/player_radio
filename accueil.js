'use strict';

// ════════════════════════════════════════════════
//  CONFIG
// ════════════════════════════════════════════════
const API      = './api/media.php';
const LIVE_API = './api/live.php';
const NO_IMG   = '/music/img_chaabi/default.png';

// ════════════════════════════════════════════════
//  HELPERS
// ════════════════════════════════════════════════
const esc = str => { const d = document.createElement('div'); d.textContent = str ?? ''; return d.innerHTML; };
const fmt = n   => Number(n || 0).toLocaleString('fr-FR');

async function api(params) {
  try {
    const r = await fetch(`${API}?${new URLSearchParams(params)}`);
    const j = await r.json();
    if (!j.success) throw new Error(j.error || 'Erreur API');
    return j.data;
  } catch (e) { console.error('[API]', e.message); return null; }
}

function skeleton(n, cls = 'song-card') {
  return Array.from({ length: n }, () =>
    `<div class="${cls} skeleton" style="height:240px"></div>`).join('');
}

// ════════════════════════════════════════════════
//  ██  LIVE BAR  ██
//  3 actions : play → ping (toutes les 20s) → stop
// ════════════════════════════════════════════════

let _pingInterval = null;

// ── 1. Envoyer "je lis ce média" au serveur ──────
async function livePlay(title, artist, type) {
  if (!title) return;
  try {
    const res = await fetch(LIVE_API + '?action=play', {
      method:  'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ title, artist: artist || '', type: type || 'songs' }),
    });
    const j = await res.json();
    console.log('[LIVE] play →', j);   // <- vérifier dans la console navigateur
    livePoll();                          // rafraîchir la barre tout de suite
  } catch (e) {
    console.error('[LIVE] play error', e);
  }
}

// ── 2. Heartbeat : renouveler toutes les 20 s ────
function liveStartPing() {
  liveStopPing();
  _pingInterval = setInterval(async () => {
    try { await fetch(LIVE_API + '?action=ping'); } catch (_) {}
  }, 20000);
}
function liveStopPing() {
  if (_pingInterval) { clearInterval(_pingInterval); _pingInterval = null; }
}

// ── 3. Arrêt de lecture ──────────────────────────
async function liveStop() {
  liveStopPing();
  try {
    await fetch(LIVE_API + '?action=stop');
    setTimeout(livePoll, 600);
  } catch (_) {}
}

// ── 4. Lecture du feed et affichage ─────────────
async function livePoll() {
  try {
    const r = await fetch(LIVE_API + '?action=feed');
    const j = await r.json();
    if (j.success) liveRender(j.data);
  } catch (_) {}
}

function liveRender(data) {
  const ticker  = document.getElementById('liveTicker');
  const countEl = document.getElementById('liveCount');
  if (!ticker) return;

  const count   = data.count   || 0;
  const entries = data.entries || [];

  if (countEl) {
    countEl.textContent = count === 0 ? '0 auditeur'
      : count === 1 ? '1 auditeur'
      : `${count} auditeurs`;
  }

  if (!entries.length) {
    ticker.innerHTML = '<span class="live-empty">Aucune écoute en cours…</span>';
    ticker.style.animation = 'none';
    return;
  }

  const html = entries.map(e =>
    `<span class="live-item">
       <span class="live-item-icon">${e.icon || '🎵'}</span>
       <span class="live-item-text">
         <span class="live-item-type">${esc(e.label || 'Audio')}</span>
         <span class="live-item-title">${esc(e.titre || '—')}${e.artiste ? ' — ' + esc(e.artiste) : ''}</span>
       </span>
     </span><span class="live-sep">◆</span>`
  ).join('');

  ticker.innerHTML = html + html;   // dupliquer pour boucle infinie fluide

  const dur = Math.min(90, Math.max(20, entries.length * 8));
  ticker.style.setProperty('--ticker-duration', `${dur}s`);
  ticker.style.animation = `ticker-scroll ${dur}s linear infinite`;
}

// ── 5. Polling automatique toutes les 8 s ───────
function liveStartPolling() {
  livePoll();
  setInterval(livePoll, 8000);
}

// ════════════════════════════════════════════════
//  ██  MINI PLAYER  ██
//  Chaque action de lecture appelle livePlay()
// ════════════════════════════════════════════════
const miniPlayer   = document.getElementById('miniPlayer');
const miniAudio    = document.getElementById('miniAudio');
const miniImg      = document.getElementById('mini-img');
const miniTitle    = document.getElementById('mini-title');
const miniArtist   = document.getElementById('mini-artist');
const miniPlay     = document.getElementById('miniPlay');
const miniPlayIcon = document.querySelector('#miniPlay i');
const miniClose    = document.getElementById('miniClose');

/**
 * Lance la lecture + notifie la barre live.
 * @param {string} audioUrl
 * @param {string} imgUrl
 * @param {string} title
 * @param {string} artist
 * @param {string} type  'songs' | 'emissions' | 'interviews'
 */
function playMini(audioUrl, imgUrl, title, artist, type) {
  if (!audioUrl) { console.warn('[PLAYER] Pas d\'URL audio'); return; }

  miniAudio.src          = audioUrl;
  miniImg.src            = imgUrl || NO_IMG;
  miniTitle.textContent  = title  || '—';
  miniArtist.textContent = artist || '—';

  miniAudio.play()
    .then(() => console.log('[PLAYER] Lecture OK:', title))
    .catch(e => console.error('[PLAYER] Erreur lecture:', e));

  miniPlayIcon.className = 'fa-solid fa-pause';
  miniPlayer.classList.add('show');

  // ✅ NOTIFIER LA BARRE LIVE
  livePlay(title, artist, type || 'songs');
  liveStartPing();
}

// Pause / Reprise
miniPlay.addEventListener('click', () => {
  if (miniAudio.paused) {
    miniAudio.play().catch(() => {});
    miniPlayIcon.className = 'fa-solid fa-pause';
    liveStartPing();
  } else {
    miniAudio.pause();
    miniPlayIcon.className = 'fa-solid fa-play';
    liveStopPing();
  }
});

// Fermeture
miniClose.addEventListener('click', () => {
  miniAudio.pause();
  miniPlayer.classList.remove('show');
  liveStop();
});

// Fin naturelle de la piste
miniAudio.addEventListener('ended', () => {
  miniPlayIcon.className = 'fa-solid fa-play';
  liveStop();
});

// Fermeture de l'onglet
window.addEventListener('pagehide', () => {
  if (!miniAudio.paused) liveStop();
});

// ════════════════════════════════════════════════
//  NAVBAR
// ════════════════════════════════════════════════
const navbar     = document.getElementById('navbar');
const burgerBtn  = document.getElementById('burgerBtn');
const mobileMenu = document.getElementById('mobileMenu');

window.addEventListener('scroll', () =>
  navbar.classList.toggle('scrolled', window.scrollY > 10),
{ passive: true });

burgerBtn.addEventListener('click', () => {
  burgerBtn.classList.toggle('open');
  mobileMenu.classList.toggle('open');
});
document.addEventListener('click', e => {
  if (!e.target.closest('.navbar')) {
    burgerBtn.classList.remove('open');
    mobileMenu.classList.remove('open');
  }
});

document.getElementById('year').textContent = new Date().getFullYear();

// ── Recherche ─────────────────────────────────────
const searchToggle  = document.getElementById('searchToggle');
const searchBar     = document.getElementById('searchBar');
const searchClose   = document.getElementById('searchClose');
const globalSearch  = document.getElementById('globalSearch');
const searchResults = document.getElementById('searchResults');
let searchTimer = null;

searchToggle.addEventListener('click', () => {
  searchBar.classList.toggle('open');
  if (searchBar.classList.contains('open')) globalSearch.focus();
});
searchClose.addEventListener('click', () => {
  searchBar.classList.remove('open');
  searchResults.innerHTML = '';
  globalSearch.value = '';
});
document.addEventListener('keydown', e => {
  if (e.key === 'Escape') searchClose.click();
});

globalSearch.addEventListener('input', () => {
  clearTimeout(searchTimer);
  const q = globalSearch.value.trim();
  if (!q) { searchResults.innerHTML = ''; return; }
  searchTimer = setTimeout(() => runSearch(q), 350);
});

async function runSearch(q) {
  const [songs, emissions, interviews] = await Promise.all([
    api({ type: 'songs',      action: 'list', q, limit: 4 }),
    api({ type: 'emissions',  action: 'list', q, limit: 2 }),
    api({ type: 'interviews', action: 'list', q, limit: 2 }),
  ]);

  const results = [
    ...(songs?.items      || []).map(i => ({ ...i, _type: 'songs',      _label: 'Chanson'   })),
    ...(emissions?.items  || []).map(i => ({ ...i, _type: 'emissions',  _label: 'Émission'  })),
    ...(interviews?.items || []).map(i => ({ ...i, _type: 'interviews', _label: 'Interview' })),
  ];

  if (!results.length) {
    searchResults.innerHTML = `<p style="padding:12px;font-size:.82rem;color:var(--t3)">Aucun résultat pour « ${esc(q)} »</p>`;
    return;
  }

  searchResults.innerHTML = results.map(it => `
    <div class="search-result-item"
         data-audio="${esc(it.audio_url || '')}"
         data-img="${esc(it.image_url || NO_IMG)}"
         data-title="${esc(it.titre || it.artiste_nom || '—')}"
         data-artist="${esc(it.artiste_nom || '')}"
         data-type="${it._type}">
      <img src="${esc(it.image_url || NO_IMG)}" alt="" onerror="this.src='${NO_IMG}'">
      <div class="sri-text">
        <p>${esc(it.titre || it.artiste_nom || '—')}</p>
        <p>${esc(it.artiste_nom || '')}</p>
      </div>
      <span class="sri-badge">${it._label}</span>
    </div>
  `).join('');

  searchResults.querySelectorAll('.search-result-item').forEach(el => {
    el.addEventListener('click', () => {
      playMini(el.dataset.audio, el.dataset.img, el.dataset.title, el.dataset.artist, el.dataset.type);
      searchClose.click();
    });
  });
}

// ════════════════════════════════════════════════
//  SCROLL REVEAL
// ════════════════════════════════════════════════
function initReveal() {
  const obs = new IntersectionObserver(entries => {
    entries.forEach(e => { if (e.isIntersecting) { e.target.classList.add('visible'); obs.unobserve(e.target); } });
  }, { threshold: 0.12 });
  document.querySelectorAll('.home-section').forEach(s => { s.classList.add('reveal'); obs.observe(s); });
}

// ════════════════════════════════════════════════
//  STATS
// ════════════════════════════════════════════════
function animCount(el, target) {
  const start = Date.now();
  const tick  = () => {
    const p = Math.min((Date.now() - start) / 1200, 1);
    el.textContent = fmt(Math.round(target * (1 - Math.pow(1 - p, 3))));
    if (p < 1) requestAnimationFrame(tick);
  };
  requestAnimationFrame(tick);
}

async function loadStats() {
  const s = await api({ action: 'stats' });
  if (!s) return;
  document.querySelectorAll('.stat-num, .hstat-num').forEach(el => {
    if (s[el.dataset.key] !== undefined) animCount(el, s[el.dataset.key]);
  });
}

// ════════════════════════════════════════════════
//  TOP CHANSONS
// ════════════════════════════════════════════════
async function loadTopSongs() {
  const g = document.getElementById('topSongsGrid');
  g.innerHTML = skeleton(8, 'song-card');
  const songs = await api({ type: 'songs', action: 'top', limit: 8 });
  if (!songs?.length) { g.innerHTML = '<p style="color:var(--t3);grid-column:1/-1;padding:20px">Aucune chanson.</p>'; return; }

  g.innerHTML = songs.map((s, i) => `
    <div class="song-card"
         data-audio="${esc(s.audio_url)}" data-img="${esc(s.image_url || NO_IMG)}"
         data-title="${esc(s.titre)}"     data-artist="${esc(s.artiste_nom || '')}">
      <div class="song-card-thumb">
        <img src="${esc(s.image_url || NO_IMG)}" alt="${esc(s.titre)}" loading="lazy" onerror="this.src='${NO_IMG}'">
        <div class="song-card-play"><i class="fa-solid fa-play"></i></div>
        <span class="song-card-rank">#${i + 1}</span>
      </div>
      <div class="song-card-body">
        <p class="song-card-title">${esc(s.titre)}</p>
        <p class="song-card-artist">${esc(s.artiste_nom || 'Artiste inconnu')}</p>
        <div class="song-card-meta">
          <span class="song-card-cat">${esc(s.categorie_nom || 'Chaâbi')}</span>
          <span class="song-card-views"><i class="fa-regular fa-eye"></i> ${fmt(s.views)}</span>
        </div>
      </div>
    </div>`).join('');

  g.querySelectorAll('.song-card').forEach(c =>
    c.addEventListener('click', () =>
      playMini(c.dataset.audio, c.dataset.img, c.dataset.title, c.dataset.artist, 'songs')
    )
  );
}

// ════════════════════════════════════════════════
//  TOP ARTISTES
// ════════════════════════════════════════════════
async function loadTopArtists() {
  const r = document.getElementById('topArtistsRow');
  r.innerHTML = skeleton(8, 'artist-card');
  const artists = await api({ type: 'artistes', action: 'top', limit: 8 });
  if (!artists?.length) { r.innerHTML = '<p style="color:var(--t3)">Aucun artiste.</p>'; return; }

  r.innerHTML = artists.map(a => `
    <div class="artist-card">
      <div class="artist-avatar">
        <div class="artist-avatar-ring"></div>
        <img src="${esc(a.image_url || NO_IMG)}" alt="${esc(a.nom)}" loading="lazy" onerror="this.src='${NO_IMG}'">
      </div>
      <p class="artist-name">${esc(a.nom)}</p>
      <p class="artist-meta"><i class="fa-solid fa-music"></i> <span>${fmt(a.nb_chansons)} chanson${a.nb_chansons > 1 ? 's' : ''}</span></p>
    </div>`).join('');
}

// ════════════════════════════════════════════════
//  ÉMISSIONS RÉCENTES
// ════════════════════════════════════════════════
async function loadEmissions() {
  const g = document.getElementById('emissionsGrid');
  g.innerHTML = skeleton(6, 'media-card');
  const data = await api({ type: 'emissions', action: 'recent', limit: 6 });
  if (!data?.length) { g.innerHTML = '<p style="color:var(--t3)">Aucune émission.</p>'; return; }

  g.innerHTML = data.map(e => `
    <div class="media-card"
         data-audio="${esc(e.audio_url)}" data-img="${esc(e.image_url || NO_IMG)}"
         data-title="${esc(e.titre)}"     data-artist="${esc(e.artiste_nom || '')}">
      <div class="media-card-thumb">
        <img src="${esc(e.image_url || NO_IMG)}" alt="${esc(e.titre)}" loading="lazy" onerror="this.src='${NO_IMG}'">
        <div class="media-card-overlay"></div>
        <span class="media-card-badge badge-emission">
          <i class="fa-solid fa-radio"></i>
          ${e.numero_emission ? 'Ém. ' + e.numero_emission : 'Émission'}
        </span>
        <button class="media-card-play-btn"><i class="fa-solid fa-play"></i></button>
      </div>
      <div class="media-card-body">
        <p class="media-card-title">${esc(e.titre)}</p>
        <p class="media-card-desc">${esc(e.description || '')}</p>
        <div class="media-card-foot">
          <span class="media-card-who"><i class="fa-solid fa-circle-user"></i> ${esc(e.artiste_nom)}</span>
          <div class="media-card-stats">
            <span><i class="fa-regular fa-eye"></i> ${fmt(e.views)}</span>
            <span><i class="fa-regular fa-heart"></i> ${fmt(e.likes)}</span>
            ${e.date_fmt ? `<span><i class="fa-regular fa-calendar"></i> ${esc(e.date_fmt)}</span>` : ''}
          </div>
        </div>
      </div>
    </div>`).join('');

  g.querySelectorAll('.media-card').forEach(c =>
    c.addEventListener('click', () =>
      playMini(c.dataset.audio, c.dataset.img, c.dataset.title, c.dataset.artist, 'emissions')
    )
  );
}

// ════════════════════════════════════════════════
//  INTERVIEWS RÉCENTES
// ════════════════════════════════════════════════
async function loadInterviews() {
  const g = document.getElementById('interviewsGrid');
  g.innerHTML = skeleton(6, 'interview-card');
  const data = await api({ type: 'interviews', action: 'recent', limit: 6 });
  if (!data?.length) { g.innerHTML = '<p style="color:var(--t3)">Aucune interview.</p>'; return; }

  g.innerHTML = data.map(i => `
    <div class="interview-card"
         data-audio="${esc(i.audio_url)}" data-img="${esc(i.image_url || NO_IMG)}"
         data-title="${esc(i.titre)}"     data-artist="${esc(i.artiste_nom || '')}">
      <img class="interview-avatar" src="${esc(i.image_url || NO_IMG)}" alt="${esc(i.titre)}"
           loading="lazy" onerror="this.src='${NO_IMG}'">
      <div class="interview-body">
        <p class="interview-title">${esc(i.titre)}</p>
        <div class="interview-meta">
          <span class="media-card-badge badge-interview" style="position:static;display:inline-block">Interview</span>
          ${i.date_fmt ? `<span><i class="fa-regular fa-calendar"></i> ${esc(i.date_fmt)}</span>` : ''}
        </div>
        <div class="interview-stats">
          <span><i class="fa-regular fa-eye"></i> ${fmt(i.views)}</span>
          <span><i class="fa-regular fa-heart"></i> ${fmt(i.likes)}</span>
        </div>
      </div>
      <button class="interview-play"><i class="fa-solid fa-play"></i></button>
    </div>`).join('');

  g.querySelectorAll('.interview-card').forEach(c =>
    c.addEventListener('click', () =>
      playMini(c.dataset.audio, c.dataset.img, c.dataset.title, c.dataset.artist, 'interviews')
    )
  );
}

// ════════════════════════════════════════════════
//  DÉDICACES
// ════════════════════════════════════════════════
async function loadDedicaces() {
  const g = document.getElementById('dedicacesGrid');
  g.innerHTML = skeleton(6, 'dedicace-card');
  const data = await api({ type: 'dedicaces', action: 'recent', limit: 6 });
  if (!data?.length) { g.innerHTML = '<p style="color:var(--t3)">Aucune dédicace.</p>'; return; }

  g.innerHTML = data.map(d => `
    <div class="dedicace-card">
      <div class="ded-header">
        <div>
          <p class="ded-from"><i class="fa-solid fa-user"></i> ${esc(d.nom)}</p>
          <p class="ded-arrow"><i class="fa-solid fa-arrow-right"></i> Pour ${esc(d.pour)}</p>
        </div>
        <span class="ded-date">${esc(d.date_fmt)}</span>
      </div>
      <p class="ded-message">${esc(d.description)}</p>
      <div class="ded-footer"><span class="ded-like"><i class="fa-solid fa-heart"></i> ${fmt(d.likes)}</span></div>
    </div>`).join('');
}

// ════════════════════════════════════════════════
//  BOUQALLA PREVIEW
// ════════════════════════════════════════════════
async function loadBouqallaPreview() {
  const g = document.getElementById('bouqallaPreview');
  if (!g) return;
  g.innerHTML = skeleton(3, 'bq-preview-card');
  const data = await api({ type: 'bouqalla', action: 'list', limit: 3, offset: 0 });
  if (!data?.items?.length) { g.innerHTML = '<p style="color:var(--t3)">Aucune bouqalla.</p>'; return; }

  g.innerHTML = data.items.map(b => `
    <a href="bouqalla.html" class="bq-preview-card">
      <div class="bq-p-num"><i class="fa-solid fa-scroll"></i> Bouqalla N° ${b.num || ''}</div>
      ${b.arabe    ? `<div class="bq-p-ar" dir="rtl" lang="ar">${esc(b.arabe)}</div>` : ''}
      ${b.phonetic ? `<div class="bq-p-ph">${esc(b.phonetic)}</div>` : ''}
      ${b['français'] ? `<div class="bq-p-fr">${esc(b['français'])}</div>` : ''}
    </a>`).join('');
}

// ════════════════════════════════════════════════
//  INIT
// ════════════════════════════════════════════════
async function init() {
  initReveal();

  // ✅ Démarrer le polling live EN PREMIER
  liveStartPolling();

  await Promise.all([
    loadStats(),
    loadTopSongs(),
    loadTopArtists(),
    loadEmissions(),
    loadInterviews(),
    loadDedicaces(),
    loadBouqallaPreview(),
  ]);
}

init();