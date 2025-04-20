# building main service binary
FROM golang:1.24 AS service-builder

WORKDIR /service

COPY service.go .

RUN CGO_ENABLED=0 GOOS=linux go build -o service service.go

# building dep binary
FROM golang:1.24 AS outputter-builder

WORKDIR /outputter

COPY outputter.go .

RUN CGO_ENABLED=0 GOOS=linux go build -o outputter outputter.go


FROM scratch

COPY --from=service-builder /service/service /service
COPY --from=outputter-builder /outputter/outputter /outputter

ENTRYPOINT ["/service"]
