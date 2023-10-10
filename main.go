package main

import (
	"database/sql"
	_ "github.com/lib/pq"
	"log"
	"masterclass/api"
	db "masterclass/db/sqlc"
)

func main() {
	conn, err := sql.Open("postgres", "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable")
	if err != nil {
		log.Fatal("cannot connect to db: ", err)
	}
	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(":8080")
	if err != nil {
		log.Fatal("cannot start server: ", err)
	}

}
