<?php
require_once 'config.php';

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->name) && !empty($data->email) && !empty($data->password) && !empty($data->role)) {
    $hashed_password = password_hash($data->password, PASSWORD_DEFAULT);

    $query = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
    $stmt = $pdo->prepare($query);

    try {
        if ($stmt->execute([$data->name, $data->email, $hashed_password, $data->role])) {
            $user_id = $pdo->lastInsertId();
            
            // Handle profile creation based on role
            if ($data->role === 'student') {
                $profile_query = "INSERT INTO student_profiles (user_id) VALUES (?)";
                $profile_stmt = $pdo->prepare($profile_query);
                $profile_stmt->execute([$user_id]);
            } else if ($data->role === 'school') {
                $inst_query = "INSERT INTO institutions (user_id, name) VALUES (?, ?)";
                $inst_stmt = $pdo->prepare($inst_query);
                $inst_stmt->execute([$user_id, $data->name]);
            }

            sendResponse(["message" => "User registered successfully"], 201);
        } else {
            sendResponse(["error" => "Unable to register user"], 500);
        }
    } catch (PDOException $e) {
        if ($e->getCode() == 23000) {
            sendResponse(["error" => "Email already exists"], 400);
        } else {
            sendResponse(["error" => $e->getMessage()], 500);
        }
    }
} else {
    sendResponse(["error" => "Incomplete data"], 400);
}
?>
