FROM golang:1.24 AS builder

WORKDIR /app

COPY go.mod .
RUN go mod download
COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -o server main.go


FROM alpine:3.21

WORKDIR /app

COPY --from=builder /app/server /app/server

EXPOSE 8080

CMD ["/app/server"]
