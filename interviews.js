'use strict';
/* ══════════════════════════════════════════════
   INTERVIEWS.JS — v4
   Classes : iv-thumb-img, iv-body, iv-name,
             iv-date, iv-cat-inline, iv-play-small
══════════════════════════════════════════════ */

const PER_PAGE = 20;

let state = { page:1, cat:'', sort:'recent', view:'cards', q:'', total:0, items:[], loading:false };

const grid      = document.getElementById('interviewsGrid');
const pagEl     = document.getElementById('pagination');
const heroCount = document.getElementById('heroCount');
const sortSel   = document.getElementById('sortSelect');

const viewedSet = new Set();
const likedSet  = new Set(JSON.parse(localStorage.getItem('rc_liked_interviews') || '[]'));

document.addEventListener('DOMContentLoaded', () => {

  const searchBox   = document.getElementById('searchBox');
  const searchClear = document.getElementById('searchClear');

  state.cat  = rcParams.get('cat')  || '';
  state.q    = rcParams.get('q')    || '';
  state.page = parseInt(rcParams.get('page')) || 1;
  state.sort = rcParams.get('sort') || 'recent';

  if (searchBox && state.q) {
    searchBox.value = state.q;
    if (searchClear) searchClear.style.display = 'block';
  }
  if (state.cat) {
    document.querySelectorAll('#catPills .pill')
      .forEach(p => p.classList.toggle('active', p.dataset.cat === state.cat));
  }
  if (sortSel) sortSel.value = state.sort;

  // Recherche
  let searchTimer = null;
  if (searchBox) {
    searchBox.addEventListener('input', () => {
      if (searchClear) searchClear.style.display = searchBox.value ? 'block' : 'none';
      clearTimeout(searchTimer);
      searchTimer = setTimeout(() => {
        state.q = searchBox.value.trim();
        state.page = 1;
        rcParams.set('q', state.q);
        load();
      }, 400);
    });
  }
  if (searchClear) {
    searchClear.addEventListener('click', () => {
      if (searchBox) searchBox.value = '';
      state.q = ''; state.page = 1;
      searchClear.style.display = 'none';
      rcParams.set('q', '');
      load();
    });
  }

  // Filtres
  document.getElementById('catPills')?.addEventListener('click', e => {
    const p = e.target.closest('.pill'); if (!p) return;
    document.querySelectorAll('#catPills .pill').forEach(x => x.classList.remove('active'));
    p.classList.add('active');
    state.cat = p.dataset.cat; state.page = 1; rcParams.set('cat', state.cat); load();
  });

  if (sortSel) sortSel.addEventListener('change', () => {
    state.sort = sortSel.value; state.page = 1; rcParams.set('sort', state.sort); load();
  });

  // Toggle vue
  document.querySelectorAll('.grid-view-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      document.querySelectorAll('.grid-view-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      state.view = btn.dataset.view;
      renderCards();
    });
  });

  load();
});

// ── LOAD ──────────────────────────────────────────────────────────────────────
async function load() {
  if (state.loading) return;
  state.loading = true;
  renderSkeletons();
  const data = await rcApi({
    type: 'interviews', action: 'list',
    limit: PER_PAGE, offset: (state.page - 1) * PER_PAGE,
    sort: state.sort,
    ...(state.cat && { categorie_id: state.cat }),
    ...(state.q   && { q: state.q }),
  });
  state.loading = false;
  if (!data) {
    grid.innerHTML = `<div class="error-state"><i class="fa-solid fa-triangle-exclamation"></i><p>Erreur de chargement.</p></div>`;
    return;
  }
  state.items = data.items;
  state.total = data.total;
  if (heroCount) heroCount.textContent = fmt(data.total);
  renderCards();
  buildPagination(pagEl, {
    current: state.page, total: state.total, perPage: PER_PAGE,
    onChange(p) { state.page = p; rcParams.set('page', p); load(); window.scrollTo({ top: 0, behavior: 'smooth' }); }
  });
  setTimeout(() => grid.classList.add('visible'), 50);
}

// ── SKELETONS ─────────────────────────────────────────────────────────────────
function renderSkeletons() {
  const isList = state.view === 'list';
  grid.className = `interviews-grid reveal${isList ? ' list-view' : ''}`;
  grid.innerHTML = Array.from({ length: isList ? 8 : 12 }, () =>
    `<div class="skeleton" style="height:${isList ? '76px' : '260px'};border-radius:18px"></div>`
  ).join('');
}

// ── RENDER ────────────────────────────────────────────────────────────────────
function renderCards() {
  const isList = state.view === 'list';
  grid.className = `interviews-grid reveal${isList ? ' list-view' : ''}`;
  if (!state.items.length) {
    grid.innerHTML = `<div class="empty-state"><i class="fa-solid fa-microphone-slash"></i>
      <p>Aucune interview trouvée${state.q ? ` pour « ${esc(state.q)} »` : ''}.</p></div>`;
    return;
  }
  grid.innerHTML = state.items.map((iv, i) =>
    isList ? cardList(iv, i) : cardGrid(iv, i)
  ).join('');
  bindEvents();
}

// ── CARTE GRILLE ──────────────────────────────────────────────────────────────
function cardGrid(iv, i) {
  const img     = iv.image_url || NO_IMG;
  const name    = iv.titre || iv.artiste_nom || '—';
  const isLiked = likedSet.has(iv.id);

  return `
  <div class="interview-card" data-idx="${i}" data-id="${iv.id}">

    <!-- IMAGE : 4:3, object-position:center top → visage visible -->
    <div class="iv-thumb">
      <img class="iv-thumb-img"
           src="${esc(img)}" alt="${esc(name)}"
           loading="lazy" onerror="this.src='${NO_IMG}'">
      <div class="iv-thumb-gradient"></div>

      <!-- Badges en haut -->
      <span class="iv-cat">${esc(iv.categorie_nom || 'Interview')}</span>
      ${iv.date_fmt ? `<span class="iv-date"><i class="fa-regular fa-calendar"></i>${esc(iv.date_fmt)}</span>` : ''}

      <!-- Badge "En cours" -->
      <span class="iv-playing-badge">
        <span class="eq-xs"><span></span><span></span><span></span></span>
        En cours
      </span>

      <!-- Bouton play centré (au survol) -->
      <div class="iv-play-overlay">
        <button class="iv-play-btn play-trigger">
          <i class="fa-solid fa-play"></i>
        </button>
      </div>
    </div>

    <!-- CORPS BLANC -->
    <div class="iv-body">
      <div class="iv-name">${esc(name)}</div>
      <div class="iv-meta">
        <span class="iv-cat-inline">${esc(iv.categorie_nom || 'Chaâbi')}</span>
      </div>
    </div>

    <!-- PIED : stats + play -->
    <div class="iv-footer">
      <div class="iv-stats">
        <button class="iv-stat-btn iv-view-action ${viewedSet.has(iv.id) ? 'viewed' : ''}" data-id="${iv.id}">
          <i class="fa-regular fa-eye"></i><span class="iv-vc">${fmt(iv.views)}</span>
        </button>
        <button class="iv-stat-btn iv-like-action ${isLiked ? 'liked' : ''}" data-id="${iv.id}">
          <i class="fa-${isLiked ? 'solid' : 'regular'} fa-heart"></i><span class="iv-lc">${fmt(iv.likes)}</span>
        </button>
      </div>
      <button class="iv-play-small play-trigger">
        <i class="fa-solid fa-play"></i>
      </button>
    </div>
  </div>`;
}

// ── CARTE LISTE ───────────────────────────────────────────────────────────────
function cardList(iv, i) {
  const img     = iv.image_url || NO_IMG;
  const name    = iv.titre || iv.artiste_nom || '—';
  const isLiked = likedSet.has(iv.id);

  return `
  <div class="interview-card" data-idx="${i}" data-id="${iv.id}">
    <div class="iv-thumb">
      <img class="iv-thumb-img"
           src="${esc(img)}" alt="${esc(name)}"
           loading="lazy" onerror="this.src='${NO_IMG}'">
      <div class="iv-play-overlay">
        <button class="iv-play-btn play-trigger"><i class="fa-solid fa-play"></i></button>
      </div>
    </div>
    <div class="iv-body">
      <div class="iv-name">${esc(name)}</div>
      <div class="iv-meta">
        <span class="iv-cat-inline">${esc(iv.categorie_nom || 'Chaâbi')}</span>
        ${iv.date_fmt ? `<span class="iv-date-inline"><i class="fa-regular fa-calendar"></i>${esc(iv.date_fmt)}</span>` : ''}
      </div>
    </div>
    <div class="iv-footer">
      <div class="iv-stats">
        <button class="iv-stat-btn iv-view-action ${viewedSet.has(iv.id) ? 'viewed' : ''}" data-id="${iv.id}">
          <i class="fa-regular fa-eye"></i><span class="iv-vc">${fmt(iv.views)}</span>
        </button>
        <button class="iv-stat-btn iv-like-action ${isLiked ? 'liked' : ''}" data-id="${iv.id}">
          <i class="fa-${isLiked ? 'solid' : 'regular'} fa-heart"></i><span class="iv-lc">${fmt(iv.likes)}</span>
        </button>
      </div>
      <button class="iv-play-small play-trigger"><i class="fa-solid fa-play"></i></button>
    </div>
  </div>`;
}

// ── BIND EVENTS ───────────────────────────────────────────────────────────────
function bindEvents() {
  grid.querySelectorAll('.interview-card').forEach(card => {
    const idx = parseInt(card.dataset.idx);
    const id  = parseInt(card.dataset.id);

    // Clic carte → lecture
    card.addEventListener('click', e => {
      if (e.target.closest('.iv-stat-btn')) return;
      playAt(idx);
    });

    // Vues
    card.querySelectorAll('.iv-view-action').forEach(btn =>
      btn.addEventListener('click', e => { e.stopPropagation(); incrView(id, btn); })
    );
    // Likes
    card.querySelectorAll('.iv-like-action').forEach(btn =>
      btn.addEventListener('click', e => { e.stopPropagation(); toggleLike(id, btn); })
    );
  });
}

// ── VUES ──────────────────────────────────────────────────────────────────────
function incrView(id, btn) {
  if (viewedSet.has(id)) return;
  viewedSet.add(id);
  rcApiIncrement('interviews', id, 'view');
  btn.classList.add('viewed');
  const sp = btn.querySelector('.iv-vc');
  if (sp) sp.textContent = fmt((parseN(sp.textContent) || 0) + 1);
}

// ── LIKES ─────────────────────────────────────────────────────────────────────
function toggleLike(id, btn) {
  const isLiked = likedSet.has(id);
  const sp   = btn.querySelector('.iv-lc');
  const icon = btn.querySelector('i');
  const n    = parseN(sp?.textContent) || 0;
  if (isLiked) {
    likedSet.delete(id); btn.classList.remove('liked');
    if (icon) icon.className = 'fa-regular fa-heart';
    if (sp)   sp.textContent = fmt(Math.max(0, n - 1));
  } else {
    likedSet.add(id); btn.classList.add('liked');
    if (icon) icon.className = 'fa-solid fa-heart';
    if (sp)   sp.textContent = fmt(n + 1);
    rcApiIncrement('interviews', id, 'like');
    rcToast('Interview ajoutée aux favoris ❤', 'success');
  }
  localStorage.setItem('rc_liked_interviews', JSON.stringify([...likedSet]));
}

// ── LECTURE ───────────────────────────────────────────────────────────────────
function playAt(idx) {
  const iv = state.items[idx];
  if (!iv?.audio_url) { rcToast('Audio non disponible', 'error'); return; }

  grid.querySelectorAll('.interview-card').forEach((c, i) => {
    const isPlaying = i === idx;
    c.classList.toggle('playing', isPlaying);
    // Icône play/pause sur tous les boutons de la carte
    c.querySelectorAll('.play-trigger i').forEach(ic => {
      ic.className = isPlaying ? 'fa-solid fa-pause' : 'fa-solid fa-play';
    });
  });

  rcPlay(
    iv.audio_url,
    { img: iv.image_url || NO_IMG, title: iv.titre || iv.artiste_nom, artist: iv.artiste_nom, type: 'interviews' },
    state.items, idx, 'interviews'
  );
  incrView(iv.id, grid.querySelector(`.interview-card[data-idx="${idx}"] .iv-view-action`) || { classList:{add:()=>{}}, querySelector:()=>null });
  rcToast(`▶ ${iv.titre || iv.artiste_nom}`);
}

function parseN(s) { return parseInt(String(s || '0').replace(/\s/g, '')) || 0; }
