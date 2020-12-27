package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"

	"github.com/christian-heusel/explorer-app/server/graph/generated"
	"github.com/christian-heusel/explorer-app/server/graph/model"
)

func (r *queryResolver) GetStations(ctx context.Context) ([]*model.Station, error) {
	var stations []*model.Station
	r.DB.Find(&stations)
	if r.DB.Error != nil {
		return nil, r.DB.Error
	}
	return stations, nil
}

// Query returns generated.QueryResolver implementation.
func (r *Resolver) Query() generated.QueryResolver { return &queryResolver{r} }

type queryResolver struct{ *Resolver }
