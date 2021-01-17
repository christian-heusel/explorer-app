package model

// Team is team
type Team struct {
	ID       int     `json:"ID"`
	Authcode string  `json:"-"`
	Name     *string `json:"name"`
	Hometown *string `json:"hometown"`
	Members  *int    `json:"members"`
}
