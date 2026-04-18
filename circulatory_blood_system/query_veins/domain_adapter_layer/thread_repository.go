package domain_adapter_layer

import (
	"context"

	db "imageboard/circulatory_blood_system/query_veins/generated"
)

type ThreadRepository struct {
	q *db.Queries
}

func NewThreadRepository(q *db.Queries) *ThreadRepository {
	return &ThreadRepository{q: q}
}

func (r *ThreadRepository) CreateThread(
	ctx context.Context,
	boardID int32,
	title string,
) (db.Thread, error) {

	return r.q.CreateThread(ctx, db.CreateThreadParams{
		BoardID: boardID,
		Title:   title,
	})
}

func (r *ThreadRepository) GetThread(
	ctx context.Context,
	id int32,
) (db.Thread, error) {

	return r.q.GetThread(ctx, id)
}

func (r *ThreadRepository) ListThreads(
	ctx context.Context,
	boardID int32,
	limit int32,
) ([]db.Thread, error) {

	return r.q.ListThreadsByBoard(ctx, db.ListThreadsByBoardParams{
		BoardID: boardID,
		Limit:   limit,
	})
}

package domain_adapter_layer

import (
	"context"

	db "imageboard/circulatory_blood_system/query_veins/generated"
)

type PostRepository struct {
	q *db.Queries
}

func NewPostRepository(q *db.Queries) *PostRepository {
	return &PostRepository{q: q}
}

func (r *PostRepository) CreatePost(
	ctx context.Context,
	threadID int32,
	boardID int32,
	postNumber int32,
	content string,
) (db.Post, error) {

	return r.q.CreatePost(ctx, db.CreatePostParams{
		ThreadID:   threadID,
		BoardID:    boardID,
		PostNumber: postNumber,
		Content:    content,
	})
}

func (r *PostRepository) ListByThread(
	ctx context.Context,
	threadID int32,
) ([]db.Post, error) {

	return r.q.ListPostsByThread(ctx, threadID)
}


