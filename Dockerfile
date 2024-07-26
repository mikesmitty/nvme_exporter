FROM golang:alpine AS build

WORKDIR /go/build
COPY go.mod go.sum .
RUN go mod download -x
COPY *.go .
RUN go build -trimpath -o nvme-exporter

# ~~~~~~~~~~~~~~

FROM alpine:3.20

RUN apk add --no-cache nvme-cli
COPY --from=build /go/build/nvme-exporter /usr/bin/nvme-exporter

EXPOSE 9998
ENTRYPOINT ["/usr/bin/nvme-exporter"]
