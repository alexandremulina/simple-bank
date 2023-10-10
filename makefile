migrateup:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable" -verbose down

sqlc:
	sqlc generate


test:
	go test -v -cover ./...


server:
	go run main.go

.PHONY: migrateup migratedown