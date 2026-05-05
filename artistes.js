'use strict';
/* ══════════════════════════════════════════════
   ARTISTES.JS — v5
   Fix : classes uniques (a-stat-btn), modal avec
   onglets Chansons / Interviews, recherche robuste
══════════════════════════════════════════════ */

const PER_PAGE = 24;

let state = { page:1, cat:'', sort:'views', view:'grid', q:'', total:0, items:[], loading:false };

// Références DOM
const grid      = document.getElementById('artistsGrid');
const pagEl     = document.getElementById('pagination');
const sortSel   = document.getElementById('sortSelect');
const heroCount = document.getElementById('heroCount');

// ── INIT ──────────────────────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
  const searchBox = document.getElementById('searchBox');
  if (!searchBox) return;

  state.cat  = rcParams.get('cat')  || '';
  state.q    = rcParams.get('q')    || '';
  state.page = parseInt(rcParams.get('page')) || 1;
  state.sort = rcParams.get('sort') || 'views';

  if (state.q) { searchBox.value = state.q; document.getElementById('searchClear').style.display = 'block'; }
  if (state.cat) document.querySelectorAll('#catPills .pill').forEach(p => p.classList.toggle('active', p.dataset.cat === state.cat));
  sortSel.value = state.sort;

  // ── Recherche (debounce 400ms) ──
  let searchTimer = null;
  searchBox.addEventListener('input', () => {
    document.getElementById('searchClear').style.display = searchBox.value ? 'block' : 'none';
    clearTimeout(searchTimer);
    searchTimer = setTimeout(() => {
      state.q    = searchBox.value.trim();
      state.page = 1;
      rcParams.set('q', state.q);
      load();
    }, 400);
  });

  document.getElementById('searchClear').addEventListener('click', () => {
    searchBox.value = '';
    state.q    = '';
    state.page = 1;
    document.getElementById('searchClear').style.display = 'none';
    rcParams.set('q', '');
    load();
  });

  // ── Toggle vue (grille / liste) — classe ".grid-view-btn" unique ──
  document.querySelectorAll('.grid-view-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      document.querySelectorAll('.grid-view-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      state.view = btn.dataset.view;
      renderCards();
    });
  });

  // ── Filtres catégorie ──
  document.getElementById('catPills').addEventListener('click', e => {
    const pill = e.target.closest('.pill'); if (!pill) return;
    document.querySelectorAll('#catPills .pill').forEach(p => p.classList.remove('active'));
    pill.classList.add('active');
    state.cat = pill.dataset.cat; state.page = 1;
    rcParams.set('cat', state.cat); load();
  });

  // ── Tri ──
  sortSel.addEventListener('change', () => {
    state.sort = sortSel.value; state.page = 1; rcParams.set('sort', state.sort); load();
  });

  // ── Fermer modal ──
  document.getElementById('artistModalClose').addEventListener('click', closeModal);
  document.getElementById('artistModal').addEventListener('click', e => {
    if (e.target === document.getElementById('artistModal')) closeModal();
  });

  load();
});

// ── LOAD ──────────────────────────────────────────────────────────────────────
async function load() {
  if (state.loading) return;
  state.loading = true;
  renderSkeletons();
  const data = await rcApi({
    type:'artistes', action:'list',
    limit:PER_PAGE, offset:(state.page-1)*PER_PAGE,
    sort:state.sort,
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
  grid.className = `artists-grid reveal${isList ? ' list-view' : ''}`;
  grid.innerHTML = Array.from({length:isList?10:12}, () =>
    `<div class="skeleton" style="height:${isList?'82px':'248px'};border-radius:14px"></div>`
  ).join('');
}

// ── RENDER CARDS ──────────────────────────────────────────────────────────────
const viewedIds = new Set();

function renderCards() {
  const isList  = state.view === 'list';
  grid.className = `artists-grid reveal${isList ? ' list-view' : ''}`;
  if (!state.items.length) {
    grid.innerHTML = `<div class="empty-state"><i class="fa-solid fa-user-slash"></i><p>Aucun artiste trouvé${state.q ? ` pour « ${esc(state.q)} »` : ''}.</p></div>`;
    return;
  }
  const likedIds = new Set(JSON.parse(localStorage.getItem('rc_liked_artistes') || '[]'));
  grid.innerHTML = state.items.map((a, i) => isList ? cardList(a, i, likedIds) : cardGrid(a, i, likedIds)).join('');

  grid.querySelectorAll('.artist-card').forEach((card, i) => {
    // Clic global → modal
    card.addEventListener('click', e => {
      if (e.target.closest('.a-stat-btn') || e.target.closest('.artist-play-btn')) return;
      markViewed(state.items[i], card);
      openModal(state.items[i]);
    });
    // Play rapide
    card.querySelector('.artist-play-btn')?.addEventListener('click', e => {
      e.stopPropagation();
      markViewed(state.items[i], card);
      playArtist(state.items[i]);
    });
    // Like
    card.querySelector('.a-stat-btn.like-action')?.addEventListener('click', e => {
      e.stopPropagation();
      toggleLike(state.items[i].id, e.currentTarget);
    });
    // Vue
    card.querySelector('.a-stat-btn.view-action')?.addEventListener('click', e => {
      e.stopPropagation();
      markViewed(state.items[i], card);
    });
  });
}

function cardGrid(a, i, likedIds) {
  const img   = a.image_url || NO_IMG;
  const liked = likedIds.has(a.id);
  return `<div class="artist-card" data-idx="${i}">
    <div class="artist-thumb">
      <img src="${esc(img)}" alt="${esc(a.nom)}" loading="lazy" onerror="this.src='${NO_IMG}'">
      <div class="artist-thumb-overlay"></div>
      <span class="artist-cat-badge">${esc(a.categorie_nom||'Chaâbi')}</span>
      <button class="artist-play-btn"><i class="fa-solid fa-play"></i></button>
    </div>
    <div class="artist-body">
      <p class="artist-name">${esc(a.nom)}</p>
      <div class="artist-foot">
        <span style="font-size:.66rem;color:var(--text-3)"><i class="fa-solid fa-music"></i> ${fmt(a.nb_chansons)}</span>
        <div class="artist-foot-stats">
          <button class="a-stat-btn view-action" title="Écoutes">
            <i class="fa-regular fa-eye"></i><span class="v-count">${fmt(a.views)}</span>
          </button>
          <button class="a-stat-btn like-action ${liked?'liked':''}">
            <i class="fa-${liked?'solid':'regular'} fa-heart"></i><span class="l-count">${fmt(a.likes)}</span>
          </button>
        </div>
      </div>
    </div>
  </div>`;
}

function cardList(a, i, likedIds) {
  const img   = a.image_url || NO_IMG;
  const liked = likedIds.has(a.id);
  return `<div class="artist-card" data-idx="${i}">
    <div class="artist-thumb" style="width:62px;height:62px;aspect-ratio:auto;border-radius:8px;flex-shrink:0">
      <img src="${esc(img)}" alt="${esc(a.nom)}" loading="lazy" onerror="this.src='${NO_IMG}'">
    </div>
    <div class="artist-body" style="flex:1;padding:0 10px;min-width:0">
      <span class="artist-cat-badge" style="position:static;display:inline-block;margin-bottom:3px;font-size:.56rem">${esc(a.categorie_nom||'Chaâbi')}</span>
      <p class="artist-name">${esc(a.nom)}</p>
      <div class="artist-foot">
        <span style="font-size:.66rem;color:var(--text-3)"><i class="fa-solid fa-music"></i> ${fmt(a.nb_chansons)}</span>
        <div class="artist-foot-stats">
          <button class="a-stat-btn view-action"><i class="fa-regular fa-eye"></i><span class="v-count">${fmt(a.views)}</span></button>
          <button class="a-stat-btn like-action ${liked?'liked':''}"><i class="fa-${liked?'solid':'regular'} fa-heart"></i><span class="l-count">${fmt(a.likes)}</span></button>
        </div>
      </div>
    </div>
    <button class="artist-play-btn" style="position:static;opacity:1;transform:none;flex-shrink:0;margin-right:8px"><i class="fa-solid fa-play"></i></button>
  </div>`;
}

// ── STATS ─────────────────────────────────────────────────────────────────────
function markViewed(artiste, card) {
  if (viewedIds.has(artiste.id)) return;
  viewedIds.add(artiste.id);
  rcApiIncrement('artistes', artiste.id, 'view');
  const btn = card?.querySelector('.view-action');
  if (!btn) return;
  const sp = btn.querySelector('.v-count');
  if (sp) sp.textContent = fmt((parseN(sp.textContent)||0)+1);
  btn.classList.add('viewed');
}

function toggleLike(id, btn) {
  const arr   = JSON.parse(localStorage.getItem('rc_liked_artistes')||'[]');
  const isNow = arr.includes(id);
  const icon  = btn.querySelector('i');
  const sp    = btn.querySelector('.l-count');
  const n     = parseN(sp?.textContent)||0;
  if (isNow) {
    arr.splice(arr.indexOf(id),1);
    btn.classList.remove('liked');
    if (icon) icon.className='fa-regular fa-heart';
    if (sp)   sp.textContent=fmt(Math.max(0,n-1));
  } else {
    arr.push(id);
    btn.classList.add('liked');
    if (icon) icon.className='fa-solid fa-heart';
    if (sp)   sp.textContent=fmt(n+1);
    rcApiIncrement('artistes',id,'like');
    rcToast('Artiste ajouté aux favoris ❤','success');
  }
  localStorage.setItem('rc_liked_artistes',JSON.stringify(arr));
}

async function playArtist(artist) {
  const data = await rcApi({type:'songs',action:'list',artiste_id:artist.id,limit:50,sort:'views'});
  if (!data?.items?.length) { rcToast('Aucune chanson disponible','error'); return; }
  const s=data.items[0];
  rcPlay(s.audio_url,{img:s.image_url||NO_IMG,title:s.titre,artist:artist.nom,type:'songs'},data.items,0,'songs');
  rcApiIncrement('songs',s.id,'view');
  rcToast(`▶ ${s.titre}`);
}

// ══════════════════════════════════════════════════════
//   MODAL — Utilise artisteDetail() pour avoir TOUT :
//   bio complète + toutes chansons + toutes interviews
// ══════════════════════════════════════════════════════
async function openModal(artiste) {
  const modal   = document.getElementById('artistModal');
  const content = document.getElementById('artistModalContent');

  modal.scrollTop = 0;
  modal.classList.add('open');
  document.body.style.overflow = 'hidden';

  // Affiche un skeleton pendant le chargement du détail complet
  content.innerHTML = `
    <div class="am-header">
      <div class="skeleton" style="width:88px;height:88px;border-radius:12px;flex-shrink:0"></div>
      <div style="flex:1;display:flex;flex-direction:column;gap:8px;padding-left:16px">
        <div class="skeleton" style="height:14px;width:60px;border-radius:6px"></div>
        <div class="skeleton" style="height:22px;width:180px;border-radius:6px"></div>
        <div class="skeleton" style="height:30px;width:220px;border-radius:9px"></div>
      </div>
    </div>
    <div style="padding:20px;text-align:center;color:var(--text-3)">
      <i class="fa-solid fa-spinner fa-spin"></i> Chargement du profil…
    </div>`;

  // ── Appel unique : artisteDetail retourne bio + songs[] + interviews[] sans LIMIT ──
  const detail = await rcApi({ type:'artistes', action:'detail', id: artiste.id });

  if (!detail) {
    content.innerHTML = `<div class="am-loading" style="color:var(--red)">
      <i class="fa-solid fa-triangle-exclamation"></i> Erreur de chargement.
    </div>`;
    return;
  }

  // Fusionner avec les données de la carte (image_url déjà résolue côté listArtistes)
  const a     = detail;
  a.image_url = a.image_url || artiste.image_url || NO_IMG;
  const img   = a.image_url;
  const liked = JSON.parse(localStorage.getItem('rc_liked_artistes')||'[]').includes(a.id);
  const nb_s  = parseInt(a.nb_chansons)   || 0;
  const nb_i  = parseInt(a.nb_interviews) || 0;
  const nb_e  = parseInt(a.nb_emissions)  || 0;
  const songs      = a.songs      || [];
  const interviews = a.interviews || [];
  const emissions  = a.emissions  || [];

  content.innerHTML = `
    <div class="am-header">
      <img class="am-img" src="${esc(img)}" alt="${esc(a.nom)}" onerror="this.src='${NO_IMG}'">
      <div class="am-meta">
        <div class="am-cat"><i class="fa-solid fa-guitar"></i> ${esc(a.categorie_nom||'Artiste')}</div>
        <div class="am-name">${esc(a.nom)}</div>
        <div class="am-chips">
          <div class="am-chip noclick">
            <i class="fa-solid fa-music"></i> ${fmt(nb_s)} chanson${nb_s!==1?'s':''}
          </div>
          ${nb_i>0 ? `<div class="am-chip noclick">
            <i class="fa-solid fa-microphone-lines"></i> ${fmt(nb_i)} interview${nb_i!==1?'s':''}
          </div>` : ''}
          ${nb_e>0 ? `<div class="am-chip noclick">
            <i class="fa-solid fa-radio"></i> ${fmt(nb_e)} émission${nb_e!==1?'s':''}
          </div>` : ''}
          <button class="am-chip" id="amViewBtn">
            <i class="fa-regular fa-eye"></i> <span id="amViewN">${fmt(a.views)}</span>
          </button>
          <button class="am-chip ${liked?'liked':''}" id="amLikeBtn">
            <i class="fa-${liked?'solid':'regular'} fa-heart"></i> <span id="amLikeN">${fmt(a.likes)}</span>
          </button>
        </div>
      </div>
    </div>

    ${a.bio && a.bio.trim() ? `<div class="am-bio">${esc(a.bio)}</div>` : ''}

    <div class="am-tabs">
      <button class="am-tab active" data-tab="songs">
        <i class="fa-solid fa-headphones"></i> Chansons
        <span class="am-tab-count">${fmt(songs.length)}</span>
      </button>
      <button class="am-tab" data-tab="interviews">
        <i class="fa-solid fa-microphone-lines"></i> Interviews
        <span class="am-tab-count">${fmt(interviews.length)}</span>
      </button>
      <button class="am-tab" data-tab="emissions">
        <i class="fa-solid fa-radio"></i> Émissions
        <span class="am-tab-count">${fmt(emissions.length)}</span>
      </button>
    </div>

    <div class="am-tab-panel active" id="amPanelSongs">
      ${songs.length ? songs.map((s,i) => `
        <div class="am-row am-row-song" data-si="${i}">
          <span class="am-rnum">${i+1}</span>
          <img class="am-rimg" src="${esc(s.image_url||NO_IMG)}" alt="" onerror="this.src='${NO_IMG}'">
          <div class="am-rinfo">
            <div class="am-rtitle">${esc(s.titre)}</div>
            <div class="am-rsub">${esc(s.categorie_nom||'')}</div>
          </div>
          <span class="am-rviews"><i class="fa-regular fa-eye"></i> ${fmt(s.views)}</span>
          <div class="am-rplay"><i class="fa-solid fa-play"></i></div>
        </div>`).join('') : '<p class="am-empty">Aucune chanson disponible.</p>'}
    </div>

    <div class="am-tab-panel" id="amPanelInterviews">
      ${interviews.length ? interviews.map((iv,i) => `
        <div class="am-row am-row-iv" data-ii="${i}">
          <span class="am-rnum">${i+1}</span>
          <img class="am-rimg" src="${esc(iv.image_url||NO_IMG)}" alt="" onerror="this.src='${NO_IMG}'">
          <div class="am-rinfo">
            <div class="am-rtitle">${esc(iv.titre||iv.artiste_nom||'—')}</div>
            <div class="am-rsub">${iv.date_fmt ? `<i class="fa-regular fa-calendar"></i> ${esc(iv.date_fmt)}` : esc(iv.categorie_nom||'')}</div>
          </div>
          <span class="am-rviews"><i class="fa-regular fa-eye"></i> ${fmt(iv.views)}</span>
          <div class="am-rplay"><i class="fa-solid fa-play"></i></div>
        </div>`).join('') : '<p class="am-empty">Aucune interview disponible.</p>'}
    </div>

    <div class="am-tab-panel" id="amPanelEmissions">
      ${emissions.length ? emissions.map((e,i) => `
        <div class="am-row am-row-em" data-ei="${i}">
          <span class="am-rnum am-em-num">N°${e.numero_emission||'?'}</span>
          <img class="am-rimg" src="${esc(e.image_url||NO_IMG)}" alt="" onerror="this.src='${NO_IMG}'">
          <div class="am-rinfo">
            <div class="am-rtitle">${esc(e.titre||'Émission')}</div>
            <div class="am-rsub">${e.date_fmt ? `<i class="fa-regular fa-calendar"></i> ${esc(e.date_fmt)}` : esc(e.categorie_nom||'')}</div>
          </div>
          <span class="am-rviews"><i class="fa-regular fa-eye"></i> ${fmt(e.views)}</span>
          <div class="am-rplay"><i class="fa-solid fa-play"></i></div>
        </div>`).join('') : '<p class="am-empty">Aucune émission trouvée.</p>'}
    </div>`;

  // ── Bouton vue ──
  let mViewed = viewedIds.has(a.id);
  document.getElementById('amViewBtn').addEventListener('click', () => {
    if (mViewed) { rcToast('Vue déjà comptabilisée'); return; }
    mViewed = true; viewedIds.add(a.id);
    rcApiIncrement('artistes', a.id, 'view');
    const sp = document.getElementById('amViewN');
    if (sp) sp.textContent = fmt((parseN(sp.textContent)||0)+1);
    document.getElementById('amViewBtn').classList.add('viewed');
    rcToast('Vue comptabilisée ✓', 'success');
  });

  // ── Bouton like ──
  document.getElementById('amLikeBtn').addEventListener('click', e => {
    toggleLike(a.id, e.currentTarget);
    // Sync la carte dans la grille
    grid.querySelectorAll('.like-action').forEach((b, idx) => {
      if (state.items[idx]?.id === a.id) {
        const arr = JSON.parse(localStorage.getItem('rc_liked_artistes')||'[]');
        const lk  = arr.includes(a.id);
        b.classList.toggle('liked', lk);
        const ic = b.querySelector('i');
        if (ic) ic.className = `fa-${lk?'solid':'regular'} fa-heart`;
        const lsp = b.querySelector('.l-count');
        if (lsp) lsp.textContent = document.getElementById('amLikeN').textContent;
      }
    });
  });

  // ── Onglets (3 onglets : Songs / Interviews / Emissions) ──
  const panelMap = { songs:'amPanelSongs', interviews:'amPanelInterviews', emissions:'amPanelEmissions' };
  content.querySelectorAll('.am-tab').forEach(tab => {
    tab.addEventListener('click', () => {
      content.querySelectorAll('.am-tab').forEach(t => t.classList.remove('active'));
      content.querySelectorAll('.am-tab-panel').forEach(p => p.classList.remove('active'));
      tab.classList.add('active');
      const panelId = panelMap[tab.dataset.tab];
      if (panelId) document.getElementById(panelId).classList.add('active');
    });
  });

  // ── Clic sur une chanson ──
  content.querySelectorAll('.am-row-song').forEach((row, i) => {
    row.addEventListener('click', () => {
      content.querySelectorAll('.am-row-song').forEach(r => {
        r.classList.remove('active');
        r.querySelector('.am-rplay').innerHTML = '<i class="fa-solid fa-play"></i>';
      });
      row.classList.add('active');
      row.querySelector('.am-rplay').innerHTML = '<i class="fa-solid fa-pause"></i>';
      const s = songs[i];
      rcPlay(s.audio_url, { img:s.image_url||NO_IMG, title:s.titre, artist:a.nom, type:'songs' }, songs, i, 'songs');
      rcApiIncrement('songs', s.id, 'view');
      rcToast(`▶ ${s.titre}`);
    });
  });

  // ── Clic sur une interview ──
  content.querySelectorAll('.am-row-iv').forEach((row, i) => {
    row.addEventListener('click', () => {
      content.querySelectorAll('.am-row-iv').forEach(r => {
        r.classList.remove('active');
        r.querySelector('.am-rplay').innerHTML = '<i class="fa-solid fa-play"></i>';
      });
      row.classList.add('active');
      row.querySelector('.am-rplay').innerHTML = '<i class="fa-solid fa-pause"></i>';
      const iv = interviews[i];
      rcPlay(iv.audio_url, { img:iv.image_url||NO_IMG, title:iv.titre||iv.artiste_nom, artist:a.nom, type:'interviews' }, interviews, i, 'interviews');
      rcApiIncrement('interviews', iv.id, 'view');
      rcToast(`▶ ${iv.titre||iv.artiste_nom}`);
    });
  });

  // ── Clic sur une émission ──
  content.querySelectorAll('.am-row-em').forEach((row, i) => {
    row.addEventListener('click', () => {
      content.querySelectorAll('.am-row-em').forEach(r => {
        r.classList.remove('active');
        r.querySelector('.am-rplay').innerHTML = '<i class="fa-solid fa-play"></i>';
      });
      row.classList.add('active');
      row.querySelector('.am-rplay').innerHTML = '<i class="fa-solid fa-pause"></i>';
      const e = emissions[i];
      if (!e.audio_url) { rcToast('Audio non disponible', 'error'); return; }
      rcPlay(e.audio_url, { img:e.image_url||NO_IMG, title:`Émission N°${e.numero_emission} — ${e.titre}`, artist:a.nom, type:'emissions' }, emissions, i, 'emissions');
      rcApiIncrement('emissions', e.id, 'view');
      rcToast(`▶ Émission N°${e.numero_emission}`);
    });
  });
}


function closeModal() {
  document.getElementById('artistModal').classList.remove('open');
  document.body.style.overflow = '';
}

function parseN(s){ return parseInt(String(s||'0').replace(/\s/g,''))||0; }
