<?php
require_once 'config.php';

// Fetch only active (non-expired) opportunities, sorted newest first
// Optional filter: ?type=scholarship|internship|job
$type = $_GET['type'] ?? null;

$where = "o.is_active = 1";
$params = [];

if ($type && in_array($type, ['job', 'internship', 'scholarship'])) {
    $where .= " AND o.type = ?";
    $params[] = $type;
}

$query = "SELECT 
            o.id, o.title, o.type, o.description, o.deadline,
            o.location, o.category, o.is_active, o.created_at,
            u.name AS provider_name,
            (SELECT COUNT(*) FROM applications WHERE opportunity_id = o.id) AS app_count
          FROM opportunities o
          JOIN users u ON o.provider_id = u.id
          WHERE $where
          ORDER BY o.created_at DESC";

$stmt = $pdo->prepare($query);
$stmt->execute($params);
$opportunities = $stmt->fetchAll(PDO::FETCH_ASSOC);

sendResponse($opportunities);
?>
