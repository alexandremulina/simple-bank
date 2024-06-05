package main

import (
	"context"
	"log"
	"os"
	"simplebank/api"
	db "simplebank/db/sqlc"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/joho/godotenv"
)

func main() {
	// Load environment variables from .env file
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	// Get database source and server address from environment variables
	dbSource := os.Getenv("DB_SOURCE")
	serverAddress := os.Getenv("SERVER_ADDRESS")

	// Connect to the database
	pool, err := pgxpool.New(context.Background(), dbSource)
	if err != nil {
		log.Fatal("cannot connect to db pool: ", err)
	}
	defer pool.Close()

	// Ping the database to verify connection
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	if err := pool.Ping(ctx); err != nil {
		log.Fatal("database ping failed: ", err)
	}

	// Initialize the store
	store := db.NewStore(pool)

	// Create a new server
	server := api.NewServer(store)

	// Start and run the server
	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("cannot start server: ", err)
	}
}
