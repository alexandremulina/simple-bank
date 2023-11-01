migrateup:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable" -verbose down


migratedown1:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5439/postgres?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate


test:
	go test -v -cover ./...


server:
	go run main.go
	
mock:
	mockgen -package mockdb -destination db/mock/store.go masterclass/db/sqlc Store
	

.PHONY: migrateup migratedown migrateup1 migratedown1 sqlc test server mock