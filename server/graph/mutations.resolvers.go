package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"
	"fmt"
	"time"

	"github.com/christian-heusel/explorer-app/server/graph/generated"
	"github.com/christian-heusel/explorer-app/server/graph/model"
)

func (r *mutationResolver) CreateTeam(ctx context.Context, name *string, members *int) (*model.Team, error) {
	team := model.Team{Name: name, Members: members, Authcode: "Test"}
	result := r.DB.Create(&team)

	if result.Error != nil {
		return nil, result.Error
	}

	return &team, nil
}

func (r *mutationResolver) CreateAnswer(ctx context.Context, stationNumber int, answerTime *time.Time, resultOption *int, resultText *string, resultNumber *float64) (*model.Answer, error) {
	panic(fmt.Errorf("not implemented"))
}

// Mutation returns generated.MutationResolver implementation.
func (r *Resolver) Mutation() generated.MutationResolver { return &mutationResolver{r} }

type mutationResolver struct{ *Resolver }
