package token

import (
	"time"

	"github.com/google/uuid"
)

type Payload struct {
	ID       uuid.UUID `json:"id"`
	Username string    `json:"username"`
	// IssuedAt is a standard JWT claim
	IssuedAt time.Time `json:"issued_at"`
	// Expiry is a standard JWT claim
	ExpiredAt time.Time `json:"expired_at"`
}

func NewPayload(username string, duration time.Duration) (*Payload, error) {
	tokenID, err := uuid.NewRandom()
	if err != nil {
		return nil, err
	}
	return &Payload{
		ID:        tokenID,
		Username:  username,
		IssuedAt:  time.Now(),
		ExpiredAt: time.Now().Add(duration),
	}, nil
}
