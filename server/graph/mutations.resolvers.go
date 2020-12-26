package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"
	"log"
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

func (r *mutationResolver) CreateAnswer(ctx context.Context, stationNumber int, answerTime time.Time, resultOption *int, resultText *string, resultNumber *float64) (*model.Answer, error) {
	station := &model.Station{}
	createStation := r.DB.First(station, stationNumber)

	if createStation.Error != nil {
		log.Print("Error while creating a station: ", createStation.Error)
		return nil, createStation.Error
	}
	answer := model.Answer{
		Station:             station,
		AnswerTime:          answerTime,
		SynchronizationTime: time.Now(),
		ResultOption:        resultOption,
		ResultText:          resultText,
		ResultNumber:        resultNumber,
	}

	result := r.DB.Create(&answer)

	if result.Error != nil {
		return nil, result.Error
	}

	return &answer, nil
}

func (r *mutationResolver) CreateDevice(ctx context.Context, androidID string, teamID int, brand *string, phoneModel *string, androidCodename *string, androidRelease *string) (*model.Device, error) {
	team := &model.Team{}
	createTeam := r.DB.First(team, teamID)

	if createTeam.Error != nil {
		log.Print("Error while creating a team: ", createTeam.Error)
		return nil, createTeam.Error
	}

	device := model.Device{
		AndroidID:       androidID,
		Team:            team,
		Brand:           brand,
		PhoneModel:      phoneModel,
		AndroidCodename: androidCodename,
		AndroidRelease:  androidRelease,
	}

	result := r.DB.Create(&device)

	if result.Error != nil {
		return nil, result.Error
	}

	return &device, nil
}

// Mutation returns generated.MutationResolver implementation.
func (r *Resolver) Mutation() generated.MutationResolver { return &mutationResolver{r} }

type mutationResolver struct{ *Resolver }
