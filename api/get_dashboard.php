<?php
require_once 'config.php';

$user_id = $_GET['user_id'] ?? null;
$role = $_GET['role'] ?? null;

if ($user_id && $role) {
    if ($role === 'student') {
        $query = "SELECT a.*, o.title, o.type, o.deadline, u.name as provider_name 
                  FROM applications a 
                  JOIN opportunities o ON a.opportunity_id = o.id 
                  JOIN users u ON o.provider_id = u.id 
                  WHERE a.student_id = ? 
                  ORDER BY a.applied_at DESC";
        $stmt = $pdo->prepare($query);
        $stmt->execute([$user_id]);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        sendResponse(["applications" => $data]);
    } else if ($role === 'employer' || $role === 'scholarship_provider' || $role === 'school') {
        $query = "SELECT o.*, (SELECT COUNT(*) FROM applications WHERE opportunity_id = o.id) as app_count 
                  FROM opportunities o 
                  WHERE o.provider_id = ? 
                  ORDER BY o.created_at DESC";
        $stmt = $pdo->prepare($query);
        $stmt->execute([$user_id]);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Also get institution info for school role
        $inst = null;
        if ($role === 'school') {
            $inst_query = "SELECT * FROM institutions WHERE user_id = ?";
            $inst_stmt = $pdo->prepare($inst_query);
            $inst_stmt->execute([$user_id]);
            $inst = $inst_stmt->fetch(PDO::FETCH_ASSOC);
        }
        
        sendResponse(["opportunities" => $data, "institution" => $inst]);
    } else if ($role === 'admin') {
        // Admin gets stats
        $user_count = $pdo->query("SELECT COUNT(*) FROM users")->fetchColumn();
        $opp_count = $pdo->query("SELECT COUNT(*) FROM opportunities")->fetchColumn();
        $app_count = $pdo->query("SELECT COUNT(*) FROM applications")->fetchColumn();
        
        $recent_users = $pdo->query("SELECT name, email, role, created_at FROM users ORDER BY created_at DESC LIMIT 5")->fetchAll(PDO::FETCH_ASSOC);
        
        sendResponse([
            "stats" => [
                "users" => $user_count,
                "opportunities" => $opp_count,
                "applications" => $app_count
            ],
            "recent_users" => $recent_users
        ]);
    } else {
        sendResponse(["error" => "Invalid role"], 400);
    }
} else {
    sendResponse(["error" => "User ID and Role required"], 400);
}
?>
