<?php
// Database Configuration
$host = "localhost";
$username = "root";
$password = ""; // Default XAMPP password is empty
$new_db = "edubridge_db";

try {
    // 1. Connect to MySQL (without selecting a DB yet)
    $pdo = new PDO("mysql:host=$host", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // 2. Create the new database if it doesn't exist
    echo "Creating database '$new_db' if not exists...<br>";
    $pdo->exec("CREATE DATABASE IF NOT EXISTS $new_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
    $pdo->exec("USE $new_db");

    // 3. Read the SQL file
    $sqlFile = 'database.sql';
    if (!file_exists($sqlFile)) {
        die("Error: $sqlFile not found!");
    }
    
    $sql = file_get_contents($sqlFile);
    
    // Remove comments and split by semicolon
    $queries = explode(';', $sql);
    
    echo "Importing schema...<br>";
    foreach ($queries as $query) {
        $query = trim($query);
        if (!empty($query)) {
            $pdo->exec($query);
        }
    }

    // 4. Import Seed Data
    $seedFile = 'seed_data.sql';
    if (file_exists($seedFile)) {
        echo "Importing seed data...<br>";
        $seedSql = file_get_contents($seedFile);
        $seedQueries = explode(';', $seedSql);
        foreach ($seedQueries as $query) {
            $query = trim($query);
            if (!empty($query)) {
                $pdo->exec($query);
            }
        }
    }

    echo "<h2 style='color: green;'>Success! Database '$new_db' is ready.</h2>";
    echo "<p>You can now delete this file (setup_db.php) for security.</p>";
    echo "<a href='index.html'>Go to App</a>";

} catch (PDOException $e) {
    echo "<h2 style='color: red;'>Error: " . $e->getMessage() . "</h2>";
    echo "<p>Make sure XAMPP MySQL is running.</p>";
}
?>
