'use strict';

// ════════════════════════════════════════════════
//  CONFIG
// ════════════════════════════════════════════════
const API      = './api/media.php';
const LIVE_API = './api/live.php';
const NO_IMG   = '/music/img_chaabi/default.png';

// ════════════════════════════════════════════════
//  BARRE LIVE — polling toutes les 8s
// ════════════════════════════════════════════════
function updateLiveBar(data) {
  const bar      = document.getElementById('rcLiveBar');
  const ticker   = document.getElementById('liveTicker');
  const countEl  = document.getElementById('liveCount');
  if (!bar || !ticker) return;

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

  const esc2 = str => {
    const d = document.createElement('div');
    d.textContent = str ?? '';
    return d.innerHTML;
  };

  const buildItem = e => {
    const icon   = e.icon   || '🎵';
    const label  = e.label  || 'Audio';
    const title  = e.titre  || '—';
    const artist = e.artiste ? ` — ${e.artiste}` : '';
    return `<span class="live-item">
      <span class="live-item-icon">${icon}</span>
      <span class="live-item-text">
        <span class="live-item-type">${esc2(label)}</span>
        <span class="live-item-title">${esc2(title)}${esc2(artist)}</span>
      </span>
    </span>
    <span class="live-sep">◆</span>`;
  };

  const html = entries.map(buildItem).join('');
  ticker.innerHTML = html + html; // duplication pour boucle infinie

  const dur = Math.min(90, Math.max(20, entries.length * 6));
  ticker.style.setProperty('--ticker-duration', `${dur}s`);
  ticker.style.animation = `ticker-scroll ${dur}s linear infinite`;
}

async function pollLiveFeed() {
  try {
    const r = await fetch(`${LIVE_API}?action=feed`);
    const j = await r.json();
    if (j.success) updateLiveBar(j.data);
  } catch (_) {}
}

function startLivePolling() {
  pollLiveFeed();                              // appel immédiat
  setInterval(pollLiveFeed, 8000);             // puis toutes les 8s
}


// ════════════════════════════════════════════════
//  HELPERS
// ════════════════════════════════════════════════
const esc = str => {
  const d = document.createElement('div');
  d.textContent = str ?? '';
  return d.innerHTML;
};
const fmt = n => Number(n || 0).toLocaleString('fr-FR');

async function api(params) {
  try {
    const url  = `${API}?${new URLSearchParams(params)}`;
    const res  = await fetch(url);
    const json = await res.json();
    if (!json.success) throw new Error(json.error || 'Erreur API');
    return json.data;
  } catch (e) {
    console.error('[API]', e.message);
    return null;
  }
}

function skeleton(n, cls = 'song-card') {
  return Array.from({ length: n }, () =>
    `<div class="${cls} skeleton" style="height:240px"></div>`
  ).join('');
}

// ════════════════════════════════════════════════
//  NAVBAR
// ════════════════════════════════════════════════
const navbar    = document.getElementById('navbar');
const burgerBtn = document.getElementById('burgerBtn');
const mobileMenu = document.getElementById('mobileMenu');

window.addEventListener('scroll', () => {
  navbar.classList.toggle('scrolled', window.scrollY > 10);
}, { passive: true });

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

// ── Recherche ────────────────────────────────────
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
  searchResults.innerHTML = `<p style="padding:10px;font-size:.8rem;color:var(--text-3)">Recherche en cours…</p>`;
  searchTimer = setTimeout(() => runSearch(q), 350);
});

async function runSearch(q) {
  const [songs, emissions, interviews] = await Promise.all([
    api({ type: 'songs',      action: 'list', q, limit: 4 }),
    api({ type: 'emissions',  action: 'list', q, limit: 2 }),
    api({ type: 'interviews', action: 'list', q, limit: 2 }),
  ]);

  const results = [
    ...(songs?.items      || []).map(i => ({ ...i, _type: 'songs',      label: 'Chanson'   })),
    ...(emissions?.items  || []).map(i => ({ ...i, _type: 'emissions',  label: 'Émission'  })),
    ...(interviews?.items || []).map(i => ({ ...i, _type: 'interviews', label: 'Interview' })),
  ];

  if (!results.length) {
    searchResults.innerHTML = `<p style="padding:12px;font-size:.82rem;color:var(--text-3)">Aucun résultat pour « ${esc(q)} »</p>`;
    return;
  }

  searchResults.innerHTML = results.map(item => `
    <div class="search-result-item"
         data-audio="${esc(item.audio_url || '')}"
         data-img="${esc(item.image_url || NO_IMG)}"
         data-title="${esc(item.titre || item.artiste_nom || '—')}"
         data-artist="${esc(item.artiste_nom || '—')}">
      <img src="${esc(item.image_url || NO_IMG)}" alt="" onerror="this.src='${NO_IMG}'">
      <div class="sri-text">
        <p>${esc(item.titre || item.artiste_nom || '—')}</p>
        <p>${esc(item.artiste_nom || '')}</p>
      </div>
      <span class="sri-badge">${item.label}</span>
    </div>
  `).join('');

  searchResults.querySelectorAll('.search-result-item').forEach(el => {
    el.addEventListener('click', () => {
      playMini(el.dataset.audio, el.dataset.img, el.dataset.title, el.dataset.artist);
      searchClose.click();
    });
  });
}

// ════════════════════════════════════════════════
//  MINI PLAYER
// ════════════════════════════════════════════════
const miniPlayer  = document.getElementById('miniPlayer');
const miniAudio   = document.getElementById('miniAudio');
const miniImg     = document.getElementById('mini-img');
const miniTitle   = document.getElementById('mini-title');
const miniArtist  = document.getElementById('mini-artist');
const miniPlay    = document.getElementById('miniPlay');
const miniPlayIcon = document.querySelector('#miniPlay i');
const miniClose   = document.getElementById('miniClose');

function playMini(audioUrl, imgUrl, title, artist) {
  if (!audioUrl) return;
  miniAudio.src    = audioUrl;
  miniImg.src      = imgUrl || NO_IMG;
  miniTitle.textContent  = title  || '—';
  miniArtist.textContent = artist || '—';
  miniAudio.play().catch(() => {});
  miniPlayIcon.className = 'fa-solid fa-pause';
  miniPlayer.classList.add('show');
}

miniPlay.addEventListener('click', () => {
  if (miniAudio.paused) {
    miniAudio.play().catch(() => {});
    miniPlayIcon.className = 'fa-solid fa-pause';
  } else {
    miniAudio.pause();
    miniPlayIcon.className = 'fa-solid fa-play';
  }
});

miniClose.addEventListener('click', () => {
  miniAudio.pause();
  miniPlayer.classList.remove('show');
});

miniAudio.addEventListener('ended', () => {
  miniPlayIcon.className = 'fa-solid fa-play';
});

// ════════════════════════════════════════════════
//  SCROLL REVEAL
// ════════════════════════════════════════════════
function initReveal() {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.classList.add('visible');
        observer.unobserve(e.target);
      }
    });
  }, { threshold: 0.12 });

  document.querySelectorAll('.home-section').forEach(s => {
    s.classList.add('reveal');
    observer.observe(s);
  });
}

// ════════════════════════════════════════════════
//  STATS + COMPTEUR ANIMÉ
// ════════════════════════════════════════════════
function animateCount(el, target) {
  const duration = 1200;
  const start    = Date.now();
  const startVal = 0;
  const update   = () => {
    const elapsed = Date.now() - start;
    const progress = Math.min(elapsed / duration, 1);
    const ease = 1 - Math.pow(1 - progress, 3);
    el.textContent = fmt(Math.round(startVal + (target - startVal) * ease));
    if (progress < 1) requestAnimationFrame(update);
  };
  requestAnimationFrame(update);
}

async function loadStats() {
  const stats = await api({ action: 'stats' });
  if (!stats) return;

  // Barre stats
  document.querySelectorAll('.stat-num').forEach(el => {
    const key = el.dataset.key;
    if (stats[key] !== undefined) animateCount(el, stats[key]);
  });

  // Hero stats
  document.querySelectorAll('.hstat-num').forEach(el => {
    const key = el.dataset.key;
    if (stats[key] !== undefined) animateCount(el, stats[key]);
  });
}

// ════════════════════════════════════════════════
//  TOP CHANSONS
// ════════════════════════════════════════════════
async function loadTopSongs() {
  const grid = document.getElementById('topSongsGrid');
  grid.innerHTML = skeleton(8, 'song-card');

  const songs = await api({ type: 'songs', action: 'top', limit: 8 });
  if (!songs?.length) {
    grid.innerHTML = '<p style="color:var(--text-3);grid-column:1/-1;padding:20px">Aucune chanson disponible.</p>';
    return;
  }

  grid.innerHTML = songs.map((s, i) => `
    <div class="song-card"
         data-audio="${esc(s.audio_url)}"
         data-img="${esc(s.image_url || NO_IMG)}"
         data-title="${esc(s.titre)}"
         data-artist="${esc(s.artiste_nom || '')}">
      <div class="song-card-thumb">
        <img src="${esc(s.image_url || NO_IMG)}" alt="${esc(s.titre)}"
             loading="lazy" onerror="this.src='${NO_IMG}'">
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
    </div>
  `).join('');

  grid.querySelectorAll('.song-card').forEach(card => {
    card.addEventListener('click', () => {
      playMini(card.dataset.audio, card.dataset.img, card.dataset.title, card.dataset.artist);
    });
  });
}

// ════════════════════════════════════════════════
//  TOP ARTISTES
// ════════════════════════════════════════════════
async function loadTopArtists() {
  const row = document.getElementById('topArtistsRow');
  row.innerHTML = skeleton(8, 'artist-card');

  const artists = await api({ type: 'artistes', action: 'top', limit: 8 });
  if (!artists?.length) {
    row.innerHTML = '<p style="color:var(--text-3)">Aucun artiste.</p>';
    return;
  }

  row.innerHTML = artists.map(a => `
    <div class="artist-card">
      <div class="artist-avatar">
        <div class="artist-avatar-ring"></div>
        <img src="${esc(a.image_url || NO_IMG)}" alt="${esc(a.nom)}"
             loading="lazy" onerror="this.src='${NO_IMG}'">
      </div>
      <p class="artist-name">${esc(a.nom)}</p>
      <p class="artist-meta">
        <i class="fa-solid fa-music"></i>
        <span>${fmt(a.nb_chansons)} chanson${a.nb_chansons > 1 ? 's' : ''}</span>
      </p>
    </div>
  `).join('');
}

// ════════════════════════════════════════════════
//  DERNIÈRES ÉMISSIONS
// ════════════════════════════════════════════════
async function loadEmissions() {
  const grid = document.getElementById('emissionsGrid');
  grid.innerHTML = skeleton(6, 'media-card');

  const data = await api({ type: 'emissions', action: 'recent', limit: 6 });
  if (!data?.length) {
    grid.innerHTML = '<p style="color:var(--text-3)">Aucune émission disponible.</p>';
    return;
  }

  grid.innerHTML = data.map(e => `
    <div class="media-card"
         data-audio="${esc(e.audio_url)}"
         data-img="${esc(e.image_url || NO_IMG)}"
         data-title="${esc(e.titre)}"
         data-artist="${esc(e.artiste_nom || '')}">
      <div class="media-card-thumb">
        <img src="${esc(e.image_url || NO_IMG)}" alt="${esc(e.titre)}"
             loading="lazy" onerror="this.src='${NO_IMG}'">
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
          <span class="media-card-who">
            <i class="fa-solid fa-circle-user"></i>
            ${esc(e.artiste_nom)}
          </span>
          <div class="media-card-stats">
            <span><i class="fa-regular fa-eye"></i> ${fmt(e.views)}</span>
            <span><i class="fa-regular fa-heart"></i> ${fmt(e.likes)}</span>
            ${e.date_fmt ? `<span><i class="fa-regular fa-calendar"></i> ${esc(e.date_fmt)}</span>` : ''}
          </div>
        </div>
      </div>
    </div>
  `).join('');

  grid.querySelectorAll('.media-card').forEach(card => {
    card.addEventListener('click', () => {
      playMini(card.dataset.audio, card.dataset.img, card.dataset.title, card.dataset.artist);
    });
  });
}

// ════════════════════════════════════════════════
//  INTERVIEWS
// ════════════════════════════════════════════════
async function loadInterviews() {
  const grid = document.getElementById('interviewsGrid');
  grid.innerHTML = skeleton(6, 'interview-card');

  const data = await api({ type: 'interviews', action: 'recent', limit: 6 });
  if (!data?.length) {
    grid.innerHTML = '<p style="color:var(--text-3)">Aucune interview disponible.</p>';
    return;
  }

  grid.innerHTML = data.map(i => `
    <div class="interview-card"
         data-audio="${esc(i.audio_url)}"
         data-img="${esc(i.image_url || NO_IMG)}"
         data-title="${esc(i.titre)}"
         data-artist="${esc(i.artiste_nom || '')}">
      <img class="interview-avatar"
           src="${esc(i.image_url || NO_IMG)}" alt="${esc(i.titre)}"
           loading="lazy" onerror="this.src='${NO_IMG}'">
      <div class="interview-body">
        <p class="interview-title">${esc(i.titre)}</p>
        <div class="interview-meta">
          <span class="media-card-badge badge-interview" style="position:static;display:inline-block">
            Interview
          </span>
          ${i.date_fmt ? `<span><i class="fa-regular fa-calendar"></i> ${esc(i.date_fmt)}</span>` : ''}
        </div>
        <div class="interview-stats">
          <span><i class="fa-regular fa-eye"></i> ${fmt(i.views)}</span>
          <span><i class="fa-regular fa-heart"></i> ${fmt(i.likes)}</span>
        </div>
      </div>
      <button class="interview-play" title="Écouter">
        <i class="fa-solid fa-play"></i>
      </button>
    </div>
  `).join('');

  grid.querySelectorAll('.interview-card').forEach(card => {
    card.addEventListener('click', () => {
      playMini(card.dataset.audio, card.dataset.img, card.dataset.title, card.dataset.artist);
    });
  });
}

// ════════════════════════════════════════════════
//  DÉDICACES
// ════════════════════════════════════════════════
async function loadDedicaces() {
  const grid = document.getElementById('dedicacesGrid');
  grid.innerHTML = skeleton(6, 'dedicace-card');

  const data = await api({ type: 'dedicaces', action: 'recent', limit: 6 });
  if (!data?.length) {
    grid.innerHTML = '<p style="color:var(--text-3)">Aucune dédicace disponible.</p>';
    return;
  }

  grid.innerHTML = data.map(d => `
    <div class="dedicace-card">
      <div class="ded-header">
        <div>
          <p class="ded-from"><i class="fa-solid fa-user"></i> ${esc(d.nom)}</p>
          <p class="ded-arrow"><i class="fa-solid fa-arrow-right"></i> Pour ${esc(d.pour)}</p>
        </div>
        <span class="ded-date">${esc(d.date_fmt)}</span>
      </div>
      <p class="ded-message">${esc(d.description)}</p>
      <div class="ded-footer">
        <span class="ded-like">
          <i class="fa-solid fa-heart"></i> ${fmt(d.likes)}
        </span>
      </div>
    </div>
  `).join('');
}

// ════════════════════════════════════════════════
//  BOUQALLA PREVIEW (3 proverbes)
// ════════════════════════════════════════════════
async function loadBouqallaPreview() {
  const grid = document.getElementById('bouqallaPreview');
  if (!grid) return;
  grid.innerHTML = skeleton(3, 'bq-preview-card');

  const data = await api({ type: 'bouqalla', action: 'list', limit: 3, offset: 0 });
  if (!data?.items?.length) {
    grid.innerHTML = '<p style="color:var(--t3)">Aucune bouqalla disponible.</p>';
    return;
  }

  grid.innerHTML = data.items.map(b => `
    <a href="bouqalla.html" class="bq-preview-card">
      <div class="bq-p-num"><i class="fa-solid fa-scroll"></i> Bouqalla N° ${b.num || ''}</div>
      ${b.arabe    ? `<div class="bq-p-ar" dir="rtl" lang="ar">${esc(b.arabe)}</div>` : ''}
      ${b.phonetic ? `<div class="bq-p-ph">${esc(b.phonetic)}</div>` : ''}
      ${b['français'] ? `<div class="bq-p-fr">${esc(b['français'])}</div>` : ''}
    </a>
  `).join('');
}


async function init() {
  initReveal();
  startLivePolling(); // ← démarrer le polling live-bar

  // Chargements parallèles
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
