-- SQL core schema: boards, threads, posts

-- boards

CREATE TABLE boards (
    id SERIAL PRIMARY KEY,
    slug TEXT NOT NULL UNIQUE,         -- /b/, /tech/, etc
    name TEXT NOT NULL,
    description TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- threads

CREATE TABLE threads (
    id SERIAL PRIMARY KEY,

    board_id INT NOT NULL REFERENCES boards(id) ON DELETE CASCADE,

    title TEXT,

    is_locked BOOLEAN NOT NULL DEFAULT FALSE,
    is_sticky BOOLEAN NOT NULL DEFAULT FALSE,

    reply_count INT NOT NULL DEFAULT 0,
    image_count INT NOT NULL DEFAULT 0,

    last_bump_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- index for catalog sorting (VERY IMPORTANT for imageboards)

CREATE INDEX idx_threads_board_bump
ON threads(board_id, last_bump_at DESC);

-- posts

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,

    thread_id INT NOT NULL REFERENCES threads(id) ON DELETE CASCADE,
    board_id INT NOT NULL REFERENCES boards(id) ON DELETE CASCADE,

    post_number INT NOT NULL,  -- per-thread visible number

    content TEXT NOT NULL,     -- raw text (no HTML stored here)

    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- each post number must be unique inside a thread

CREATE UNIQUE INDEX idx_posts_thread_post_number
ON posts(thread_id, post_number);

-- fast thread loading

CREATE INDEX idx_posts_thread_id
ON posts(thread_id);

-- optional safety base (minimal moderation hook)

CREATE TABLE bans (
    id SERIAL PRIMARY KEY,

    ip_hash TEXT NOT NULL,
    reason TEXT,

    expires_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_bans_ip_hash
ON bans(ip_hash);
