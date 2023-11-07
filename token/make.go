package token

import "time"

// Maker
type Maker interface {
	CreateToken(username string, duration time.Duration) (string, error)

	//Check if token is valid
	VerifyToken(token string) (*Payload, error)
}
