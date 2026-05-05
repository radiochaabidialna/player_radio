<?php
/* ═══════════════════════════════════════════════════════════
   API Chaabi Music — Compatible PHP 7.4+ / WAMP
   ✓ Pas de "never", "match", "str_starts_with" (PHP 8.x only)
   ✓ artisteDetail : toutes chansons + toutes interviews sans LIMIT
   ✓ Invité externe : interviews cherchées par artiste_nom
   ✓ LIMIT/OFFSET interpolés directement (fix HY093)
   ✓ Wrapper try/catch global pour capturer toute erreur PHP
═══════════════════════════════════════════════════════════ */

// Supprime tout affichage d'erreur PHP (ne jamais polluer le JSON)
error_reporting(0);
ini_set('display_errors',         '0');
ini_set('display_startup_errors', '0');

// Encapsulation globale : si une exception non interceptée survient,
// on retourne quand même du JSON valide
set_exception_handler(function($e) {
    http_response_code(500);
    echo json_encode(array('success' => false, 'error' => $e->getMessage()), JSON_UNESCAPED_UNICODE);
    exit;
});

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

// ─────────────────────────────────────────────────────────────
//  Configuration — adapter à ton serveur
// ─────────────────────────────────────────────────────────────
define('DB_HOST',  'localhost');
define('DB_NAME',  'chaabi_music_v4');
define('DB_USER',  'root');
define('DB_PASS',  'root');
define('BASE_URL', '/music/');   // chemin racine de tes médias

// ─────────────────────────────────────────────────────────────
//  PDO singleton
// ─────────────────────────────────────────────────────────────
function getPdo() {
    static $pdo = null;
    if ($pdo !== null) { return $pdo; }
    try {
        $pdo = new PDO(
            'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4',
            DB_USER,
            DB_PASS,
            array(
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                // true = PDO substitue les params côté PHP
                // → accepte :q utilisé plusieurs fois dans la même requête
                // → évite HY093 "Invalid parameter number"
                PDO::ATTR_EMULATE_PREPARES   => true,
            )
        );
    } catch (PDOException $e) {
        apiError('Connexion BDD impossible : ' . $e->getMessage(), 500);
    }
    return $pdo;
}

// ─────────────────────────────────────────────────────────────
//  Helpers
// ─────────────────────────────────────────────────────────────
function apiOk($data) {
    echo json_encode(array('success' => true, 'data' => $data), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function apiError($msg, $code = 400) {
    http_response_code($code);
    echo json_encode(array('success' => false, 'error' => (string)$msg), JSON_UNESCAPED_UNICODE);
    exit;
}

// Compatible PHP 7.4 (str_starts_with n'existe que depuis PHP 8.0)
function mediaUrl($path) {
    $path = (string)$path;
    if ($path === '') { return ''; }
    if (strpos($path, 'http://') === 0 || strpos($path, 'https://') === 0) {
        return $path;
    }
    return BASE_URL . ltrim($path, '/');
}

// Entier sûr issu de $_GET
function gInt($key, $default = 0, $min = 0, $max = 99999) {
    $v = isset($_GET[$key]) ? (int)$_GET[$key] : $default;
    return max($min, min($max, $v));
}

// Chaîne de recherche nettoyée
function gQ() {
    return isset($_GET['q']) ? trim($_GET['q']) : '';
}

// Date formatée (compatible PHP 7.4)
function fmtDate($val) {
    if (empty($val)) { return ''; }
    $ts = strtotime($val);
    return $ts ? date('d/m/Y', $ts) : '';
}

// ─────────────────────────────────────────────────────────────
//  Routing principal (PHP 7.4 : pas de match)
// ─────────────────────────────────────────────────────────────
$type   = isset($_GET['type'])   ? trim($_GET['type'])   : '';
$action = isset($_GET['action']) ? trim($_GET['action']) : 'list';

if ($action === 'stats') { doStats(); }

$validTypes = array('songs','emissions','interviews','artistes','dedicaces','bouqalla','emission_invites');
if (!in_array($type, $validTypes, true)) { apiError('Type invalide : ' . $type); }

if ($action === 'list') {
    if      ($type === 'songs')            { listSongs(); }
    elseif  ($type === 'emissions')        { listEmissions(); }
    elseif  ($type === 'interviews')       { listInterviews(); }
    elseif  ($type === 'artistes')         { listArtistes(); }
    elseif  ($type === 'dedicaces')        { listDedicaces(); }
    elseif  ($type === 'bouqalla')         { listBouqalla(); }
    elseif  ($type === 'emission_invites') { listEmissionInvites(); }
    else    { apiError('Type list inconnu'); }

} elseif ($action === 'detail') {
    if ($type === 'artistes') { artisteDetail(); }
    else { apiError('detail non disponible'); }

} elseif ($action === 'top') {
    if      ($type === 'songs')    { topSongs(); }
    elseif  ($type === 'artistes') { topArtistes(); }
    else    { apiError('top non disponible'); }

} elseif ($action === 'recent') {
    if      ($type === 'emissions')  { recentEmissions(); }
    elseif  ($type === 'interviews') { recentInterviews(); }
    elseif  ($type === 'dedicaces')  { recentDedicaces(); }
    else    { apiError('recent non disponible'); }

} elseif ($action === 'view' || $action === 'like') {
    doIncrement($type, $action);

} else {
    apiError('Action inconnue : ' . $action);
}

// ═════════════════════════════════════════════════════════════
//  STATS
// ═════════════════════════════════════════════════════════════
function doStats() {
    $p = getPdo();
    $v = (int)$p->query("SELECT COALESCE(SUM(views),0) FROM chansons")->fetchColumn()
       + (int)$p->query("SELECT COALESCE(SUM(views),0) FROM emissions")->fetchColumn()
       + (int)$p->query("SELECT COALESCE(SUM(views),0) FROM interviews")->fetchColumn();
    apiOk(array(
        'artistes'    => (int)$p->query("SELECT COUNT(*) FROM artistes")->fetchColumn(),
        'chansons'    => (int)$p->query("SELECT COUNT(*) FROM chansons")->fetchColumn(),
        'emissions'   => (int)$p->query("SELECT COUNT(*) FROM emissions")->fetchColumn(),
        'interviews'  => (int)$p->query("SELECT COUNT(*) FROM interviews")->fetchColumn(),
        'dedicaces'   => (int)$p->query("SELECT COUNT(*) FROM dedicaces")->fetchColumn(),
        'bouqalla'    => (int)$p->query("SELECT COUNT(*) FROM bouqalla")->fetchColumn(),
        'total_views' => $v,
    ));
}

// ═════════════════════════════════════════════════════════════
//  ARTISTE DETAIL
//  Toutes chansons + toutes interviews (sans LIMIT)
// ═════════════════════════════════════════════════════════════
function artisteDetail() {
    $id = gInt('id', 0, 1);
    if ($id <= 0) { apiError('ID artiste requis'); }

    $stmt = getPdo()->prepare(
        "SELECT a.*, cat.nom AS categorie_nom,
                (SELECT COUNT(*) FROM chansons   WHERE artiste_id = a.id) AS nb_chansons,
                (SELECT COUNT(*) FROM interviews WHERE artiste_id = a.id) AS nb_interviews
         FROM artistes a
         LEFT JOIN categories cat ON a.categorie_id = cat.id
         WHERE a.id = :id"
    );
    $stmt->execute(array(':id' => $id));
    $artiste = $stmt->fetch();
    if (!$artiste) { apiError('Artiste non trouvé', 404); }
    $artiste['image_url'] = mediaUrl($artiste['image']);

    // Toutes les chansons, sans LIMIT
    $stmt2 = getPdo()->prepare(
        "SELECT c.id, c.titre, c.audio, c.image, c.views, c.likes, cat.nom AS categorie_nom
         FROM chansons c
         LEFT JOIN categories cat ON c.categorie_id = cat.id
         WHERE c.artiste_id = :id
         ORDER BY c.views DESC"
    );
    $stmt2->execute(array(':id' => $id));
    $songs = $stmt2->fetchAll();
    foreach ($songs as &$r) {
        $r['audio_url']  = mediaUrl($r['audio']);
        $r['image_url']  = mediaUrl($r['image']);
        $r['media_type'] = 'song';
    }
    unset($r);

    // Toutes les interviews par artiste_id, sans LIMIT
    $stmt3 = getPdo()->prepare(
        "SELECT i.id, i.artiste_nom, i.audio, i.image, i.views, i.likes,
                i.date_interview, cat.nom AS categorie_nom
         FROM interviews i
         LEFT JOIN categories cat ON i.categorie_id = cat.id
         WHERE i.artiste_id = :id
         ORDER BY i.date_interview DESC"
    );
    $stmt3->execute(array(':id' => $id));
    $interviews = $stmt3->fetchAll();
    foreach ($interviews as &$r) {
        $r['audio_url']  = mediaUrl($r['audio']);
        $r['image_url']  = mediaUrl($r['image']);
        $r['titre']      = $r['artiste_nom'];
        $r['date_fmt']   = fmtDate($r['date_interview']);
        $r['media_type'] = 'interview';
    }
    unset($r);

    // Émissions auxquelles l'artiste a participé
    // CAS 1 : référencé comme artiste interne (artiste_id = id)
    // CAS 2 : référencé comme invité externe (invite_externe_nom LIKE nom)
    $stmt4 = getPdo()->prepare(
        "SELECT DISTINCT e.id, e.numero_emission, e.titre, e.image, e.audio,
                e.views, e.likes, e.date_emission, cat.nom AS categorie_nom
         FROM emission_invites ei
         JOIN emissions   e   ON ei.emission_id  = e.id
         LEFT JOIN categories cat ON e.categorie_id = cat.id
         WHERE ei.artiste_id = :id
            OR ei.invite_externe_nom LIKE :nom
         ORDER BY e.numero_emission ASC"
    );
    $stmt4->execute(array(':id' => $id, ':nom' => '%' . $artiste['nom'] . '%'));
    $emissions = $stmt4->fetchAll();
    foreach ($emissions as &$r) {
        $r['audio_url']  = mediaUrl(isset($r['audio']) ? $r['audio'] : '');
        $r['image_url']  = mediaUrl(isset($r['image']) ? $r['image'] : '');
        $r['date_fmt']   = fmtDate($r['date_emission']);
        $r['media_type'] = 'emission';
    }
    unset($r);

    $artiste['songs']      = $songs;
    $artiste['interviews'] = $interviews;
    $artiste['emissions']  = $emissions;
    $artiste['nb_emissions'] = count($emissions);
    apiOk($artiste);
}

// ═════════════════════════════════════════════════════════════
//  TOP SONGS
// ═════════════════════════════════════════════════════════════
function topSongs() {
    $n = gInt('limit', 8, 1, 20);
    $rows = getPdo()->query(
        "SELECT c.id, c.titre, c.audio, c.image, c.views, c.likes,
                a.nom AS artiste_nom, a.image AS artiste_image, cat.nom AS categorie_nom
         FROM chansons c
         LEFT JOIN artistes   a   ON c.artiste_id   = a.id
         LEFT JOIN categories cat ON c.categorie_id = cat.id
         ORDER BY c.views DESC LIMIT $n"
    )->fetchAll();
    foreach ($rows as &$r) {
        $r['audio_url']         = mediaUrl($r['audio']);
        $r['image_url']         = mediaUrl($r['image']);
        $r['artiste_image_url'] = mediaUrl(isset($r['artiste_image']) ? $r['artiste_image'] : '');
        $r['media_type'] = 'song';
    }
    unset($r);
    apiOk($rows);
}

// ═════════════════════════════════════════════════════════════
//  TOP ARTISTES
// ═════════════════════════════════════════════════════════════
function topArtistes() {
    $n = gInt('limit', 8, 1, 20);
    $rows = getPdo()->query(
        "SELECT a.id, a.nom, a.image, a.views, a.likes, a.bio, cat.nom AS categorie_nom,
                (SELECT COUNT(*) FROM chansons WHERE artiste_id = a.id) AS nb_chansons
         FROM artistes a
         LEFT JOIN categories cat ON a.categorie_id = cat.id
         ORDER BY a.views DESC LIMIT $n"
    )->fetchAll();
    foreach ($rows as &$r) { $r['image_url'] = mediaUrl($r['image']); }
    unset($r);
    apiOk($rows);
}

// ═════════════════════════════════════════════════════════════
//  RECENT EMISSIONS
// ═════════════════════════════════════════════════════════════
function recentEmissions() {
    $n = gInt('limit', 6, 1, 20);
    $rows = getPdo()->query(
        "SELECT e.id, e.numero_emission, e.titre, e.description, e.audio, e.image,
                e.views, e.likes, e.date_emission,
                u.nom AS animateur_nom, cat.nom AS categorie_nom
         FROM emissions e
         LEFT JOIN users      u   ON e.animateur_id  = u.id
         LEFT JOIN categories cat ON e.categorie_id  = cat.id
         ORDER BY e.date_emission DESC LIMIT $n"
    )->fetchAll();
    foreach ($rows as &$r) {
        $r['audio_url']   = mediaUrl($r['audio']);
        $r['image_url']   = mediaUrl($r['image']);
        $r['artiste_nom'] = isset($r['animateur_nom']) ? $r['animateur_nom'] : 'Animateur';
        $r['media_type']  = 'emission';
        $r['date_fmt']    = fmtDate($r['date_emission']);
    }
    unset($r);
    apiOk($rows);
}

// ═════════════════════════════════════════════════════════════
//  RECENT INTERVIEWS
// ═════════════════════════════════════════════════════════════
function recentInterviews() {
    $n = gInt('limit', 6, 1, 20);
    $rows = getPdo()->query(
        "SELECT i.id, i.artiste_nom, i.audio, i.image, i.views, i.likes, i.date_interview,
                a.nom AS artiste_nom_bdd, a.image AS artiste_image, cat.nom AS categorie_nom
         FROM interviews i
         LEFT JOIN artistes   a   ON i.artiste_id   = a.id
         LEFT JOIN categories cat ON i.categorie_id = cat.id
         ORDER BY i.date_interview DESC LIMIT $n"
    )->fetchAll();
    foreach ($rows as &$r) {
        $r['audio_url']         = mediaUrl($r['audio']);
        $r['image_url']         = mediaUrl($r['image']);
        $r['artiste_image_url'] = mediaUrl(isset($r['artiste_image']) ? $r['artiste_image'] : '');
        $r['titre']             = (isset($r['artiste_nom_bdd']) && $r['artiste_nom_bdd']) ? $r['artiste_nom_bdd'] : $r['artiste_nom'];
        $r['media_type']        = 'interview';
        $r['date_fmt']          = fmtDate($r['date_interview']);
    }
    unset($r);
    apiOk($rows);
}

// ═════════════════════════════════════════════════════════════
//  RECENT DEDICACES
// ═════════════════════════════════════════════════════════════
function recentDedicaces() {
    $n = gInt('limit', 6, 1, 20);
    $rows = getPdo()->query("SELECT * FROM dedicaces ORDER BY created_at DESC LIMIT $n")->fetchAll();
    foreach ($rows as &$r) { $r['date_fmt'] = fmtDate($r['created_at']); }
    unset($r);
    apiOk($rows);
}

// ═════════════════════════════════════════════════════════════
//  LIST SONGS — recherche titre ou nom artiste
// ═════════════════════════════════════════════════════════════
function listSongs() {
    $limit  = gInt('limit',   60, 1, 500);
    $offset = gInt('offset',   0, 0);
    $q      = gQ();
    $p = array(); $w = array();

    if (!empty($_GET['categorie_id'])) {
        $w[] = 'c.categorie_id = :cat';
        $p[':cat'] = (int)$_GET['categorie_id'];
    }
    if (!empty($_GET['artiste_id'])) {
        $w[] = 'c.artiste_id = :art';
        $p[':art'] = (int)$_GET['artiste_id'];
    }
    if ($q !== '') {
        $w[] = '(c.titre LIKE :q OR a.nom LIKE :q)';
        $p[':q'] = '%' . $q . '%';
    }

    $sorts   = array('views'=>'c.views','likes'=>'c.likes','recent'=>'c.created_at','titre'=>'c.titre');
    $sortKey = isset($_GET['sort']) ? $_GET['sort'] : 'views';
    $ord     = isset($sorts[$sortKey]) ? $sorts[$sortKey] : 'c.views';
    $dir     = (isset($_GET['dir']) && $_GET['dir'] === 'ASC') ? 'ASC' : 'DESC';
    $wc      = count($w) ? 'WHERE ' . implode(' AND ', $w) : '';

    $stmt = getPdo()->prepare(
        "SELECT c.id, c.titre, c.audio, c.image, c.views, c.likes, c.categorie_id, c.created_at,
                a.id AS artiste_id, a.nom AS artiste_nom, a.image AS artiste_image,
                cat.nom AS categorie_nom
         FROM chansons c
         LEFT JOIN artistes   a   ON c.artiste_id   = a.id
         LEFT JOIN categories cat ON c.categorie_id = cat.id
         $wc ORDER BY $ord $dir LIMIT $limit OFFSET $offset"
    );
    $stmt->execute($p);
    $items = $stmt->fetchAll();

    $ct = getPdo()->prepare(
        "SELECT COUNT(*) FROM chansons c
         LEFT JOIN artistes a ON c.artiste_id = a.id $wc"
    );
    $ct->execute($p);

    foreach ($items as &$r) {
        $r['audio_url']         = mediaUrl($r['audio']);
        $r['image_url']         = mediaUrl($r['image']);
        $r['artiste_image_url'] = mediaUrl(isset($r['artiste_image']) ? $r['artiste_image'] : '');
        $r['media_type'] = 'song';
    }
    unset($r);
    apiOk(array('items'=>$items,'total'=>(int)$ct->fetchColumn(),'limit'=>$limit,'offset'=>$offset));
}

// ═════════════════════════════════════════════════════════════
//  LIST EMISSIONS — recherche titre ou description
//  Note : animateur_id référence users.id
// ═════════════════════════════════════════════════════════════
function listEmissions() {
    $limit  = gInt('limit',  60, 1, 500);
    $offset = gInt('offset',  0, 0);
    $q      = gQ();
    $p = array(); $w = array();

    if (!empty($_GET['categorie_id'])) {
        $w[] = 'e.categorie_id = :cat';
        $p[':cat'] = (int)$_GET['categorie_id'];
    }
    if ($q !== '') {
        $w[] = '(e.titre LIKE :q OR e.description LIKE :q)';
        $p[':q'] = '%' . $q . '%';
    }

    $sorts   = array('views'=>'e.views','likes'=>'e.likes','recent'=>'e.date_emission','numero'=>'e.numero_emission');
    $sortKey = isset($_GET['sort']) ? $_GET['sort'] : 'recent';
    $ord     = isset($sorts[$sortKey]) ? $sorts[$sortKey] : 'e.date_emission';
    $dir     = (isset($_GET['dir']) && $_GET['dir'] === 'ASC') ? 'ASC' : 'DESC';
    $wc      = count($w) ? 'WHERE ' . implode(' AND ', $w) : '';

    $stmt = getPdo()->prepare(
        "SELECT e.id, e.numero_emission, e.titre, e.description, e.audio, e.image,
                e.views, e.likes, e.categorie_id, e.date_emission,
                u.nom AS animateur_nom, cat.nom AS categorie_nom
         FROM emissions e
         LEFT JOIN users      u   ON e.animateur_id  = u.id
         LEFT JOIN categories cat ON e.categorie_id  = cat.id
         $wc ORDER BY $ord $dir LIMIT $limit OFFSET $offset"
    );
    $stmt->execute($p);
    $items = $stmt->fetchAll();

    $ct = getPdo()->prepare("SELECT COUNT(*) FROM emissions e $wc");
    $ct->execute($p);

    foreach ($items as &$r) {
        $r['audio_url']   = mediaUrl($r['audio']);
        $r['image_url']   = mediaUrl($r['image']);
        $r['artiste_nom'] = isset($r['animateur_nom']) ? $r['animateur_nom'] : 'Animateur';
        $r['media_type']  = 'emission';
        $r['date_fmt']    = fmtDate($r['date_emission']);
    }
    unset($r);
    apiOk(array('items'=>$items,'total'=>(int)$ct->fetchColumn(),'limit'=>$limit,'offset'=>$offset));
}

// ═════════════════════════════════════════════════════════════
//  LIST INTERVIEWS — recherche sur artiste_nom (colonne texte)
//  Structure BDD : interviews.artiste_nom = nom en clair
//                  interviews.artiste_id  = clé vers artistes.id
// ═════════════════════════════════════════════════════════════
function listInterviews() {
    $limit  = gInt('limit',  60, 1, 500);
    $offset = gInt('offset',  0, 0);
    $q      = gQ();
    $p = array(); $w = array();

    if (!empty($_GET['categorie_id'])) {
        $w[] = 'i.categorie_id = :cat';
        $p[':cat'] = (int)$_GET['categorie_id'];
    }
    if (!empty($_GET['artiste_id'])) {
        $w[] = 'i.artiste_id = :art';
        $p[':art'] = (int)$_GET['artiste_id'];
    }
    if ($q !== '') {
        // Cherche dans le champ texte artiste_nom ET dans artistes.nom (via jointure)
        $w[] = '(i.artiste_nom LIKE :q OR a.nom LIKE :q)';
        $p[':q'] = '%' . $q . '%';
    }

    $sorts   = array('views'=>'i.views','likes'=>'i.likes','recent'=>'i.date_interview');
    $sortKey = isset($_GET['sort']) ? $_GET['sort'] : 'recent';
    $ord     = isset($sorts[$sortKey]) ? $sorts[$sortKey] : 'i.date_interview';
    $dir     = (isset($_GET['dir']) && $_GET['dir'] === 'ASC') ? 'ASC' : 'DESC';
    $wc      = count($w) ? 'WHERE ' . implode(' AND ', $w) : '';

    $stmt = getPdo()->prepare(
        "SELECT i.id, i.artiste_nom, i.audio, i.image, i.views, i.likes,
                i.categorie_id, i.date_interview,
                a.id AS artiste_id, a.nom AS artiste_nom_bdd, a.image AS artiste_image,
                cat.nom AS categorie_nom
         FROM interviews i
         LEFT JOIN artistes   a   ON i.artiste_id   = a.id
         LEFT JOIN categories cat ON i.categorie_id = cat.id
         $wc ORDER BY $ord $dir LIMIT $limit OFFSET $offset"
    );
    $stmt->execute($p);
    $items = $stmt->fetchAll();

    $ct = getPdo()->prepare(
        "SELECT COUNT(*) FROM interviews i
         LEFT JOIN artistes a ON i.artiste_id = a.id $wc"
    );
    $ct->execute($p);

    foreach ($items as &$r) {
        $r['audio_url']         = mediaUrl($r['audio']);
        $r['image_url']         = mediaUrl($r['image']);
        $r['artiste_image_url'] = mediaUrl(isset($r['artiste_image']) ? $r['artiste_image'] : '');
        // titre = nom canonique : préfère la version normalisée depuis artistes
        $r['titre']             = (isset($r['artiste_nom_bdd']) && $r['artiste_nom_bdd'])
                                    ? $r['artiste_nom_bdd'] : $r['artiste_nom'];
        $r['media_type']        = 'interview';
        $r['date_fmt']          = fmtDate($r['date_interview']);
    }
    unset($r);
    apiOk(array('items'=>$items,'total'=>(int)$ct->fetchColumn(),'limit'=>$limit,'offset'=>$offset));
}

// ═════════════════════════════════════════════════════════════
//  LIST ARTISTES — recherche nom
// ═════════════════════════════════════════════════════════════
function listArtistes() {
    $limit  = gInt('limit',  60, 1, 500);
    $offset = gInt('offset',  0, 0);
    $q      = gQ();
    $p = array(); $w = array();

    if (!empty($_GET['categorie_id'])) {
        $w[] = 'a.categorie_id = :cat';
        $p[':cat'] = (int)$_GET['categorie_id'];
    }
    if ($q !== '') {
        $w[] = 'a.nom LIKE :q';
        $p[':q'] = '%' . $q . '%';
    }

    $sorts   = array('views'=>'a.views','likes'=>'a.likes','nom'=>'a.nom');
    $sortKey = isset($_GET['sort']) ? $_GET['sort'] : 'views';
    $ord     = isset($sorts[$sortKey]) ? $sorts[$sortKey] : 'a.views';
    $dir     = ($ord === 'a.nom') ? 'ASC' : 'DESC';
    $wc      = count($w) ? 'WHERE ' . implode(' AND ', $w) : '';

    $stmt = getPdo()->prepare(
        "SELECT a.id, a.nom, a.image, a.views, a.likes, a.bio,
                cat.nom AS categorie_nom,
                (SELECT COUNT(*) FROM chansons   WHERE artiste_id = a.id) AS nb_chansons,
                (SELECT COUNT(*) FROM interviews WHERE artiste_id = a.id) AS nb_interviews
         FROM artistes a
         LEFT JOIN categories cat ON a.categorie_id = cat.id
         $wc ORDER BY $ord $dir LIMIT $limit OFFSET $offset"
    );
    $stmt->execute($p);
    $items = $stmt->fetchAll();

    $ct = getPdo()->prepare("SELECT COUNT(*) FROM artistes a $wc");
    $ct->execute($p);

    foreach ($items as &$r) { $r['image_url'] = mediaUrl($r['image']); }
    unset($r);
    apiOk(array('items'=>$items,'total'=>(int)$ct->fetchColumn(),'limit'=>$limit,'offset'=>$offset));
}

// ═════════════════════════════════════════════════════════════
//  LIST DEDICACES — recherche nom, pour, description
// ═════════════════════════════════════════════════════════════
function listDedicaces() {
    $limit  = gInt('limit',  60, 1, 500);
    $offset = gInt('offset',  0, 0);
    $q      = gQ();
    $p = array(); $w = array();

    if ($q !== '') {
        $w[] = '(nom LIKE :q OR pour LIKE :q OR description LIKE :q)';
        $p[':q'] = '%' . $q . '%';
    }
    $wc = count($w) ? 'WHERE ' . implode(' AND ', $w) : '';

    $stmt = getPdo()->prepare(
        "SELECT * FROM dedicaces $wc ORDER BY created_at DESC LIMIT $limit OFFSET $offset"
    );
    $stmt->execute($p);
    $items = $stmt->fetchAll();

    $ct = getPdo()->prepare("SELECT COUNT(*) FROM dedicaces $wc");
    $ct->execute($p);

    foreach ($items as &$r) { $r['date_fmt'] = fmtDate($r['created_at']); }
    unset($r);
    apiOk(array('items'=>$items,'total'=>(int)$ct->fetchColumn(),'limit'=>$limit,'offset'=>$offset));
}

// ═════════════════════════════════════════════════════════════
//  LIST BOUQALLA — recherche arabe, phonétique, français
// ═════════════════════════════════════════════════════════════
function listBouqalla() {
    $limit  = gInt('limit',  60, 1, 500);
    $offset = gInt('offset',  0, 0);
    $q      = gQ();
    $p = array(); $w = array();

    if ($q !== '') {
        $w[] = '(arabe LIKE :q OR phonetic LIKE :q OR `français` LIKE :q)';
        $p[':q'] = '%' . $q . '%';
    }
    $wc = count($w) ? 'WHERE ' . implode(' AND ', $w) : '';

    $stmt = getPdo()->prepare(
        "SELECT * FROM bouqalla $wc ORDER BY num ASC LIMIT $limit OFFSET $offset"
    );
    $stmt->execute($p);
    $items = $stmt->fetchAll();

    $ct = getPdo()->prepare("SELECT COUNT(*) FROM bouqalla $wc");
    $ct->execute($p);
    apiOk(array('items'=>$items,'total'=>(int)$ct->fetchColumn(),'limit'=>$limit,'offset'=>$offset));
}

// ═════════════════════════════════════════════════════════════
//  INVITÉS D'UNE ÉMISSION
//  Pour les invités EXTERNES : cherche leurs interviews
//  par artiste_nom (pas par artiste_id qu'ils n'ont pas)
// ═════════════════════════════════════════════════════════════
function listEmissionInvites() {
    $emId = gInt('emission_id', 0, 1);
    if ($emId <= 0) { apiError('emission_id requis'); }

    $stmt = getPdo()->prepare(
        "SELECT ei.id, ei.ordre, ei.artiste_id,
                a.nom   AS artiste_nom,    a.image AS artiste_image,
                a.bio   AS artiste_bio,    a.views AS artiste_views,
                a.likes AS artiste_likes,
                cat.nom AS categorie_nom,
                (SELECT COUNT(*) FROM chansons   WHERE artiste_id = a.id) AS nb_chansons,
                (SELECT COUNT(*) FROM interviews WHERE artiste_id = a.id) AS nb_interviews,
                ei.invite_externe_nom,    ei.invite_externe_type,
                ei.invite_externe_image,  ei.invite_externe_bio
         FROM emission_invites ei
         LEFT JOIN artistes   a   ON ei.artiste_id  = a.id
         LEFT JOIN categories cat ON a.categorie_id = cat.id
         WHERE ei.emission_id = :id
         ORDER BY ei.ordre ASC"
    );
    $stmt->execute(array(':id' => $emId));
    $items = $stmt->fetchAll();

    foreach ($items as &$r) {
        if (!empty($r['artiste_id'])) {
            // ── Invité interne : artiste de la BDD ──
            $r['type']      = 'artiste';
            $r['nom']       = $r['artiste_nom'];
            $r['image_url'] = mediaUrl(isset($r['artiste_image']) ? $r['artiste_image'] : '');
            $r['bio']       = isset($r['artiste_bio']) ? $r['artiste_bio'] : '';
            // nb_chansons et nb_interviews déjà dans la requête
        } else {
            // ── Invité externe : pas dans la table artistes ──
            $r['type']       = 'externe';
            $r['nom']        = isset($r['invite_externe_nom']) ? $r['invite_externe_nom'] : 'Invité';
            $r['image_url']  = mediaUrl(isset($r['invite_externe_image']) ? $r['invite_externe_image'] : '');
            $r['bio']        = isset($r['invite_externe_bio']) ? $r['invite_externe_bio'] : '';
            $r['nb_chansons']    = 0;   // pas de chansons référencées

            // Cherche ses interviews par artiste_nom (colonne texte)
            $nom = $r['nom'];
            if ($nom !== '' && $nom !== 'Invité') {
                $ivStmt = getPdo()->prepare(
                    "SELECT i.id, i.artiste_nom, i.audio, i.image,
                            i.views, i.likes, i.date_interview,
                            cat.nom AS categorie_nom
                     FROM interviews i
                     LEFT JOIN categories cat ON i.categorie_id = cat.id
                     WHERE i.artiste_nom LIKE :nom
                     ORDER BY i.date_interview DESC"
                );
                $ivStmt->execute(array(':nom' => '%' . $nom . '%'));
                $ivs = $ivStmt->fetchAll();
                foreach ($ivs as &$iv) {
                    $iv['audio_url']  = mediaUrl($iv['audio']);
                    $iv['image_url']  = mediaUrl($iv['image']);
                    $iv['titre']      = $iv['artiste_nom'];
                    $iv['date_fmt']   = fmtDate($iv['date_interview']);
                    $iv['media_type'] = 'interview';
                }
                unset($iv);
                $r['interviews']     = $ivs;
                $r['nb_interviews']  = count($ivs);
            } else {
                $r['interviews']    = array();
                $r['nb_interviews'] = 0;
            }
        }
    }
    unset($r);
    apiOk($items);
}

// ═════════════════════════════════════════════════════════════
//  INCREMENT VUES / LIKES
// ═════════════════════════════════════════════════════════════
function doIncrement($type, $action) {
    $id  = gInt('id', 0, 1);
    if ($id <= 0) { apiError('ID invalide'); }

    $col = ($action === 'like') ? 'likes' : 'views';

    if      ($type === 'songs')      { $table = 'chansons'; }
    elseif  ($type === 'emissions')  { $table = 'emissions'; }
    elseif  ($type === 'interviews') { $table = 'interviews'; }
    elseif  ($type === 'artistes')   { $table = 'artistes'; }
    else    { apiError('Type invalide pour increment'); }

    if (session_status() === PHP_SESSION_NONE) { session_start(); }
    $key = $table . '_' . $col . '_' . $id;
    if (isset($_SESSION[$key])) { apiOk(array('message' => 'Déjà comptabilisé')); }

    getPdo()->prepare("UPDATE $table SET $col = $col + 1 WHERE id = ?")->execute(array($id));
    $_SESSION[$key] = true;

    $stmt = getPdo()->prepare("SELECT $col FROM $table WHERE id = ?");
    $stmt->execute(array($id));
    apiOk(array($col => (int)$stmt->fetchColumn()));
}
