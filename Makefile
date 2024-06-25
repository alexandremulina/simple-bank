DB_URL=postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable

network:
	docker network create bank-network


postgres:
	docker run --name postgres --network bank-network -p 5439:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d postgres:13-alpine

createdb:
	docker exec -it postgres createdb --username=postgres --owner=simple_bank

dropdb:
	docker exec -it postgres dropdb simple_bank

new_migration:
	migrate create -ext sql -dir db/migration -seq <migration_name>


postgres:
	docker run --name postgres --network bank-network -p 5439:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d postgres:13-alpine


migrateup:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable" -verbose down


migrateup1:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable" -verbose up 1

migratedown1:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable" -verbose down 1


sqlc:
	sqlc generate


test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go simplebank/db/sqlc Store

.PHONY: migrateup migratedown sqlc test server mock migrateup1 migratedown1 postgres network createdb dropdb new_migration