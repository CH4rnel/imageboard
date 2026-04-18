-- name: CreateThread :one
INSERT INTO threads (board_id, title)
VALUES ($1, $2)
RETURNING id, board_id, title, created_at, last_bump_at;

-- name: GetThread :one
SELECT * FROM threads
WHERE id = $1;

-- name: ListThreadsByBoard :many
SELECT * FROM threads
WHERE board_id = $1
ORDER BY last_bump_at DESC
LIMIT $2;
