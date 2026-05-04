<?php
require_once 'config.php';

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->student_id) && !empty($data->opportunity_id)) {
    // Check if already applied
    $check_query = "SELECT id FROM applications WHERE student_id = ? AND opportunity_id = ?";
    $check_stmt = $pdo->prepare($check_query);
    $check_stmt->execute([$data->student_id, $data->opportunity_id]);
    
    if ($check_stmt->rowCount() > 0) {
        sendResponse(["error" => "You have already applied for this opportunity"], 400);
    }

    $query = "INSERT INTO applications (student_id, opportunity_id) VALUES (?, ?)";
    $stmt = $pdo->prepare($query);

    if ($stmt->execute([$data->student_id, $data->opportunity_id])) {
        sendResponse(["message" => "Application submitted successfully"], 201);
    } else {
        sendResponse(["error" => "Unable to submit application"], 500);
    }
} else {
    sendResponse(["error" => "Incomplete data"], 400);
}
?>
