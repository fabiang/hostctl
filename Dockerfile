FROM golang:1.13-alpine AS build

WORKDIR /go/src/app
COPY . .
RUN go build -o hostctl main.go

FROM alpine
COPY --from=build /go/src/app/hostctl /usr/local/bin/hostctl
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN apk add --update --no-cache bash \
  && chmod +x /usr/local/bin/docker-entrypoint
ENV PROJECT_NAME=docker
ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
CMD ["hostctl", "--host-file", "/etc/host-hosts", "sync", "docker"]
