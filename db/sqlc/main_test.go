package db

import (
	"database/sql"
	"log"
	"testing"

	_ "github.com/lib/pq"
)


var testQueries *Queries
var testDB *sql.DB



func TestMain(m *testing.M) {
	var err error
	testDB, err = sql.Open("postgres", "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable")
	if err != nil {
		log.Fatal("cannot connect to db: ", err)
	}

	testQueries = New(testDB)

m.Run()

}