<?php
require_once 'config.php';

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->email) && !empty($data->password)) {
    $query = "SELECT * FROM users WHERE email = ?";
    $stmt = $pdo->prepare($query);
    $stmt->execute([$data->email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($data->password, $user['password'])) {
        // Remove password from response
        unset($user['password']);
        sendResponse([
            "message" => "Login successful",
            "user" => $user
        ]);
    } else {
        sendResponse(["error" => "Invalid email or password"], 401);
    }
} else {
    sendResponse(["error" => "Incomplete data"], 400);
}
?>
