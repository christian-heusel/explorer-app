package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"

	"github.com/christian-heusel/explorer-app/server/graph/generated"
	"github.com/christian-heusel/explorer-app/server/graph/model"
)

func (r *answerResolver) UUID(ctx context.Context, obj *model.Answer) (string, error) {
	return obj.UUID.String(), nil
}

func (r *queryResolver) GetStations(ctx context.Context) ([]*model.Station, error) {
	var stations []*model.Station
	r.DB.Find(&stations)
	if r.DB.Error != nil {
		return nil, r.DB.Error
	}
	return stations, nil
}

// Answer returns generated.AnswerResolver implementation.
func (r *Resolver) Answer() generated.AnswerResolver { return &answerResolver{r} }

// Query returns generated.QueryResolver implementation.
func (r *Resolver) Query() generated.QueryResolver { return &queryResolver{r} }

type answerResolver struct{ *Resolver }
type queryResolver struct{ *Resolver }
