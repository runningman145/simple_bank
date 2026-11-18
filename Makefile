postgres:
	sudo docker run --name postgres17 -p 2345:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret  -d postgres:17.5-alpine

createdb:
	sudo docker exec -it postgres17 createdb --username=root --owner=root simple_bank

dropdb:
	sudo docker exec -it postgres17 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:2345/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:2345/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:2345/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:2345/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test