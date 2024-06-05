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

mock:
	mockgen -package mockdb -destination db/mock/store.go simplebank/db/sqlc Store

.PHONY: migrateup migratedown sqlc test server mock