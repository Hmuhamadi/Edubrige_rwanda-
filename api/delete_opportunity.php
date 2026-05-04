<?php
require_once 'config.php';

$data = json_decode(file_get_contents("php://input"));
$opp_id  = $data->opportunity_id ?? null;
$user_id = $data->user_id ?? null;

if (!$opp_id || !$user_id) {
    sendResponse(["error" => "Opportunity ID and User ID required"], 400);
}

// Verify ownership (or admin)
$check = $pdo->prepare("SELECT id FROM opportunities WHERE id = ? AND provider_id = ?");
$check->execute([$opp_id, $user_id]);

// Also allow admin
$admin_check = $pdo->prepare("SELECT role FROM users WHERE id = ?");
$admin_check->execute([$user_id]);
$admin_user = $admin_check->fetch(PDO::FETCH_ASSOC);

if ($check->rowCount() === 0 && (!$admin_user || $admin_user['role'] !== 'admin')) {
    sendResponse(["error" => "Not authorized to delete this opportunity"], 403);
}

$stmt = $pdo->prepare("DELETE FROM opportunities WHERE id = ?");
if ($stmt->execute([$opp_id])) {
    sendResponse(["message" => "Opportunity deleted successfully"]);
} else {
    sendResponse(["error" => "Unable to delete opportunity"], 500);
}
?>
