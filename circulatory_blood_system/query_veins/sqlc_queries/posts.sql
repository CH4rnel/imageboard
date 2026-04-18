-- name: CreatePost :one
INSERT INTO posts (thread_id, board_id, post_number, content)
VALUES ($1, $2, $3, $4)
RETURNING id, thread_id, board_id, post_number, content, created_at;

-- name: ListPostsByThread :many
SELECT * FROM posts
WHERE thread_id = $1
ORDER BY post_number ASC;
