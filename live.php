<?php
/* ═══════════════════════════════════════════════════════
   api/live.php  v2 — Radio Chaâbi
   GET  ?action=feed    → liste des écoutes actives
   POST ?action=play    → déclare une écoute
   POST ?action=ping    → heartbeat (renouvelle expire_at)
   GET  ?action=stop    → supprime l'écoute du visiteur
   GET  ?action=test    → diagnostic complet (debug)
═══════════════════════════════════════════════════════ */

// Affiche les erreurs PHP dans la réponse JSON (debug)
error_reporting(E_ALL);
ini_set('display_errors', '0');

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204); exit;
}

// ── Config ──────────────────────────────────────────────
define('DB_HOST',  'localhost');
define('DB_NAME',  'chaabi_music_v4');
define('DB_USER',  'root');
define('DB_PASS',  'root');
define('TTL_SEC',  245);   // expire après 45s sans ping

// ── PDO ─────────────────────────────────────────────────
function getPdo() {
    static $pdo = null;
    if ($pdo) return $pdo;
    $pdo = new PDO(
        'mysql:host='.DB_HOST.';dbname='.DB_NAME.';charset=utf8mb4',
        DB_USER, DB_PASS,
        [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => true,
        ]
    );
    return $pdo;
}

// ── Helpers ─────────────────────────────────────────────
function ok($data) {
    echo json_encode(['success' => true, 'data' => $data],
        JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function err($msg, $code = 400) {
    http_response_code($code);
    echo json_encode(['success' => false, 'error' => $msg],
        JSON_UNESCAPED_UNICODE);
    exit;
}

// Identifiant visiteur anonyme et stable (hash IP+UA)
function getVid() {
    $raw = ($_SERVER['HTTP_X_FORWARDED_FOR']
         ?? $_SERVER['REMOTE_ADDR']
         ?? 'unknown')
         . '|'
         . ($_SERVER['HTTP_USER_AGENT'] ?? '');
    return substr(md5($raw), 0, 20);
}

// ── Router ──────────────────────────────────────────────
$action = trim($_GET['action'] ?? 'feed');

// ════════════════════════════════════════════════════════
//  TEST — diagnostic complet, à retirer en production
// ════════════════════════════════════════════════════════
if ($action === 'test') {
    $result = ['db' => false, 'table' => false, 'rows' => [], 'vid' => getVid()];
    try {
        $pdo = getPdo();
        $result['db'] = true;
        $rows = $pdo->query("SELECT COUNT(*) as n FROM activites_live")->fetch();
        $result['table'] = true;
        $result['count_total'] = (int)$rows['n'];
        $result['rows'] = $pdo->query(
            "SELECT * FROM activites_live ORDER BY created_at DESC LIMIT 10"
        )->fetchAll();
        $result['now'] = date('Y-m-d H:i:s');
    } catch (Exception $e) {
        $result['error'] = $e->getMessage();
    }
    ok($result);
}

// ════════════════════════════════════════════════════════
//  FEED — lecture des écoutes actives
// ════════════════════════════════════════════════════════
if ($action === 'feed') {
    try {
        $pdo = getPdo();

        // Nettoyer les entrées expirées
        $pdo->exec("DELETE FROM activites_live WHERE expire_at < NOW()");

        // Lire toutes les écoutes actives
        $stmt = $pdo->query("
            SELECT type, titre, artiste, utilisateur, item_id,
                   created_at, expire_at
            FROM activites_live
            WHERE expire_at >= NOW()
            ORDER BY created_at DESC
        ");
        $rows = $stmt->fetchAll();

        // Dédupliquer par titre+type (un même titre peut avoir plusieurs auditeurs)
        $seen    = [];
        $entries = [];
        foreach ($rows as $r) {
            $key = $r['type'] . '|' . $r['titre'];
            if (!isset($seen[$key])) {
                $seen[$key] = true;
                $r['icon']  = typeIcon($r['type']);
                $r['label'] = typeLabel($r['type']);
                $entries[]  = $r;
            }
        }

        ok([
            'count'   => count($rows),
            'unique'  => count($entries),
            'entries' => $entries,
        ]);

    } catch (Exception $e) {
        // Retourner vide plutôt que planter
        ok(['count' => 0, 'unique' => 0, 'entries' => [], 'db_error' => $e->getMessage()]);
    }
}

// ════════════════════════════════════════════════════════
//  PLAY — déclarer une écoute en cours
// ════════════════════════════════════════════════════════
if ($action === 'play') {
    // Lire le corps JSON (POST)
    $raw  = file_get_contents('php://input');
    $body = json_decode($raw, true) ?: [];

    $vid    = getVid();
    $type   = trim($body['type']   ?? '');
    $titre  = trim($body['title']  ?? $body['titre'] ?? '');
    $artist = trim($body['artist'] ?? $body['artiste'] ?? '');
    $itemId = isset($body['item_id']) ? (int)$body['item_id'] : null;

    if ($titre === '') {
        err('Le champ "title" est requis');
    }

    // Normaliser le type vers la valeur BDD
    $typeMap = [
        'songs'      => 'chanson',
        'song'       => 'chanson',
        'chanson'    => 'chanson',
        'emissions'  => 'emission',
        'emission'   => 'emission',
        'interviews' => 'interview',
        'interview'  => 'interview',
    ];
    $dbType = $typeMap[$type] ?? 'chanson';
    $expire = date('Y-m-d H:i:s', time() + TTL_SEC);

    try {
        $pdo = getPdo();

        // Supprimer l'ancienne entrée du même visiteur (plus simple que ON DUPLICATE KEY)
        $pdo->prepare("DELETE FROM activites_live WHERE utilisateur = ?")
            ->execute([$vid]);

        // Insérer la nouvelle
        $pdo->prepare("
            INSERT INTO activites_live
                (type, titre, artiste, utilisateur, item_id, created_at, expire_at)
            VALUES
                (?, ?, ?, ?, ?, NOW(), ?)
        ")->execute([$dbType, mb_substr($titre, 0, 200), mb_substr($artist, 0, 150), $vid, $itemId, $expire]);

        ok(['status' => 'ok', 'vid' => $vid, 'dbType' => $dbType, 'expire' => $expire]);

    } catch (Exception $e) {
        err('DB error: ' . $e->getMessage(), 500);
    }
}

// ════════════════════════════════════════════════════════
//  PING — heartbeat, renouvelle expire_at
// ════════════════════════════════════════════════════════
if ($action === 'ping') {
    $vid    = getVid();
    $expire = date('Y-m-d H:i:s', time() + TTL_SEC);
    try {
        $pdo = getPdo();
        $stmt = $pdo->prepare("UPDATE activites_live SET expire_at = ? WHERE utilisateur = ?");
        $stmt->execute([$expire, $vid]);
        ok(['status' => 'pong', 'updated' => $stmt->rowCount()]);
    } catch (Exception $e) {
        err('DB error: ' . $e->getMessage(), 500);
    }
}

// ════════════════════════════════════════════════════════
//  STOP — supprimer l'écoute du visiteur
// ════════════════════════════════════════════════════════
if ($action === 'stop') {
    $vid = getVid();
    try {
        $pdo = getPdo();
        $pdo->prepare("DELETE FROM activites_live WHERE utilisateur = ?")
            ->execute([$vid]);
        ok(['status' => 'stopped']);
    } catch (Exception $e) {
        err('DB error: ' . $e->getMessage(), 500);
    }
}

err('Action inconnue : ' . htmlspecialchars($action));

// ── Icônes et labels par type ────────────────────────────
function typeIcon($type) {
    return ['chanson' => '🎵', 'emission' => '📻', 'interview' => '🎤'][$type] ?? '🎶';
}
function typeLabel($type) {
    return ['chanson' => 'Chanson', 'emission' => 'Émission', 'interview' => 'Interview'][$type] ?? 'Audio';
}