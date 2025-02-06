CREATE TABLE IF NOT EXISTS messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code INTEGER NOT NULL,
    language TEXT NOT NULL,
    message TEXT NOT NULL,
    UNIQUE(code, language)
);
