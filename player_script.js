/**
 * Chaabi Music – script.js
 * Gère 3 sections (chansons / émissions / interviews)
 * avec un player audio partagé et persistant.
 */

'use strict';

// ════════════════════════════════════════════════
//  CONFIG
// ════════════════════════════════════════════════
const API_URL     = './api/player_media.php';
//const DEFAULT_IMG = '/music/images/default.jpg';

const CATEGORIES = [
  { id: 1, nom: 'Chaâbi' },
  { id: 2, nom: 'Fêtes' },
  { id: 3, nom: 'Émissions' },
  { id: 4, nom: 'Andalou' },
  { id: 5, nom: 'Interviews' },
  { id: 6, nom: 'Hawzi' },
  { id: 7, nom: 'Malouf' },
];

const BADGE_LABELS = {
  songs:      'Chanson',
  emissions:  'Émission',
  interviews: 'Interview',
};

const SECTION_ICONS = {
  songs:      'fa-headphones',
  emissions:  'fa-radio',
  interviews: 'fa-microphone-lines',
};

// ════════════════════════════════════════════════
//  ÉTAT GLOBAL
// ════════════════════════════════════════════════
/** @type {{ [key: string]: { items: any[], swiper: Swiper|null, index: number, cat: string, loaded: boolean } }} */
const state = {
  songs:      { items: [], swiper: null, index: 0, cat: '', loaded: false },
  emissions:  { items: [], swiper: null, index: 0, cat: '', loaded: false },
  interviews: { items: [], swiper: null, index: 0, cat: '', loaded: false },
};

let currentSection = 'songs'; // section active
let isShuffle      = false;
let isRepeat       = false;
let searchTimer    = null;

// ════════════════════════════════════════════════
//  DOM
// ════════════════════════════════════════════════
const audioPlayer   = document.getElementById('audioPlayer');
const progressBar   = document.getElementById('progress-bar');
const volumeRange   = document.getElementById('volume-range');
const playPauseBtn  = document.getElementById('playPauseBtn');
const playPauseIcon = document.getElementById('playPauseIcon');
const prevBtn       = document.getElementById('prevBtn');
const nextBtn       = document.getElementById('nextBtn');
const shuffleBtn    = document.getElementById('shuffleBtn');
const repeatBtn     = document.getElementById('repeatBtn');
const timeCurrent   = document.getElementById('time-current');
const timeTotal     = document.getElementById('time-total');
const playerImage   = document.getElementById('player-image');
const playerTitle   = document.getElementById('player-title');
const playerArtist  = document.getElementById('player-artist');
const playerBadge   = document.getElementById('player-badge');
const searchInput   = document.getElementById('searchInput');
const burgerBtn     = document.getElementById('burgerBtn');
const mobileMenu    = document.getElementById('mobileMenu');

audioPlayer.volume = volumeRange.value / 100;
document.getElementById('year').textContent = new Date().getFullYear();

// ════════════════════════════════════════════════
//  NAVIGATION
// ════════════════════════════════════════════════
function initNav() {
  // Desktop nav
  document.querySelectorAll('.nav-item').forEach(link => {
    link.addEventListener('click', e => {
      e.preventDefault();
      switchSection(link.dataset.section);
    });
  });

  // Mobile nav
  document.querySelectorAll('.mob-item').forEach(link => {
    link.addEventListener('click', e => {
      e.preventDefault();
      switchSection(link.dataset.section);
      closeMobileMenu();
    });
  });

  // Footer nav
  document.querySelectorAll('.footer-nav-link').forEach(link => {
    link.addEventListener('click', e => {
      e.preventDefault();
      switchSection(link.dataset.section);
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  });

  // Burger
  burgerBtn.addEventListener('click', toggleMobileMenu);
  document.addEventListener('click', e => {
    if (!e.target.closest('.navbar')) closeMobileMenu();
  });

  // Scroll → navbar shadow
  window.addEventListener('scroll', () => {
    document.getElementById('navbar').classList.toggle('scrolled', window.scrollY > 10);
  }, { passive: true });
}

function switchSection(name) {
  if (!state[name]) return;
  currentSection = name;

  // Sections
  document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
  document.getElementById(`sec-${name}`).classList.add('active');

  // Nav items
  document.querySelectorAll('.nav-item, .mob-item').forEach(a => {
    a.classList.toggle('active', a.dataset.section === name);
  });

  // Charger si pas encore fait
  if (!state[name].loaded) {
    loadSection(name);
  }

  // Vider la recherche
  searchInput.value = '';
}

function toggleMobileMenu() {
  mobileMenu.classList.toggle('open');
  burgerBtn.classList.toggle('open');
}

function closeMobileMenu() {
  mobileMenu.classList.remove('open');
  burgerBtn.classList.remove('open');
}

// ════════════════════════════════════════════════
//  FILTRES
// ════════════════════════════════════════════════
function buildFilters(section) {
  const container = document.getElementById(`filters-${section}`);
  container.innerHTML = '';

  const all = document.createElement('button');
  all.className = 'filter-btn active';
  all.dataset.cat = '';
  all.textContent = 'Tout';
  all.addEventListener('click', () => applyFilter(section, '', all));
  container.appendChild(all);

  CATEGORIES.forEach(cat => {
    const btn = document.createElement('button');
    btn.className = 'filter-btn';
    btn.dataset.cat = cat.id;
    btn.textContent = cat.nom;
    btn.addEventListener('click', () => applyFilter(section, cat.id, btn));
    container.appendChild(btn);
  });
}

function applyFilter(section, catId, clickedBtn) {
  document.querySelectorAll(`#filters-${section} .filter-btn`).forEach(b => b.classList.remove('active'));
  clickedBtn.classList.add('active');
  state[section].cat = catId;
  loadSection(section, catId);
}

// ════════════════════════════════════════════════
//  API FETCH
// ════════════════════════════════════════════════
async function fetchItems(type, catId = '', q = '') {
  const params = new URLSearchParams({ type, action: 'list', limit: 100 });
  if (catId) params.append('categorie_id', catId);
  if (q)     params.append('q', q);

  const res  = await fetch(`${API_URL}?${params}`);
  const json = await res.json();
  if (!json.success) throw new Error(json.error || 'Erreur API');
  return json.data.items;
}

async function apiIncrement(type, id, action) {
  try {
    await fetch(`${API_URL}?type=${type}&action=${action}&id=${id}`);
  } catch (_) {}
}

// ════════════════════════════════════════════════
//  CHARGEMENT + RENDU D'UNE SECTION
// ════════════════════════════════════════════════
async function loadSection(section, catId = '', q = '') {
  const pl = document.getElementById(`pl-${section}`);
  const sw = document.getElementById(`sw-${section}`);

  pl.innerHTML = '<p class="loading-msg"><i class="fa-solid fa-spinner fa-spin"></i> Chargement…</p>';
  sw.innerHTML = '<div class="swiper-slide skeleton-slide"><div class="skeleton-img"></div><div class="skeleton-title"></div></div>';

  try {
    const items = await fetchItems(section, catId, q);
    state[section].items  = items;
    state[section].index  = 0;
    state[section].loaded = true;

    buildSwiperSlides(section, items);
    buildPlaylistItems(section, items);
    initSwiper(section);

  } catch (err) {
    pl.innerHTML = `<p class="error-msg"><i class="fa-solid fa-triangle-exclamation"></i> Erreur : ${escHtml(err.message)}</p>`;
    sw.innerHTML = '';
  }
}

// ── SWIPER ──────────────────────────────────────
function buildSwiperSlides(section, items) {
  const wrapper = document.getElementById(`sw-${section}`);
  wrapper.innerHTML = '';

  if (!items.length) {
    wrapper.innerHTML = '<div class="swiper-slide no-slide"><p>Aucun résultat</p></div>';
    return;
  }

  items.forEach((item, i) => {
    const div = document.createElement('div');
    div.className = 'swiper-slide';
    div.dataset.index = i;
    div.innerHTML = `
      <img src="${item.image_url || DEFAULT_IMG}" alt="${escHtml(item.titre || item.artiste_nom || '')}"
           loading="lazy" onerror="this.src='${DEFAULT_IMG}'">
      <h1>${escHtml(item.titre || item.artiste_nom || '—')}</h1>
    `;
    wrapper.appendChild(div);
  });
}

function initSwiper(section) {
  if (state[section].swiper) {
    state[section].swiper.destroy(true, true);
    state[section].swiper = null;
  }

  const sw = new Swiper(`#swiper-${section}`, {
    effect: 'cards',
    cardsEffect: { perSlideOffset: 9, perSlideRotate: 3 },
    grabCursor: true,
    speed: 700,
    initialSlide: 0,
  });

  sw.on('slideChange', () => {
    const idx = sw.realIndex;
    if (idx !== state[section].index) {
      state[section].index = idx;
      loadAndPlay(section, idx, false);
    }
  });

  state[section].swiper = sw;
}

// ── PLAYLIST ────────────────────────────────────
function buildPlaylistItems(section, items) {
  const pl = document.getElementById(`pl-${section}`);
  pl.innerHTML = '';

  if (!items.length) {
    pl.innerHTML = '<p class="error-msg">Aucun résultat.</p>';
    return;
  }

  items.forEach((item, i) => {
    const el = document.createElement('div');
    el.className = 'playlist-item';
    el.dataset.index = i;

    const title     = escHtml(item.titre || item.artiste_nom || '—');
    const artist    = escHtml(item.artiste_nom || 'Inconnu');
    const img       = item.image_url || DEFAULT_IMG;
    const views     = fmtNum(item.views);
    const date      = item.date_fmt  ? `<span class="item-date">${item.date_fmt}</span>` : '';
    const numEmis   = item.numero_emission ? `<span class="item-num">Ém. ${item.numero_emission}</span>` : '';

    el.innerHTML = `
      <img src="${img}" alt="${title}" onerror="this.src='${DEFAULT_IMG}'">
      <div class="song">
        <p class="song-title">${title} ${numEmis}</p>
        <p class="song-artist">${artist} ${date}</p>
      </div>
      <span class="song-views"><i class="fa-regular fa-eye"></i> ${views}</span>
      <i class="fa-regular fa-heart like-btn"></i>
    `;

    el.addEventListener('click', e => {
      if (e.target.classList.contains('like-btn')) return;
      state[section].index = i;
      loadAndPlay(section, i);
    });

    el.querySelector('.like-btn').addEventListener('click', e => {
      e.stopPropagation();
      const btn = e.currentTarget;
      const isLiked = btn.classList.contains('fa-solid');
      btn.classList.toggle('fa-solid');
      btn.classList.toggle('fa-regular');
      if (!isLiked) apiIncrement(section, item.id, 'like');
    });

    pl.appendChild(el);
  });
}

// ════════════════════════════════════════════════
//  PLAYER
// ════════════════════════════════════════════════
function loadAndPlay(section, index, updateSwiper = true) {
  const items = state[section].items;
  if (!items || !items[index]) return;

  const item = items[index];
  state[section].index = index;
  currentSection = section;

  audioPlayer.src = item.audio_url || '';
  audioPlayer.play().catch(() => {});
  setPlayIcon(true);

  // Barre du player
  playerImage.src             = item.image_url || DEFAULT_IMG;
  playerTitle.textContent     = item.titre || item.artiste_nom || '—';
  playerArtist.textContent    = item.artiste_nom || '—';
  playerBadge.textContent     = BADGE_LABELS[section];
  playerBadge.dataset.section = section;

  // Highlight playlist
  document.querySelectorAll(`#pl-${section} .playlist-item`).forEach((el, i) => {
    el.classList.toggle('active-playlist-item', i === index);
  });
  const active = document.querySelector(`#pl-${section} .active-playlist-item`);
  if (active) active.scrollIntoView({ behavior: 'smooth', block: 'nearest' });

  // Swiper
  if (updateSwiper && state[section].swiper) {
    state[section].swiper.slideTo(index);
  }

  apiIncrement(section, item.id, 'view');
}

function setPlayIcon(playing) {
  playPauseIcon.classList.toggle('fa-pause', playing);
  playPauseIcon.classList.toggle('fa-play',  !playing);
}

function getAdjacentIndex(section, direction) {
  const len = state[section].items.length;
  if (!len) return 0;
  if (isShuffle) return Math.floor(Math.random() * len);
  const idx = state[section].index;
  return direction === 'next'
    ? (idx + 1) % len
    : (idx - 1 + len) % len;
}

// ── EVENTS PLAYER ───────────────────────────────
playPauseBtn.addEventListener('click', () => {
  const items = state[currentSection].items;
  if (!items.length) return;
  if (!audioPlayer.src || audioPlayer.src === location.href) {
    loadAndPlay(currentSection, state[currentSection].index);
    return;
  }
  if (audioPlayer.paused) {
    audioPlayer.play().catch(() => {});
    setPlayIcon(true);
  } else {
    audioPlayer.pause();
    setPlayIcon(false);
  }
});

nextBtn.addEventListener('click', () => {
  const idx = getAdjacentIndex(currentSection, 'next');
  loadAndPlay(currentSection, idx);
});

prevBtn.addEventListener('click', () => {
  if (audioPlayer.currentTime > 3) {
    audioPlayer.currentTime = 0;
    return;
  }
  const idx = getAdjacentIndex(currentSection, 'prev');
  loadAndPlay(currentSection, idx);
});

shuffleBtn.addEventListener('click', () => {
  isShuffle = !isShuffle;
  shuffleBtn.classList.toggle('active-control', isShuffle);
});

repeatBtn.addEventListener('click', () => {
  isRepeat = !isRepeat;
  repeatBtn.classList.toggle('active-control', isRepeat);
  audioPlayer.loop = isRepeat;
});

audioPlayer.addEventListener('ended', () => {
  if (isRepeat) return; // loop gère ça
  const idx = getAdjacentIndex(currentSection, 'next');
  loadAndPlay(currentSection, idx);
});

audioPlayer.addEventListener('loadedmetadata', () => {
  progressBar.max   = audioPlayer.duration;
  progressBar.value = 0;
  timeTotal.textContent = fmtTime(audioPlayer.duration);
});

audioPlayer.addEventListener('timeupdate', () => {
  progressBar.value       = audioPlayer.currentTime;
  timeCurrent.textContent = fmtTime(audioPlayer.currentTime);
});

progressBar.addEventListener('input', () => {
  audioPlayer.currentTime = progressBar.value;
  timeCurrent.textContent = fmtTime(audioPlayer.currentTime);
});

progressBar.addEventListener('change', () => {
  if (audioPlayer.paused && audioPlayer.src) {
    audioPlayer.play().catch(() => {});
    setPlayIcon(true);
  }
});

volumeRange.addEventListener('input', () => {
  const v = volumeRange.value / 100;
  audioPlayer.volume = v;
  const icon = document.getElementById('volumeIcon');
  icon.className = v === 0
    ? 'fa-solid fa-volume-xmark'
    : v < 0.5
      ? 'fa-solid fa-volume-low'
      : 'fa-solid fa-volume-high';
});

// ── CLAVIER ─────────────────────────────────────
document.addEventListener('keydown', e => {
  if (['INPUT', 'TEXTAREA'].includes(e.target.tagName)) return;
  if (e.code === 'Space') {
    e.preventDefault();
    playPauseBtn.click();
  }
  if (e.code === 'ArrowRight') nextBtn.click();
  if (e.code === 'ArrowLeft')  prevBtn.click();
});

// ════════════════════════════════════════════════
//  RECHERCHE
// ════════════════════════════════════════════════
searchInput.addEventListener('input', () => {
  clearTimeout(searchTimer);
  searchTimer = setTimeout(() => {
    const q   = searchInput.value.trim();
    const cat = state[currentSection].cat;
    loadSection(currentSection, cat, q);
  }, 400);
});

// ════════════════════════════════════════════════
//  UTILITAIRES
// ════════════════════════════════════════════════
function fmtTime(s) {
  if (!s || isNaN(s)) return '0:00';
  const m = Math.floor(s / 60);
  const sec = Math.floor(s % 60).toString().padStart(2, '0');
  return `${m}:${sec}`;
}

function fmtNum(n) {
  return Number(n || 0).toLocaleString('fr-FR');
}

function escHtml(str) {
  const d = document.createElement('div');
  d.textContent = str ?? '';
  return d.innerHTML;
}

// ════════════════════════════════════════════════
//  DÉMARRAGE
// ════════════════════════════════════════════════
initNav();
buildFilters('songs');
buildFilters('emissions');
buildFilters('interviews');

// Charger uniquement la section active au départ
loadSection('songs');
