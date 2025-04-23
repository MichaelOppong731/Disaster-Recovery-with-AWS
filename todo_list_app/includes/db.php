<?php 

// Now you can use getenv() or $_ENV to access the variables
$servername = getenv('DB_HOST');
$username   = getenv('DB_USER');
$password   = getenv('DB_PASS');
$dbname     = getenv('DB_NAME');
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
    echo ".";
}


?>

