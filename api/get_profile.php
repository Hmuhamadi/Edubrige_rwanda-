<?php
require_once 'config.php';

$user_id = $_GET['user_id'] ?? null;

if ($user_id) {
    // First get the user role
    $stmt = $pdo->prepare("SELECT role FROM users WHERE id = ?");
    $stmt->execute([$user_id]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$user) {
        sendResponse(["error" => "User not found"], 404);
    }
    
    $role = $user['role'];
    
    if ($role === 'student') {
        $query = "SELECT u.name, u.email, u.role, p.* FROM users u LEFT JOIN student_profiles p ON u.id = p.user_id WHERE u.id = ?";
    } else if ($role === 'school') {
        $query = "SELECT u.name, u.email, u.role, i.* FROM users u LEFT JOIN institutions i ON u.id = i.user_id WHERE u.id = ?";
    } else {
        $query = "SELECT name, email, role FROM users WHERE id = ?";
    }
    
    $stmt = $pdo->prepare($query);
    $stmt->execute([$user_id]);
    $profile = $stmt->fetch(PDO::FETCH_ASSOC);
    
    sendResponse($profile);
} else {
    sendResponse(["error" => "User ID required"], 400);
}
?>
