-- Create the database only if it doesn't already exist
CREATE DATABASE IF NOT EXISTS todo_list;

-- Select the database to use
USE todo_list;

-- Create the table only if it doesn't already exist
CREATE TABLE IF NOT EXISTS tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    status ENUM('pending', 'completed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
