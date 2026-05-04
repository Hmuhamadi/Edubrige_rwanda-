<?php
require_once 'config.php';

$data = json_decode(file_get_contents("php://input"));

$app_id  = $data->application_id ?? null;
$status  = $data->status ?? null;
$user_id = $data->user_id ?? null;

$allowed_statuses = ['pending', 'reviewed', 'accepted', 'rejected'];

if (!$app_id || !$status || !$user_id) {
    sendResponse(["error" => "Application ID, Status, and User ID required"], 400);
}

if (!in_array($status, $allowed_statuses)) {
    sendResponse(["error" => "Invalid status value"], 400);
}

// Verify the opportunity for this application belongs to the requesting user
$check = $pdo->prepare(
    "SELECT a.id FROM applications a 
     JOIN opportunities o ON a.opportunity_id = o.id 
     WHERE a.id = ? AND o.provider_id = ?"
);
$check->execute([$app_id, $user_id]);

// Allow admin override
$admin_check = $pdo->prepare("SELECT role FROM users WHERE id = ?");
$admin_check->execute([$user_id]);
$req_user = $admin_check->fetch(PDO::FETCH_ASSOC);

if ($check->rowCount() === 0 && (!$req_user || $req_user['role'] !== 'admin')) {
    sendResponse(["error" => "Not authorized to update this application"], 403);
}

$stmt = $pdo->prepare("UPDATE applications SET status = ? WHERE id = ?");
if ($stmt->execute([$status, $app_id])) {
    sendResponse(["message" => "Application status updated to '$status'"]);
} else {
    sendResponse(["error" => "Unable to update application status"], 500);
}
?>
