<?php
/**
 * API Unifiée – Chaabi Music
 * ─────────────────────────────────────────────
 * Paramètre  ?type=songs|emissions|interviews
 * Actions    ?action=list | view | like
 *
 * Exemples :
 *   ?type=songs&action=list
 *   ?type=songs&action=list&categorie_id=1&limit=50
 *   ?type=emissions&action=list
 *   ?type=interviews&action=list&artiste_id=5
 *   ?type=songs&action=view&id=42
 *   ?type=emissions&action=like&id=7
 */

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

// ── CONFIG ────────────────────────────────────
define('DB_HOST', 'localhost');
define('DB_NAME', 'chaabi_music_v4');
define('DB_USER', 'root');
define('DB_PASS', 'root');

// Chemin de base vers tes fichiers médias
// Ex : audio stocké en BDD = "audio/chanson.mp3"  → URL = BASE_URL . "audio/chanson.mp3"
define('BASE_URL', '/music/');

// ── PDO ───────────────────────────────────────
function pdo(): PDO {
    static $pdo = null;
    if ($pdo) return $pdo;
    try {
        $pdo = new PDO(
            'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4',
            DB_USER, DB_PASS,
            [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ]
        );
    } catch (PDOException $e) {
        fail('Connexion BDD impossible', 500);
    }
    return $pdo;
}

// ── HELPERS ───────────────────────────────────
function ok(mixed $data): void {
    echo json_encode(['success' => true, 'data' => $data], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function fail(string $msg, int $code = 400): never {
    http_response_code($code);
    echo json_encode(['success' => false, 'error' => $msg], JSON_UNESCAPED_UNICODE);
    exit;
}

function mediaUrl(string $path): string {
    if (empty($path)) return '';
    if (str_starts_with($path, 'http')) return $path;
    return BASE_URL . ltrim($path, '/');
}

function paginationParams(): array {
    return [
        'limit'  => max(1, min(200, (int)($_GET['limit']  ?? 60))),
        'offset' => max(0, (int)($_GET['offset'] ?? 0)),
    ];
}

// ── ROUTER ────────────────────────────────────
$type   = $_GET['type']   ?? 'songs';
$action = $_GET['action'] ?? 'list';

if (!in_array($type, ['songs', 'emissions', 'interviews'])) fail('Type invalide');

match ($action) {
    'list' => match ($type) {
        'songs'      => listSongs(),
        'emissions'  => listEmissions(),
        'interviews' => listInterviews(),
    },
    'view', 'like' => increment($type, $action),
    default => fail('Action inconnue'),
};

// ════════════════════════════════════════════════
//  LIST – CHANSONS
// ════════════════════════════════════════════════
function listSongs(): void {
    ['limit' => $limit, 'offset' => $offset] = paginationParams();
    $params = [];
    $where  = [];

    if (!empty($_GET['categorie_id'])) {
        $where[] = 'c.categorie_id = :cat';
        $params[':cat'] = (int)$_GET['categorie_id'];
    }
    if (!empty($_GET['artiste_id'])) {
        $where[] = 'c.artiste_id = :art';
        $params[':art'] = (int)$_GET['artiste_id'];
    }
    if (!empty($_GET['q'])) {
        $where[] = '(c.titre LIKE :q OR a.nom LIKE :q)';
        $params[':q'] = '%' . $_GET['q'] . '%';
    }

    $allowedSorts = ['views'=>'c.views','likes'=>'c.likes','recent'=>'c.created_at','titre'=>'c.titre'];
    $order = $allowedSorts[$_GET['sort'] ?? 'views'] ?? 'c.views';
    $dir   = ($_GET['dir'] ?? 'DESC') === 'ASC' ? 'ASC' : 'DESC';
    $wClause = $where ? 'WHERE ' . implode(' AND ', $where) : '';

    $sql = "
        SELECT
            c.id, c.titre, c.audio, c.image,
            c.views, c.likes, c.categorie_id, c.created_at,
            a.id   AS artiste_id,
            a.nom  AS artiste_nom,
            a.image AS artiste_image,
            cat.nom AS categorie_nom
        FROM chansons c
        LEFT JOIN artistes   a   ON c.artiste_id   = a.id
        LEFT JOIN categories cat ON c.categorie_id = cat.id
        $wClause
        ORDER BY $order $dir
        LIMIT :limit OFFSET :offset
    ";

    $stmt = pdo()->prepare($sql);
    $stmt->execute(array_merge($params, [':limit' => $limit, ':offset' => $offset]));
    $rows = $stmt->fetchAll();

    $countStmt = pdo()->prepare("SELECT COUNT(*) FROM chansons c LEFT JOIN artistes a ON c.artiste_id=a.id $wClause");
    $countStmt->execute($params);
    $total = (int)$countStmt->fetchColumn();

    foreach ($rows as &$r) {
        $r['audio_url']         = mediaUrl($r['audio']);
        $r['image_url']         = mediaUrl($r['image']);
        $r['artiste_image_url'] = mediaUrl($r['artiste_image'] ?? '');
        $r['media_type']        = 'song';
    }
    ok(['items' => $rows, 'total' => $total, 'limit' => $limit, 'offset' => $offset]);
}

// ════════════════════════════════════════════════
//  LIST – ÉMISSIONS
// ════════════════════════════════════════════════
function listEmissions(): void {
    ['limit' => $limit, 'offset' => $offset] = paginationParams();
    $params = [];
    $where  = [];

    if (!empty($_GET['categorie_id'])) {
        $where[] = 'e.categorie_id = :cat';
        $params[':cat'] = (int)$_GET['categorie_id'];
    }
    if (!empty($_GET['q'])) {
        $where[] = '(e.titre LIKE :q OR e.description LIKE :q)';
        $params[':q'] = '%' . $_GET['q'] . '%';
    }

    $allowedSorts = ['views'=>'e.views','likes'=>'e.likes','recent'=>'e.date_emission','numero'=>'e.numero_emission'];
    $order = $allowedSorts[$_GET['sort'] ?? 'recent'] ?? 'e.date_emission';
    $dir   = ($_GET['dir'] ?? 'DESC') === 'ASC' ? 'ASC' : 'DESC';
    $wClause = $where ? 'WHERE ' . implode(' AND ', $where) : '';

    $sql = "
        SELECT
            e.id, e.numero_emission, e.titre, e.description,
            e.audio, e.image, e.views, e.likes,
            e.categorie_id, e.date_emission,
            u.nom AS animateur_nom,
            cat.nom AS categorie_nom
        FROM emissions e
        LEFT JOIN users      u   ON e.animateur_id  = u.id
        LEFT JOIN categories cat ON e.categorie_id  = cat.id
        $wClause
        ORDER BY $order $dir
        LIMIT :limit OFFSET :offset
    ";

    $stmt = pdo()->prepare($sql);
    $stmt->execute(array_merge($params, [':limit' => $limit, ':offset' => $offset]));
    $rows = $stmt->fetchAll();

    $countStmt = pdo()->prepare("SELECT COUNT(*) FROM emissions e $wClause");
    $countStmt->execute($params);
    $total = (int)$countStmt->fetchColumn();

    foreach ($rows as &$r) {
        $r['audio_url']    = mediaUrl($r['audio']);
        $r['image_url']    = mediaUrl($r['image']);
        $r['artiste_nom']  = $r['animateur_nom'] ?? 'Animateur inconnu';
        $r['media_type']   = 'emission';
        // Formater la date
        $r['date_fmt'] = $r['date_emission']
            ? (new DateTime($r['date_emission']))->format('d/m/Y')
            : '';
    }
    ok(['items' => $rows, 'total' => $total, 'limit' => $limit, 'offset' => $offset]);
}

// ════════════════════════════════════════════════
//  LIST – INTERVIEWS
// ════════════════════════════════════════════════
function listInterviews(): void {
    ['limit' => $limit, 'offset' => $offset] = paginationParams();
    $params = [];
    $where  = [];

    if (!empty($_GET['categorie_id'])) {
        $where[] = 'i.categorie_id = :cat';
        $params[':cat'] = (int)$_GET['categorie_id'];
    }
    if (!empty($_GET['artiste_id'])) {
        $where[] = 'i.artiste_id = :art';
        $params[':art'] = (int)$_GET['artiste_id'];
    }
    if (!empty($_GET['q'])) {
        $where[] = '(i.artiste_nom LIKE :q)';
        $params[':q'] = '%' . $_GET['q'] . '%';
    }

    $allowedSorts = ['views'=>'i.views','likes'=>'i.likes','recent'=>'i.date_interview'];
    $order = $allowedSorts[$_GET['sort'] ?? 'recent'] ?? 'i.date_interview';
    $dir   = ($_GET['dir'] ?? 'DESC') === 'ASC' ? 'ASC' : 'DESC';
    $wClause = $where ? 'WHERE ' . implode(' AND ', $where) : '';

    $sql = "
        SELECT
            i.id, i.artiste_nom, i.audio, i.image,
            i.views, i.likes, i.categorie_id, i.date_interview,
            a.nom  AS artiste_nom_bdd,
            a.image AS artiste_image,
            cat.nom AS categorie_nom
        FROM interviews i
        LEFT JOIN artistes   a   ON i.artiste_id   = a.id
        LEFT JOIN categories cat ON i.categorie_id = cat.id
        $wClause
        ORDER BY $order $dir
        LIMIT :limit OFFSET :offset
    ";

    $stmt = pdo()->prepare($sql);
    $stmt->execute(array_merge($params, [':limit' => $limit, ':offset' => $offset]));
    $rows = $stmt->fetchAll();

    $countStmt = pdo()->prepare("SELECT COUNT(*) FROM interviews i $wClause");
    $countStmt->execute($params);
    $total = (int)$countStmt->fetchColumn();

    foreach ($rows as &$r) {
        $r['audio_url']         = mediaUrl($r['audio']);
        $r['image_url']         = mediaUrl($r['image']);
        $r['artiste_image_url'] = mediaUrl($r['artiste_image'] ?? '');
        $r['titre']             = $r['artiste_nom_bdd'] ?? $r['artiste_nom'];
        $r['artiste_nom']       = $r['artiste_nom'];
        $r['media_type']        = 'interview';
        $r['date_fmt'] = $r['date_interview']
            ? (new DateTime($r['date_interview']))->format('d/m/Y')
            : '';
    }
    ok(['items' => $rows, 'total' => $total, 'limit' => $limit, 'offset' => $offset]);
}

// ════════════════════════════════════════════════
//  INCREMENT (views / likes)
// ════════════════════════════════════════════════
function increment(string $type, string $action): void {
    $id = (int)($_GET['id'] ?? 0);
    if ($id <= 0) fail('ID invalide');

    $col   = $action === 'like' ? 'likes' : 'views';
    $table = match ($type) {
        'songs'      => 'chansons',
        'emissions'  => 'emissions',
        'interviews' => 'interviews',
    };

    session_start();
    $sessionKey = "{$table}_{$col}_{$id}";
    if (isset($_SESSION[$sessionKey])) {
        ok(['message' => 'Déjà comptabilisé']);
    }

    pdo()->prepare("UPDATE $table SET $col = $col + 1 WHERE id = ?")->execute([$id]);
    $_SESSION[$sessionKey] = true;

    $val = (int)pdo()->prepare("SELECT $col FROM $table WHERE id = ?")->execute([$id]);
    $stmt = pdo()->prepare("SELECT $col FROM $table WHERE id = ?");
    $stmt->execute([$id]);
    ok([$col => (int)$stmt->fetchColumn()]);
}
