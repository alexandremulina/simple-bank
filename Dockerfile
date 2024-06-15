# Builder stage
FROM golang:1.22-alpine3.19 AS builder

WORKDIR /app

# Copy only necessary files for building the Go application
COPY go.mod .   
COPY go.sum .
RUN go mod download

# Copy the rest of the application source code
COPY . .

# Build the Go application
RUN go build -o main .
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.14.1/migrate.linux-amd64.tar.gz | tar xvz


# Final stage
FROM alpine:3.19

WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/main .
COPY --from=builder /app/migrate.linux-amd64 ./migrate
COPY app.env .
COPY start.sh .
COPY db/migration ./migration

# Expose the port the application runs on
EXPOSE 8080

# Command to run the executable
CMD ["/app/main"]
ENTRYPOINT [ "/app/start.sh" ]
