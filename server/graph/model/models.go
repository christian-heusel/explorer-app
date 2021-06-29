// Code generated by github.com/99designs/gqlgen, DO NOT EDIT.

package model

import (
	"time"

	uuid "github.com/satori/go.uuid"
	"gorm.io/gorm"
)

type Answer struct {
	UUID                uuid.UUID `gorm:"type:uuid;primary_key;" json:"UUID"`
	StationID           int       `json:"station" gorm:"references:station.ID"`
	AnswerTime          time.Time `json:"answer_time"`
	SynchronizationTime time.Time `json:"synchronization_time"`
	ResultOption        *int      `json:"result_option"`
	ResultText          *string   `json:"result_text"`
	ResultNumber        *float64  `json:"result_number"`
}

// BeforeCreate will set a UUID rather than numeric ID.
// taken from
// https://github.com/FachschaftMathPhysInfo/ostseee/blob/master/server/go/model_base.go
func (answer *Answer) BeforeCreate(db *gorm.DB) error {
	uuid := uuid.NewV4()
	answer.UUID = uuid
	return nil
}

type Device struct {
	ID              string  `json:"ID"`
	TeamID          int     `json:"team" gorm:"references:team.ID"`
	Brand           *string `json:"brand"`
	PhoneModel      *string `json:"phone_model"`
	AndroidCodename *string `json:"android_codename"`
	AndroidRelease  *string `json:"android_release"`
}

type Station struct {
	ID          int     `json:"ID"`
	Points      int     `json:"points"`
	StationType int     `json:"station_type"`
	Coordinates *string `json:"coordinates"`
	GridSquare  *string `json:"grid_square"`
	Title       *string `json:"title"`
}

type Team struct {
	ID       int     `json:"ID"`
	Authcode string  `json:"authcode"`
	Name     *string `json:"name"`
	Hometown *string `json:"hometown"`
	Members  *int    `json:"members"`
}
