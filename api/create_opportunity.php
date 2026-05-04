<?php
require_once 'config.php';

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->title) && !empty($data->type) && !empty($data->description) && !empty($data->deadline) && !empty($data->provider_id)) {
    $query = "INSERT INTO opportunities (title, type, description, deadline, provider_id, location, category) VALUES (?, ?, ?, ?, ?, ?, ?)";
    $stmt = $pdo->prepare($query);

    if ($stmt->execute([
        $data->title,
        $data->type,
        $data->description,
        $data->deadline,
        $data->provider_id,
        $data->location  ?? null,
        $data->category  ?? null
    ])) {
        sendResponse(["message" => "Opportunity created successfully"], 201);
    } else {
        sendResponse(["error" => "Unable to create opportunity"], 500);
    }
} else {
    sendResponse(["error" => "Incomplete data"], 400);
}
?>
