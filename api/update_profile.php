<?php
require_once 'config.php';

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->user_id) && !empty($data->role)) {
    if ($data->role === 'student') {
        $query = "UPDATE student_profiles SET education = ?, skills = ?, projects = ?, bio = ? WHERE user_id = ?";
        $stmt = $pdo->prepare($query);
        $success = $stmt->execute([
            $data->education ?? null,
            $data->skills ?? null,
            $data->projects ?? null,
            $data->bio ?? null,
            $data->user_id
        ]);
    } else if ($data->role === 'school') {
        $query = "UPDATE institutions SET location = ?, description = ?, website = ? WHERE user_id = ?";
        $stmt = $pdo->prepare($query);
        $success = $stmt->execute([
            $data->location ?? null,
            $data->description ?? null,
            $data->website ?? null,
            $data->user_id
        ]);
    } else {
        // For employers/providers, maybe update something else later
        $success = true;
    }

    if ($success) {
        sendResponse(["message" => "Profile updated successfully"]);
    } else {
        sendResponse(["error" => "Unable to update profile"], 500);
    }
} else {
    sendResponse(["error" => "User ID and Role required"], 400);
}
?>
