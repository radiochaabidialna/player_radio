<?php
/* ═══════════════════════════════════════════════════════
   RADIO CHAÂBI — api/live.php
   Gestion du "En Direct" via table activites_live

   GET  ?action=feed   → écoutes actives (< expire_at)
   POST ?action=play   → déclare une écoute
   POST ?action=stop   → arrête l'écoute du visiteur
   POST ?action=ping   → renouvelle l'écoute (heartbeat)
═══════════════════════════════════════════════════════ */

error_reporting(0);
ini_set('display_errors', '0');

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }

// ── Config ──────────────────────────────────────────────
define('DB_HOST',  'localhost');
define('DB_NAME',  'chaabi_music_v4');
define('DB_USER',  'root');
define('DB_PASS',  'root');
define('TTL_SEC',  30);   // une écoute expire après 30s sans ping

function getPdo() {
    static $pdo = null;
    if ($pdo) return $pdo;
    try {
        $pdo = new PDO(
            'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4',
            DB_USER, DB_PASS,
            array(
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => true,
            )
        );
    } catch (PDOException $e) {
        ok(array('count' => 0, 'entries' => array()));  // fail silently
    }
    return $pdo;
}

function ok($data) {
    echo json_encode(array('success' => true, 'data' => $data), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

// Identifiant visiteur stable (IP + UA hashé, anonyme)
function getVid() {
    $raw = ($_SERVER['REMOTE_ADDR'] ?? '') . '|' . ($_SERVER['HTTP_USER_AGENT'] ?? '');
    return substr(md5($raw), 0, 20);
}

// ── Router ──────────────────────────────────────────────
$action = isset($_GET['action']) ? trim($_GET['action']) : 'feed';

// ── FEED : lire les écoutes actives ─────────────────────
if ($action === 'feed') {
    try {
        $pdo = getPdo();

        // Supprimer les expirées
        $pdo->exec("DELETE FROM activites_live WHERE expire_at < NOW()");

        // Lire les actives (1 par visiteur : la plus récente)
        $stmt = $pdo->query("
            SELECT type, titre, artiste, utilisateur, item_id,
                   created_at, expire_at
            FROM activites_live
            WHERE expire_at >= NOW()
            ORDER BY created_at DESC
        ");
        $rows = $stmt->fetchAll();

        // Dédupliquer par titre+type (un titre peut avoir plusieurs listeners)
        $seen    = array();
        $entries = array();
        foreach ($rows as $r) {
            $key = $r['type'] . '|' . $r['titre'];
            if (!isset($seen[$key])) {
                $seen[$key] = true;
                $r['icon']  = typeIcon($r['type']);
                $r['label'] = typeLabel($r['type']);
                $entries[]  = $r;
            }
        }

        ok(array(
            'count'   => count($rows),        // nb total auditeurs
            'unique'  => count($entries),     // nb titres uniques
            'entries' => $entries,
        ));

    } catch (Exception $e) {
        ok(array('count' => 0, 'unique' => 0, 'entries' => array()));
    }
}

// ── PLAY : déclarer une écoute ───────────────────────────
if ($action === 'play') {
    $body   = json_decode(file_get_contents('php://input'), true) ?: array();
    $vid    = getVid();
    $type   = isset($body['type'])   ? trim($body['type'])   : '';
    $titre  = isset($body['title'])  ? trim($body['title'])  : '';
    $artist = isset($body['artist']) ? trim($body['artist']) : '';
    $itemId = isset($body['item_id']) ? (int)$body['item_id'] : null;

    if ($titre === '') { ok(array('message' => 'title requis')); }

    // Normaliser le type
    $typeMap = array('songs'=>'chanson','song'=>'chanson','emissions'=>'emission','emission'=>'emission','interviews'=>'interview','interview'=>'interview');
    $dbType  = isset($typeMap[$type]) ? $typeMap[$type] : 'chanson';

    try {
        $pdo     = getPdo();
        $expire  = date('Y-m-d H:i:s', time() + TTL_SEC);

        // Upsert : si ce visiteur a déjà une entrée, on la met à jour
        $stmt = $pdo->prepare("
            INSERT INTO activites_live (type, titre, artiste, utilisateur, item_id, created_at, expire_at)
            VALUES (:type, :titre, :artiste, :vid, :item_id, NOW(), :expire)
            ON DUPLICATE KEY UPDATE
                type       = VALUES(type),
                titre      = VALUES(titre),
                artiste    = VALUES(artiste),
                item_id    = VALUES(item_id),
                created_at = NOW(),
                expire_at  = VALUES(expire_at)
        ");
        // Note : ON DUPLICATE KEY nécessite une UNIQUE KEY sur utilisateur
        // Si pas dispo, on fait DELETE + INSERT
        $stmt->execute(array(
            ':type'    => $dbType,
            ':titre'   => mb_substr($titre, 0, 200),
            ':artiste' => mb_substr($artist, 0, 150),
            ':vid'     => $vid,
            ':item_id' => $itemId,
            ':expire'  => $expire,
        ));

        ok(array('message' => 'ok'));

    } catch (Exception $e) {
        // Si ON DUPLICATE KEY échoue (pas de UNIQUE sur utilisateur), on fait DELETE + INSERT
        try {
            $pdo->prepare("DELETE FROM activites_live WHERE utilisateur = ?")->execute(array($vid));
            $pdo->prepare("
                INSERT INTO activites_live (type, titre, artiste, utilisateur, item_id, expire_at)
                VALUES (?, ?, ?, ?, ?, ?)
            ")->execute(array($dbType, mb_substr($titre,0,200), mb_substr($artist,0,150), $vid, $itemId, $expire));
            ok(array('message' => 'ok'));
        } catch (Exception $e2) {
            ok(array('message' => 'error', 'detail' => $e2->getMessage()));
        }
    }
}

// ── PING : renouveler l'expiration ───────────────────────
if ($action === 'ping') {
    $vid    = getVid();
    $expire = date('Y-m-d H:i:s', time() + TTL_SEC);
    try {
        getPdo()->prepare("UPDATE activites_live SET expire_at = ? WHERE utilisateur = ?")->execute(array($expire, $vid));
    } catch (Exception $e) {}
    ok(array('message' => 'pong'));
}

// ── STOP : arrêter l'écoute ──────────────────────────────
if ($action === 'stop') {
    $vid = getVid();
    try {
        getPdo()->prepare("DELETE FROM activites_live WHERE utilisateur = ?")->execute(array($vid));
    } catch (Exception $e) {}
    ok(array('message' => 'stopped'));
}

ok(array('message' => 'action inconnue'));

// ── Helpers ─────────────────────────────────────────────
function typeIcon($type) {
    $map = array('chanson'=>'🎵','emission'=>'📻','interview'=>'🎤');
    return isset($map[$type]) ? $map[$type] : '🎶';
}
function typeLabel($type) {
    $map = array('chanson'=>'Chanson','emission'=>'Émission','interview'=>'Interview');
    return isset($map[$type]) ? $map[$type] : 'Audio';
}
