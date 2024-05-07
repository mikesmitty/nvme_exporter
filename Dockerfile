FROM golang:1.22.3-bookworm

RUN apt-get update && \
    apt-get -y upgrade
RUN apt-get -y install nvme-cli && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /go/src/nvme_exporter
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

EXPOSE 9998

CMD [ "nvme_exporter" ]
