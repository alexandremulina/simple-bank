package main

import (
	"context"
	"log"
	"simplebank/api"
	db "simplebank/db/sqlc"
	"simplebank/db/util"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}

	// Connect to the database
	pool, err := pgxpool.New(context.Background(), config.DBSource)
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
	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatal("cannot create server: ", err)
	}

	// Start and run the server
	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("cannot start server: ", err)
	}
}
