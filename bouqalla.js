'use strict';
/* ══════════════════════════════════════════════
   BOUQALLA.JS
   Affichage des bouqallates (proverbes algériens)
   - Vue cartes / tableau switchable
   - Filtre par langue affichée
   - Recherche (arabe / phonétique / français)
   - Modal détail avec navigation précédent/suivant
══════════════════════════════════════════════ */

const PER_PAGE = 30;

let state = {
  page:1, view:'cards', lang:'all',
  q:'', total:0, items:[], loading:false
};

let modalIdx = -1; // index de la bouqalla ouverte dans la modale

const grid      = document.getElementById('bouqallaGrid');
const pagEl     = document.getElementById('pagination');
const searchBox = document.getElementById('searchBox');
const heroCount = document.getElementById('heroCount');
const langInd   = document.getElementById('langIndicator');

// ── INIT ──────────────────────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
  state.q    = rcParams.get('q')    || '';
  state.page = parseInt(rcParams.get('page')) || 1;
  state.lang = rcParams.get('lang') || 'all';
  if (state.q) {
    searchBox.value = state.q;
    document.getElementById('searchClear').style.display = 'block';
  }
  // Activer le bon pill langue
  document.querySelectorAll('#langPills .pill').forEach(p =>
    p.classList.toggle('active', p.dataset.lang === state.lang)
  );
  load();
});

// ── LOAD ──────────────────────────────────────────────────────────────────────
async function load() {
  if (state.loading) return;
  state.loading = true;
  renderSkeletons();

  const data = await rcApi({
    type:   'bouqalla',
    action: 'list',
    limit:   PER_PAGE,
    offset:  (state.page - 1) * PER_PAGE,
    ...(state.q && { q: state.q }),
  });

  state.loading = false;

  if (!data) {
    grid.innerHTML = `<div class="error-state">
      <i class="fa-solid fa-triangle-exclamation"></i>
      <p>Impossible de charger les bouqallates.</p>
    </div>`;
    return;
  }

  state.items = data.items;
  state.total = data.total;
  heroCount.textContent = fmt(data.total);

  renderItems();
  buildPagination(pagEl, {
    current:  state.page,
    total:    state.total,
    perPage:  PER_PAGE,
    onChange(p) {
      state.page = p;
      rcParams.set('page', p);
      load();
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
  });

  updateLangIndicator();
  setTimeout(() => grid.classList.add('visible'), 50);
}

// ── SKELETONS ─────────────────────────────────────────────────────────────────
function renderSkeletons() {
  grid.className = `bouqalla-grid reveal${state.view === 'table' ? ' table-view' : ''}`;
  grid.innerHTML = Array.from({ length: 12 }, () =>
    `<div class="bq-skeleton skeleton" style="height:180px"></div>`
  ).join('');
}

// ── RENDER ────────────────────────────────────────────────────────────────────
function renderItems() {
  if (!state.items.length) {
    grid.className = 'bouqalla-grid reveal';
    grid.innerHTML = `<div class="empty-state">
      <i class="fa-solid fa-scroll"></i>
      <p>Aucune bouqalla trouvée${state.q ? ` pour « ${esc(state.q)} »` : ''}.</p>
    </div>`;
    return;
  }

  if (state.view === 'table') {
    renderTable();
  } else {
    renderCards();
  }
}

// ── VUE CARTES ────────────────────────────────────────────────────────────────
function renderCards() {
  grid.className = 'bouqalla-grid reveal';
  const showAr  = state.lang === 'all' || state.lang === 'ar';
  const showPh  = state.lang === 'all' || state.lang === 'ph';
  const showFr  = state.lang === 'all' || state.lang === 'fr';

  grid.innerHTML = state.items.map((b, i) => `
    <div class="bq-card" data-idx="${i}" role="button" tabindex="0"
         aria-label="Bouqalla n°${b.num || i + 1}">
      <span class="bq-num">N° ${b.num || (state.page - 1) * PER_PAGE + i + 1}</span>

      ${showAr && b.arabe ? `
        <div class="bq-arabe" lang="ar" dir="rtl">${esc(b.arabe)}</div>
      ` : ''}

      ${(showAr && b.arabe && (showPh || showFr)) ? '<div class="bq-sep"></div>' : ''}

      ${showPh && b.phonetic ? `
        <div class="bq-phonetic">${esc(b.phonetic)}</div>
      ` : ''}

      ${showFr && b['français'] ? `
        <div class="bq-fr">${esc(b['français'])}</div>
      ` : ''}
    </div>`).join('');

  grid.querySelectorAll('.bq-card').forEach((card, i) => {
    card.addEventListener('click', () => openModal(i));
    card.addEventListener('keydown', e => { if (e.key === 'Enter') openModal(i); });
  });
}

// ── VUE TABLEAU ───────────────────────────────────────────────────────────────
function renderTable() {
  grid.className = 'bouqalla-grid table-view reveal';
  const showPh = state.lang === 'all' || state.lang === 'ph';
  const showFr = state.lang === 'all' || state.lang === 'fr';
  const showAr = state.lang === 'all' || state.lang === 'ar';

  grid.innerHTML = `
    <table class="bq-table">
      <thead>
        <tr>
          <th class="col-num">#</th>
          ${showAr ? '<th class="col-ar">النص العربي</th>' : ''}
          ${showPh ? '<th class="col-ph">Phonétique</th>'  : ''}
          ${showFr ? '<th class="col-fr">Français</th>'    : ''}
        </tr>
      </thead>
      <tbody>
        ${state.items.map((b, i) => `
          <tr data-idx="${i}">
            <td class="td-num">${b.num || (state.page - 1) * PER_PAGE + i + 1}</td>
            ${showAr ? `<td class="td-ar" lang="ar" dir="rtl">${esc(b.arabe || '—')}</td>` : ''}
            ${showPh ? `<td class="td-ph">${esc(b.phonetic || '—')}</td>`   : ''}
            ${showFr ? `<td class="td-fr">${esc(b['français'] || '—')}</td>` : ''}
          </tr>`).join('')}
      </tbody>
    </table>`;

  grid.querySelectorAll('tbody tr').forEach(row => {
    row.addEventListener('click', () => openModal(parseInt(row.dataset.idx)));
  });
}

// ── MODAL DÉTAIL ──────────────────────────────────────────────────────────────
function openModal(idx) {
  if (idx < 0 || idx >= state.items.length) return;
  modalIdx = idx;
  const b = state.items[idx];

  const content = document.getElementById('bModalContent');
  content.innerHTML = `
    <div class="bm-wrap">
      <div class="bm-num">
        <i class="fa-solid fa-scroll"></i>
        Bouqalla N° ${b.num || idx + 1}
      </div>

      ${b.arabe ? `
        <div class="bm-section-lbl lbl-ar"><i class="fa-solid fa-star-and-crescent"></i> Texte arabe</div>
        <div class="bm-arabe" lang="ar" dir="rtl">${esc(b.arabe)}</div>
      ` : ''}

      ${b.phonetic ? `
        <div class="bm-section-lbl lbl-ph"><i class="fa-solid fa-volume-high"></i> Phonétique</div>
        <div class="bm-phonetic">${esc(b.phonetic)}</div>
      ` : ''}

      ${b['français'] ? `
        <div class="bm-section-lbl lbl-fr"><i class="fa-solid fa-flag"></i> Traduction française</div>
        <div class="bm-fr">${esc(b['français'])}</div>
      ` : ''}

      <div class="bm-nav">
        <button class="bm-nav-btn" id="bPrev" ${idx === 0 ? 'disabled' : ''}>
          <i class="fa-solid fa-chevron-left"></i> Précédente
        </button>
        <span style="font-size:.72rem;color:var(--text-3);align-self:center">
          ${idx + 1} / ${state.items.length}
        </span>
        <button class="bm-nav-btn" id="bNext" ${idx === state.items.length - 1 ? 'disabled' : ''}>
          Suivante <i class="fa-solid fa-chevron-right"></i>
        </button>
      </div>
    </div>`;

  // Navigation dans la modale
  document.getElementById('bPrev')?.addEventListener('click', () => { if (modalIdx > 0) openModal(modalIdx - 1); });
  document.getElementById('bNext')?.addEventListener('click', () => { if (modalIdx < state.items.length - 1) openModal(modalIdx + 1); });

  document.getElementById('bModal').classList.add('open');
  document.body.style.overflow = 'hidden';
}

function closeModal() {
  document.getElementById('bModal').classList.remove('open');
  document.body.style.overflow = '';
}

document.getElementById('bModalClose').addEventListener('click', closeModal);
document.getElementById('bModal').addEventListener('click', e => {
  if (e.target === document.getElementById('bModal')) closeModal();
});

// Navigation clavier dans la modale
document.addEventListener('keydown', e => {
  if (!document.getElementById('bModal').classList.contains('open')) return;
  if (e.key === 'ArrowLeft'  && modalIdx > 0)                   openModal(modalIdx - 1);
  if (e.key === 'ArrowRight' && modalIdx < state.items.length - 1) openModal(modalIdx + 1);
  if (e.key === 'Escape') closeModal();
});

// ── INDICATEUR LANGUE ─────────────────────────────────────────────────────────
const LANG_LABELS = {
  all: '',
  ar:  '<i class="fa-solid fa-star-and-crescent"></i> Affichage : texte arabe uniquement',
  ph:  '<i class="fa-solid fa-volume-high"></i> Affichage : phonétique uniquement',
  fr:  '<i class="fa-solid fa-flag"></i> Affichage : traduction française uniquement',
};
function updateLangIndicator() {
  langInd.innerHTML = LANG_LABELS[state.lang] || '';
}

// ── CONTRÔLES ─────────────────────────────────────────────────────────────────
// Filtre langue
document.getElementById('langPills').addEventListener('click', e => {
  const pill = e.target.closest('.pill'); if (!pill) return;
  document.querySelectorAll('#langPills .pill').forEach(p => p.classList.remove('active'));
  pill.classList.add('active');
  state.lang = pill.dataset.lang;
  rcParams.set('lang', state.lang);
  renderItems();         // pas de rechargement, juste re-rendu côté client
  updateLangIndicator();
});

// Toggle vue cartes / tableau
document.querySelectorAll('.view-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.view-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    state.view = btn.dataset.view;
    renderItems();
  });
});

// Recherche
let searchTimer;
searchBox.addEventListener('input', () => {
  const cl = document.getElementById('searchClear');
  cl.style.display = searchBox.value ? 'block' : 'none';
  clearTimeout(searchTimer);
  searchTimer = setTimeout(() => {
    state.q    = searchBox.value.trim();
    state.page = 1;
    rcParams.set('q', state.q);
    rcParams.set('page', 1);
    load();
  }, 380);
});

document.getElementById('searchClear').addEventListener('click', () => {
  searchBox.value = '';
  state.q    = '';
  state.page = 1;
  document.getElementById('searchClear').style.display = 'none';
  rcParams.set('q', '');
  rcParams.set('page', 1);
  load();
});
