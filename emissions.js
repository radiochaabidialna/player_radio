'use strict';
/* ══════════════════════════════════════════════
   EMISSIONS.JS — v6
   Fix : invités externes → interviews par artiste_nom
         (les interviews viennent maintenant de l'API
         directement dans la réponse listEmissionInvites)
══════════════════════════════════════════════ */

const PER_PAGE = 18;

let state = { page:1, cat:'', sort:'recent', view:'cards', q:'', total:0, items:[], loading:false };

const grid      = document.getElementById('emissionsGrid');
const pagEl     = document.getElementById('pagination');
const heroCount = document.getElementById('heroCount');
const sortSel   = document.getElementById('sortSelect');

const viewedSet   = new Set();
const likedSet    = new Set(JSON.parse(localStorage.getItem('rc_liked_emissions') || '[]'));
const inviteCache = {};

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
      .forEach(function(p) { p.classList.toggle('active', p.dataset.cat === state.cat); });
  }
  if (sortSel) sortSel.value = state.sort;

  // Recherche avec debounce
  var searchTimer = null;
  if (searchBox) {
    searchBox.addEventListener('input', function() {
      if (searchClear) searchClear.style.display = searchBox.value ? 'block' : 'none';
      clearTimeout(searchTimer);
      searchTimer = setTimeout(function() {
        state.q    = searchBox.value.trim();
        state.page = 1;
        rcParams.set('q', state.q);
        load();
      }, 400);
    });
  }
  if (searchClear) {
    searchClear.addEventListener('click', function() {
      if (searchBox) searchBox.value = '';
      state.q = ''; state.page = 1;
      searchClear.style.display = 'none';
      rcParams.set('q', '');
      load();
    });
  }

  // Filtres catégorie
  var catPills = document.getElementById('catPills');
  if (catPills) {
    catPills.addEventListener('click', function(e) {
      var p = e.target.closest('.pill');
      if (!p) return;
      document.querySelectorAll('#catPills .pill').forEach(function(x) { x.classList.remove('active'); });
      p.classList.add('active');
      state.cat = p.dataset.cat; state.page = 1; rcParams.set('cat', state.cat); load();
    });
  }

  if (sortSel) {
    sortSel.addEventListener('change', function() {
      state.sort = sortSel.value; state.page = 1; rcParams.set('sort', state.sort); load();
    });
  }

  // Toggle vue grille/liste
  document.querySelectorAll('.grid-view-btn').forEach(function(btn) {
    btn.addEventListener('click', function() {
      document.querySelectorAll('.grid-view-btn').forEach(function(b) { b.classList.remove('active'); });
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

  var SORTS = { recent:'recent', views:'views', likes:'likes', numero:'numero' };
  var params = {
    type:'emissions', action:'list',
    limit:PER_PAGE, offset:(state.page-1)*PER_PAGE,
    sort: SORTS[state.sort] || 'recent',
  };
  if (state.cat) params.categorie_id = state.cat;
  if (state.q)   params.q            = state.q;

  var data = await rcApi(params);
  state.loading = false;

  if (!data) {
    grid.innerHTML = '<div class="error-state"><i class="fa-solid fa-triangle-exclamation"></i><p>Erreur de chargement.</p></div>';
    return;
  }
  state.items = data.items;
  state.total = data.total;
  if (heroCount) heroCount.textContent = fmt(data.total);

  renderCards();
  buildPagination(pagEl, {
    current: state.page,
    total:   state.total,
    perPage: PER_PAGE,
    onChange: function(p) {
      state.page = p; rcParams.set('page', p);
      load();
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
  });
  setTimeout(function() { grid.classList.add('visible'); }, 50);
}

// ── SKELETONS ─────────────────────────────────────────────────────────────────
function renderSkeletons() {
  var isList = state.view === 'list';
  grid.className = 'emissions-grid reveal' + (isList ? ' list-view' : '');
  var h = isList ? '74px' : '295px';
  var html = '';
  for (var i = 0; i < (isList ? 8 : 9); i++) {
    html += '<div class="skeleton" style="height:' + h + ';border-radius:14px"></div>';
  }
  grid.innerHTML = html;
}

// ── RENDER CARDS ──────────────────────────────────────────────────────────────
function renderCards() {
  var isList = state.view === 'list';
  grid.className = 'emissions-grid reveal' + (isList ? ' list-view' : '');

  if (!state.items.length) {
    grid.innerHTML = '<div class="empty-state"><i class="fa-solid fa-radio"></i><p>Aucune émission trouvée' +
      (state.q ? ' pour « ' + esc(state.q) + ' »' : '') + '.</p></div>';
    return;
  }

  var html = '';
  for (var i = 0; i < state.items.length; i++) {
    html += isList ? cardList(state.items[i], i) : cardFull(state.items[i], i);
  }
  grid.innerHTML = html;

  bindCardEvents();
  if (!isList) {
    for (var j = 0; j < state.items.length; j++) {
      loadInvites(state.items[j].id);
    }
  }
}

function cardFull(e, i) {
  var isLiked  = likedSet.has(e.id);
  var isViewed = viewedSet.has(e.id);
  return '<div class="emission-card" data-idx="' + i + '" data-id="' + e.id + '">' +
    '<div class="em-thumb">' +
      '<img src="' + esc(e.image_url || NO_IMG) + '" alt="' + esc(e.titre) + '" loading="lazy" onerror="this.src=\'' + NO_IMG + '\'">' +
      '<div class="em-overlay"></div>' +
      (e.numero_emission ? '<span class="em-num-badge">Ém. N°' + e.numero_emission + '</span>' : '') +
      '<div class="em-playing-badge"><div class="eq-mini"><span></span><span></span><span></span></div> En cours</div>' +
      '<button class="em-play-btn em-play-trigger"><i class="fa-solid fa-play"></i></button>' +
    '</div>' +
    '<div class="em-body">' +
      '<p class="em-title">' + esc(e.titre) + '</p>' +
      '<p class="em-desc">' + esc(e.description || '') + '</p>' +
      '<div class="em-animateur"><i class="fa-solid fa-circle-user"></i>' + esc(e.artiste_nom || 'Animateur') + '</div>' +
      '<div class="em-invites-wrap">' +
        '<div class="em-invites-lbl"><i class="fa-solid fa-users"></i> Invités</div>' +
        '<div class="em-invites-chips inv-zone-' + e.id + '"><span style="font-size:.7rem;color:var(--text-3);font-style:italic">…</span></div>' +
      '</div>' +
      '<div class="em-footer">' +
        '<div class="em-stats">' +
          '<button class="em-stat-btn em-view-stat' + (isViewed ? ' viewed' : '') + '" data-id="' + e.id + '">' +
            '<i class="fa-regular fa-eye"></i><span class="em-vc">' + fmt(e.views) + '</span>' +
          '</button>' +
          '<button class="em-stat-btn em-like-stat' + (isLiked ? ' liked' : '') + '" data-id="' + e.id + '">' +
            '<i class="fa-' + (isLiked ? 'solid' : 'regular') + ' fa-heart"></i><span class="em-lc">' + fmt(e.likes) + '</span>' +
          '</button>' +
        '</div>' +
        (e.date_fmt ? '<span style="font-size:.65rem;color:var(--text-3)">' + esc(e.date_fmt) + '</span>' : '') +
      '</div>' +
    '</div>' +
  '</div>';
}

function cardList(e, i) {
  var isLiked = likedSet.has(e.id);
  return '<div class="emission-card" data-idx="' + i + '" data-id="' + e.id + '">' +
    '<div class="em-thumb">' +
      '<img src="' + esc(e.image_url || NO_IMG) + '" alt="' + esc(e.titre) + '" loading="lazy" onerror="this.src=\'' + NO_IMG + '\'">' +
      '<div class="em-overlay"></div>' +
    '</div>' +
    '<div class="em-body">' +
      '<p class="em-title">' + (e.numero_emission ? '<span style="color:#93c5fd;font-size:.68rem">N°' + e.numero_emission + ' · </span>' : '') + esc(e.titre) + '</p>' +
      '<div class="em-footer">' +
        '<span class="em-animateur" style="border-top:none;margin:0"><i class="fa-solid fa-circle-user"></i>' + esc(e.artiste_nom || '') + '</span>' +
        '<div class="em-stats">' +
          '<button class="em-stat-btn em-view-stat" data-id="' + e.id + '"><i class="fa-regular fa-eye"></i><span class="em-vc">' + fmt(e.views) + '</span></button>' +
          '<button class="em-stat-btn em-like-stat' + (isLiked ? ' liked' : '') + '" data-id="' + e.id + '"><i class="fa-' + (isLiked ? 'solid' : 'regular') + ' fa-heart"></i><span class="em-lc">' + fmt(e.likes) + '</span></button>' +
        '</div>' +
      '</div>' +
    '</div>' +
    '<button class="em-play-btn em-play-trigger" style="position:static;opacity:1;transform:none;margin:0 12px;flex-shrink:0"><i class="fa-solid fa-play"></i></button>' +
  '</div>';
}

function bindCardEvents() {
  grid.querySelectorAll('.emission-card').forEach(function(card) {
    var idx = parseInt(card.dataset.idx);
    var id  = parseInt(card.dataset.id);

    card.addEventListener('click', function(e) {
      if (e.target.closest('.em-stat-btn') ||
          e.target.closest('.invite-chip') ||
          e.target.closest('.em-invites-wrap')) return;
      playAt(idx);
    });

    card.querySelectorAll('.em-play-trigger').forEach(function(b) {
      b.addEventListener('click', function(e) { e.stopPropagation(); playAt(idx); });
    });

    var vBtn = card.querySelector('.em-view-stat');
    if (vBtn) vBtn.addEventListener('click', function(e) { e.stopPropagation(); incrView(id, vBtn); });

    var lBtn = card.querySelector('.em-like-stat');
    if (lBtn) lBtn.addEventListener('click', function(e) { e.stopPropagation(); toggleLike(id, lBtn); });
  });
}

// ── INVITÉS CHIPS ─────────────────────────────────────────────────────────────
async function loadInvites(emId) {
  var zone = grid.querySelector('.inv-zone-' + emId);
  if (!zone) return;
  if (inviteCache[emId] !== undefined) { renderChips(zone, inviteCache[emId]); return; }
  var data = await rcApi({ type:'emission_invites', action:'list', emission_id: emId });
  inviteCache[emId] = data || [];
  renderChips(zone, inviteCache[emId]);
}

function renderChips(zone, invites) {
  if (!invites.length) {
    zone.innerHTML = '<span style="font-size:.7rem;color:var(--text-3);font-style:italic">Aucun invité</span>';
    return;
  }
  var html = '';
  for (var i = 0; i < invites.length; i++) {
    var inv  = invites[i];
    var nom  = inv.nom || 'Invité';
    var init = nom.split(' ').map(function(w) { return w[0] || ''; }).join('').substring(0, 2).toUpperCase();
    var av   = inv.image_url
      ? '<img class="chip-av" src="' + esc(inv.image_url) + '" alt="" onerror="this.style.display=\'none\';this.nextSibling.style.display=\'flex\'"><span class="chip-init" style="display:none">' + init + '</span>'
      : '<span class="chip-init">' + init + '</span>';
    html += '<button class="invite-chip" data-inv="' + i + '" data-aid="' + (inv.artiste_id || '') + '">' + av + '<span class="chip-nm">' + esc(nom) + '</span></button>';
  }
  zone.innerHTML = html;

  zone.querySelectorAll('.invite-chip').forEach(function(chip) {
    chip.addEventListener('click', function(e) {
      e.stopPropagation();
      var idx = parseInt(chip.dataset.inv);
      var inv = invites[idx];
      openInviteModal(inv, chip.dataset.aid || null);
    });
  });
}

// ════════════════════════════════════════════════════════
//   MODAL INVITÉ
//   - Artiste interne → artisteDetail (chansons + interviews par artiste_id)
//   - Invité externe  → interviews dans inv.interviews (cherchées par artiste_nom)
// ════════════════════════════════════════════════════════
function ensureInviteModal() {
  if (document.getElementById('inviteModal')) return;
  var el = document.createElement('div');
  el.id = 'inviteModal';
  el.innerHTML =
    '<div id="inviteModalBox">' +
      '<button class="inv-close" id="invCloseBtn"><i class="fa-solid fa-xmark"></i></button>' +
      '<div id="inviteModalContent"></div>' +
    '</div>';
  document.body.appendChild(el);
  document.getElementById('invCloseBtn').addEventListener('click', closeInviteModal);
  document.getElementById('inviteModal').addEventListener('click', function(e) {
    if (e.target === document.getElementById('inviteModal')) closeInviteModal();
  });
}

async function openInviteModal(invData, artisteId) {
  ensureInviteModal();
  var modal   = document.getElementById('inviteModal');
  var content = document.getElementById('inviteModalContent');
  modal.scrollTop = 0;
  content.innerHTML = '<div class="inv-loading"><i class="fa-solid fa-spinner fa-spin"></i> Chargement…</div>';
  modal.classList.add('open');
  document.body.style.overflow = 'hidden';

  if (artisteId) {
    var detail = await rcApi({ type:'artistes', action:'detail', id: artisteId });
    if (detail) { renderInviteArtiste(content, detail); return; }
  }
  // Invité externe — les interviews sont déjà dans invData.interviews (chargées par l'API)
  renderInviteExterne(content, invData);
}

// ─── Artiste interne ──────────────────────────────────────────────────────────
function renderInviteArtiste(content, a) {
  var img      = a.image_url || NO_IMG;
  var initials = String(a.nom || '?').split(' ').map(function(w) { return w[0] || ''; }).join('').substring(0, 2).toUpperCase();
  var nbS = parseInt(a.nb_chansons)   || 0;
  var nbI = parseInt(a.nb_interviews) || 0;
  var songs      = a.songs      || [];
  var interviews = a.interviews || [];

  content.innerHTML =
    '<div class="inv-header">' +
      '<img class="inv-avatar-lg" src="' + esc(img) + '" alt="' + esc(a.nom) + '" onerror="this.style.display=\'none\';this.nextSibling.style.display=\'flex\'">' +
      '<div class="inv-initials-lg" style="display:none">' + initials + '</div>' +
      '<div class="inv-meta">' +
        '<div class="inv-name">' + esc(a.nom) + '</div>' +
        '<div class="inv-type">' + esc(a.categorie_nom || 'Artiste Chaâbi') + '</div>' +
        '<div class="inv-chips-sm">' +
          '<span class="inv-chip-sm"><i class="fa-solid fa-music"></i>' + fmt(nbS) + ' chanson' + (nbS !== 1 ? 's' : '') + '</span>' +
          (nbI > 0 ? '<span class="inv-chip-sm"><i class="fa-solid fa-microphone-lines"></i>' + fmt(nbI) + ' interview' + (nbI !== 1 ? 's' : '') + '</span>' : '') +
          '<span class="inv-chip-sm"><i class="fa-regular fa-eye"></i>' + fmt(a.views) + '</span>' +
        '</div>' +
      '</div>' +
    '</div>' +
    (a.bio ? '<div class="inv-bio">' + esc(a.bio) + '</div>' : '') +
    '<div class="inv-tabs">' +
      '<button class="inv-tab active" data-panel="invPS"><i class="fa-solid fa-headphones"></i> Chansons <span class="inv-tab-count">' + fmt(nbS) + '</span></button>' +
      '<button class="inv-tab" data-panel="invPI"><i class="fa-solid fa-microphone-lines"></i> Interviews <span class="inv-tab-count">' + fmt(nbI) + '</span></button>' +
    '</div>' +
    '<div class="inv-tab-panel active" id="invPS">' + buildMediaRows(songs,      'song')      + '</div>' +
    '<div class="inv-tab-panel"        id="invPI">' + buildMediaRows(interviews, 'interview') + '</div>';

  bindInvModalTabs(content);
  bindInvModalRows(content, songs, interviews, a.nom);
}

// ─── Invité externe ───────────────────────────────────────────────────────────
function renderInviteExterne(content, inv) {
  var nom      = inv.nom || 'Invité';
  var initials = nom.split(' ').map(function(w) { return w[0] || ''; }).join('').substring(0, 2).toUpperCase();
  var img      = inv.image_url || '';
  var interviews = inv.interviews || [];  // ← chargées par l'API (search par artiste_nom)
  var nbI = interviews.length;

  content.innerHTML =
    '<div class="inv-header">' +
      (img
        ? '<img class="inv-avatar-lg" src="' + esc(img) + '" alt="' + esc(nom) + '" onerror="this.style.display=\'none\';this.nextSibling.style.display=\'flex\'"><div class="inv-initials-lg" style="display:none">' + initials + '</div>'
        : '<div class="inv-initials-lg">' + initials + '</div>') +
      '<div class="inv-meta">' +
        '<div class="inv-name">' + esc(nom) + '</div>' +
        '<div class="inv-type">' + esc(inv.invite_externe_type || 'Invité') + '</div>' +
        '<div class="inv-chips-sm">' +
          (nbI > 0 ? '<span class="inv-chip-sm"><i class="fa-solid fa-microphone-lines"></i>' + fmt(nbI) + ' interview' + (nbI !== 1 ? 's' : '') + '</span>' : '') +
        '</div>' +
      '</div>' +
    '</div>' +
    (inv.bio ? '<div class="inv-bio">' + esc(inv.bio) + '</div>' : '') +
    (nbI > 0
      ? '<div class="inv-tabs">' +
          '<button class="inv-tab active" data-panel="invPExtI"><i class="fa-solid fa-microphone-lines"></i> Interviews <span class="inv-tab-count">' + fmt(nbI) + '</span></button>' +
        '</div>' +
        '<div class="inv-tab-panel active" id="invPExtI">' + buildMediaRows(interviews, 'interview') + '</div>'
      : (inv.bio ? '' : '<div class="inv-bio" style="color:var(--text-3)">Aucune biographie ni interview disponible.</div>'));

  if (nbI > 0) {
    bindInvModalRows(content, [], interviews, nom);
  }
}

// ─── Helpers modal ────────────────────────────────────────────────────────────
function buildMediaRows(items, type) {
  if (!items.length) {
    return '<p class="inv-empty">Aucun' + (type === 'song' ? 'e chanson' : 'e interview') + ' disponible.</p>';
  }
  var html = '';
  for (var i = 0; i < items.length; i++) {
    var item = items[i];
    html +=
      '<div class="inv-row" data-type="' + type + '" data-idx="' + i + '">' +
        '<span class="inv-rnum">' + (i + 1) + '</span>' +
        '<img class="inv-rimg" src="' + esc(item.image_url || NO_IMG) + '" alt="" onerror="this.src=\'' + NO_IMG + '\'">' +
        '<div class="inv-rinfo">' +
          '<div class="inv-rtitle">' + esc(item.titre || item.artiste_nom || '—') + '</div>' +
          '<div class="inv-rsub">' + (type === 'interview' && item.date_fmt ? '<i class="fa-regular fa-calendar"></i> ' + esc(item.date_fmt) : esc(item.categorie_nom || '')) + '</div>' +
        '</div>' +
        '<div class="inv-rplay"><i class="fa-solid fa-play"></i></div>' +
      '</div>';
  }
  return html;
}

function bindInvModalTabs(content) {
  content.querySelectorAll('.inv-tab').forEach(function(tab) {
    tab.addEventListener('click', function() {
      content.querySelectorAll('.inv-tab').forEach(function(t) { t.classList.remove('active'); });
      content.querySelectorAll('.inv-tab-panel').forEach(function(p) { p.classList.remove('active'); });
      tab.classList.add('active');
      var panel = document.getElementById(tab.dataset.panel);
      if (panel) panel.classList.add('active');
    });
  });
}

function bindInvModalRows(content, songs, interviews, artistName) {
  content.querySelectorAll('.inv-row').forEach(function(row) {
    row.addEventListener('click', function() {
      var type  = row.dataset.type;
      var i     = parseInt(row.dataset.idx);
      var items = type === 'song' ? songs : interviews;
      var item  = items[i];
      if (!item || !item.audio_url) { rcToast('Audio non disponible', 'error'); return; }

      var panel = row.closest('.inv-tab-panel');
      if (panel) {
        panel.querySelectorAll('.inv-row').forEach(function(r) {
          r.classList.remove('active');
          r.querySelector('.inv-rplay').innerHTML = '<i class="fa-solid fa-play"></i>';
        });
      }
      row.classList.add('active');
      row.querySelector('.inv-rplay').innerHTML = '<i class="fa-solid fa-pause"></i>';

      var rcType = type === 'song' ? 'songs' : 'interviews';
      rcPlay(
        item.audio_url,
        { img: item.image_url || NO_IMG, title: item.titre || item.artiste_nom, artist: artistName, type: rcType },
        items, i, rcType
      );
      rcApiIncrement(rcType, item.id, 'view');
      rcToast('▶ ' + (item.titre || item.artiste_nom));
    });
  });
}

function closeInviteModal() {
  var m = document.getElementById('inviteModal');
  if (m) m.classList.remove('open');
  document.body.style.overflow = '';
}

// ── VUES / LIKES ──────────────────────────────────────────────────────────────
function incrView(id, btn) {
  if (!btn || viewedSet.has(id)) return;
  viewedSet.add(id);
  rcApiIncrement('emissions', id, 'view');
  btn.classList.add('viewed');
  var sp = btn.querySelector('.em-vc');
  if (sp) sp.textContent = fmt((parseN(sp.textContent) || 0) + 1);
}

function toggleLike(id, btn) {
  var isLiked = likedSet.has(id);
  var sp   = btn.querySelector('.em-lc');
  var icon = btn.querySelector('i');
  var n    = parseN(sp ? sp.textContent : '0') || 0;
  if (isLiked) {
    likedSet.delete(id); btn.classList.remove('liked');
    if (icon) icon.className = 'fa-regular fa-heart';
    if (sp)   sp.textContent = fmt(Math.max(0, n - 1));
  } else {
    likedSet.add(id); btn.classList.add('liked');
    if (icon) icon.className = 'fa-solid fa-heart';
    if (sp)   sp.textContent = fmt(n + 1);
    rcApiIncrement('emissions', id, 'like');
    rcToast('Émission aimée ❤', 'success');
  }
  localStorage.setItem('rc_liked_emissions', JSON.stringify(Array.from(likedSet)));
}

// ── LECTURE ───────────────────────────────────────────────────────────────────
function playAt(idx) {
  var e = state.items[idx];
  if (!e || !e.audio_url) { rcToast('Audio non disponible', 'error'); return; }

  grid.querySelectorAll('.emission-card').forEach(function(c, i) {
    c.classList.toggle('playing', i === idx);
    var pi = c.querySelector('.em-play-btn i');
    if (pi) pi.className = (i === idx) ? 'fa-solid fa-pause' : 'fa-solid fa-play';
  });

  rcPlay(
    e.audio_url,
    { img: e.image_url || NO_IMG, title: e.titre, artist: e.artiste_nom, type: 'emissions' },
    state.items, idx, 'emissions'
  );
  incrView(e.id, grid.querySelector('.emission-card[data-idx="' + idx + '"] .em-view-stat'));
  rcToast('▶ ' + e.titre);
}

function parseN(s) {
  return parseInt(String(s || '0').replace(/\s/g, '')) || 0;
}
