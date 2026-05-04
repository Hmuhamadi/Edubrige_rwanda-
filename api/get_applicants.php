<?php
require_once 'config.php';

$opp_id  = $_GET['opportunity_id'] ?? null;
$user_id = $_GET['user_id'] ?? null;

if (!$opp_id || !$user_id) {
    sendResponse(["error" => "Opportunity ID and User ID required"], 400);
}

// Verify this opportunity belongs to the requesting user (or admin)
$owner_check = $pdo->prepare("SELECT id FROM opportunities WHERE id = ? AND provider_id = ?");
$owner_check->execute([$opp_id, $user_id]);

$admin_check = $pdo->prepare("SELECT role FROM users WHERE id = ?");
$admin_check->execute([$user_id]);
$req_user = $admin_check->fetch(PDO::FETCH_ASSOC);

if ($owner_check->rowCount() === 0 && (!$req_user || $req_user['role'] !== 'admin')) {
    sendResponse(["error" => "Not authorized"], 403);
}

$query = "SELECT 
            a.id as application_id,
            a.status,
            a.applied_at,
            u.id as student_id,
            u.name as student_name,
            u.email as student_email,
            sp.education,
            sp.skills,
            sp.bio
          FROM applications a
          JOIN users u ON a.student_id = u.id
          LEFT JOIN student_profiles sp ON u.id = sp.user_id
          WHERE a.opportunity_id = ?
          ORDER BY a.applied_at DESC";

$stmt = $pdo->prepare($query);
$stmt->execute([$opp_id]);
$applicants = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Also get the opportunity info
$opp_stmt = $pdo->prepare("SELECT title, type FROM opportunities WHERE id = ?");
$opp_stmt->execute([$opp_id]);
$opportunity = $opp_stmt->fetch(PDO::FETCH_ASSOC);

sendResponse([
    "opportunity" => $opportunity,
    "applicants"  => $applicants
]);
?>
