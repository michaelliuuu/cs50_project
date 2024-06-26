-- Drop tables if they exist
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS group_members;
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS transactions;

-- Users table
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL, 
    hash TEXT NOT NULL
);

-- Groups table
CREATE TABLE groups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_name TEXT NOT NULL,
    creator_id INTEGER NOT NULL,
    FOREIGN KEY (creator_id) REFERENCES users(id)
);

-- Group Members table
CREATE TABLE group_members (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    member_name TEXT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES groups(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Expenses table
CREATE TABLE expenses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id INTEGER NOT NULL,
    group_member_id INTEGER NOT NULL,
    description TEXT NOT NULL,
    amount NUMERIC NOT NULL DEFAULT 0.00,
    FOREIGN KEY (group_id) REFERENCES groups(id),
    FOREIGN KEY (group_member_id) REFERENCES group_members(id)
);

-- Transactions table
CREATE TABLE transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    transaction_id INTEGER NOT NULL,
    action TEXT NOT NULL, 
    group_name TEXT NOT NULL,
    group_member TEXT NOT NULL,
    description TEXT NOT NULL,
    amount NUMERIC NOT NULL,
    timestamp DATE DEFAULT (datetime('now','localtime')),
    FOREIGN KEY (transaction_id) REFERENCES users(id)
);