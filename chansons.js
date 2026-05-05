'use strict';
/* ══════════════════════════════════════════════
   CHANSONS.JS — v3
   Tous les listeners dans DOMContentLoaded
   (évite le conflit avec shared.js)
══════════════════════════════════════════════ */

const PER_PAGE = 30;

let state = { page:1, cat:'', sort:'views', view:'grid', q:'', total:0, items:[], loading:false };

const grid      = document.getElementById('songsGrid');
const pagEl     = document.getElementById('pagination');
const sortSel   = document.getElementById('sortSelect');
const heroCount = document.getElementById('heroCount');

const SORT_API  = { views:'views', likes:'likes', recent:'recent', titre:'titre' };

// ── TOUT dans DOMContentLoaded ────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {

  const searchBox  = document.getElementById('searchBox');
  const searchClear = document.getElementById('searchClear');

  // Lire les params URL
  state.cat  = rcParams.get('cat')  || '';
  state.q    = rcParams.get('q')    || '';
  state.page = parseInt(rcParams.get('page')) || 1;
  state.sort = rcParams.get('sort') || 'views';

  if (searchBox && state.q) { searchBox.value = state.q; if (searchClear) searchClear.style.display = 'block'; }
  if (state.cat) document.querySelectorAll('#catPills .pill').forEach(p => p.classList.toggle('active', p.dataset.cat === state.cat));
  if (sortSel) sortSel.value = state.sort;

  // ─ Recherche ─
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

  // ─ Filtres catégorie ─
  document.getElementById('catPills')?.addEventListener('click', e => {
    const p = e.target.closest('.pill'); if (!p) return;
    document.querySelectorAll('#catPills .pill').forEach(x => x.classList.remove('active'));
    p.classList.add('active');
    state.cat = p.dataset.cat; state.page = 1;
    rcParams.set('cat', state.cat); load();
  });

  // ─ Tri ─
  if (sortSel) sortSel.addEventListener('change', () => {
    state.sort = sortSel.value; state.page = 1; rcParams.set('sort', state.sort); load();
  });

  // ─ Toggle vue grille/liste ─
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
    type:'songs', action:'list',
    limit:PER_PAGE, offset:(state.page-1)*PER_PAGE,
    sort: SORT_API[state.sort] || 'views',
    dir:  state.sort === 'titre' ? 'ASC' : 'DESC',
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
    current:state.page, total:state.total, perPage:PER_PAGE,
    onChange(p) { state.page=p; rcParams.set('page',p); load(); window.scrollTo({top:0,behavior:'smooth'}); }
  });
  setTimeout(() => grid.classList.add('visible'), 50);
}

// ── SKELETONS ─────────────────────────────────────────────────────────────────
function renderSkeletons() {
  const isList = state.view === 'list';
  grid.className = `songs-grid reveal${isList ? ' list-view' : ''}`;
  grid.innerHTML = Array.from({length: isList ? 10 : 15}, () =>
    `<div class="skeleton" style="height:${isList?'68px':'238px'};border-radius:14px"></div>`
  ).join('');
}

// ── RENDER CARDS ──────────────────────────────────────────────────────────────
function renderCards() {
  const isList = state.view === 'list';
  grid.className = `songs-grid reveal${isList ? ' list-view' : ''}`;

  if (!state.items.length) {
    grid.innerHTML = `<div class="empty-state"><i class="fa-solid fa-music-slash"></i><p>Aucune chanson trouvée${state.q ? ` pour « ${esc(state.q)} »` : ''}.</p></div>`;
    return;
  }

  const likedSet = new Set(JSON.parse(localStorage.getItem('rc_liked_songs') || '[]'));

  grid.innerHTML = state.items.map((s, i) => {
    const img     = s.image_url || NO_IMG;
    const rank    = state.sort === 'views' ? `<span class="song-rank">#${(state.page-1)*PER_PAGE+i+1}</span>` : '';
    const isLiked = likedSet.has(s.id);

    return isList ? `
      <div class="song-card" data-idx="${i}">
        <div class="song-thumb">
          <img src="${esc(img)}" alt="${esc(s.titre)}" loading="lazy" onerror="this.src='${NO_IMG}'">
          <div class="song-play-overlay"><button class="song-play-btn-big play-trigger"><i class="fa-solid fa-play"></i></button></div>
        </div>
        <div class="song-card-body">
          <div class="song-title-block">
            <p class="song-title">${esc(s.titre)}</p>
            <p class="song-artist">${esc(s.artiste_nom||'')}</p>
          </div>
          <span class="song-cat">${esc(s.categorie_nom||'Chaâbi')}</span>
          <div class="song-meta">
            <div class="song-stats">
              <span><i class="fa-regular fa-eye"></i>${fmt(s.views)}</span>
              <button class="like-heart ${isLiked?'liked':''}" data-id="${s.id}">
                <i class="fa-${isLiked?'solid':'regular'} fa-heart"></i>
              </button>
            </div>
          </div>
        </div>
      </div>` : `
      <div class="song-card" data-idx="${i}">
        <div class="song-thumb">
          <img src="${esc(img)}" alt="${esc(s.titre)}" loading="lazy" onerror="this.src='${NO_IMG}'">
          <div class="song-thumb-overlay"></div>
          ${rank}
          <div class="song-play-overlay"><button class="song-play-btn-big play-trigger"><i class="fa-solid fa-play"></i></button></div>
          <div class="song-playing-bar"><span></span><span></span><span></span><span></span></div>
        </div>
        <div class="song-card-body">
          <p class="song-title">${esc(s.titre)}</p>
          <p class="song-artist">${esc(s.artiste_nom||'Artiste inconnu')}</p>
          <div class="song-meta">
            <span class="song-cat">${esc(s.categorie_nom||'Chaâbi')}</span>
            <div class="song-stats">
              <span><i class="fa-regular fa-eye"></i>${fmt(s.views)}</span>
              <button class="like-heart ${isLiked?'liked':''}" data-id="${s.id}">
                <i class="fa-${isLiked?'solid':'regular'} fa-heart"></i>
              </button>
            </div>
          </div>
        </div>
      </div>`;
  }).join('');

  // Bind events
  grid.querySelectorAll('.song-card').forEach((card, i) => {
    card.addEventListener('click', e => {
      if (e.target.closest('.like-heart')) return;
      playAt(i);
    });
  });

  grid.querySelectorAll('.like-heart').forEach(btn => {
    btn.addEventListener('click', e => {
      e.stopPropagation();
      const id    = parseInt(btn.dataset.id);
      const arr   = JSON.parse(localStorage.getItem('rc_liked_songs') || '[]');
      const isNow = arr.includes(id);
      const icon  = btn.querySelector('i');
      if (isNow) {
        arr.splice(arr.indexOf(id), 1);
        btn.classList.remove('liked');
        if (icon) icon.className = 'fa-regular fa-heart';
      } else {
        arr.push(id);
        btn.classList.add('liked');
        if (icon) icon.className = 'fa-solid fa-heart';
        rcApiIncrement('songs', id, 'like');
        rcToast('Ajouté aux favoris ❤', 'success');
      }
      localStorage.setItem('rc_liked_songs', JSON.stringify(arr));
    });
  });
}

// ── PLAY ──────────────────────────────────────────────────────────────────────
function playAt(idx) {
  const s = state.items[idx];
  if (!s?.audio_url) { rcToast('Audio non disponible', 'error'); return; }
  grid.querySelectorAll('.song-card').forEach((c, i) => c.classList.toggle('playing', i === idx));
  rcPlay(s.audio_url, { img:s.image_url||NO_IMG, title:s.titre, artist:s.artiste_nom, type:'songs' }, state.items, idx, 'songs');
  rcApiIncrement('songs', s.id, 'view');
  rcToast(`▶ ${s.titre}`);
}
