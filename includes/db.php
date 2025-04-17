<?php 
require __DIR__ . '/../vendor/autoload.php'; // Adjust the path if necessary

// Initialize dotenv
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Now you can use getenv() or $_ENV to access the variables
$servername = $_ENV['DB_HOST'];
$username   = $_ENV['DB_USER'];
$password   = $_ENV['DB_PASS'];
$dbname     = $_ENV['DB_NAME'];
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check if connection works
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
// Initialize DB only if empty
$result = $conn->query("SHOW TABLES");
if ($result && $result->num_rows === 0) {
    $sql = file_get_contents("init.sql");
    if ($conn->multi_query($sql)) {
        echo "";
    } else {
        echo "Error initializing database: " . $conn->error;
    }
} else {
    echo "Database already initialized.\n";
}



?>

