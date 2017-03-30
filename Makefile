.PHONY: assets

SHELL = /bin/bash

GO_BINDATA := $(shell command -v go-bindata)
JUSTRUN := $(shell command -v justrun)

WATCH_TARGETS = static/bootstrap.min.css templates/index.html main.go \
static/style.css static/carousel.css

lint:
	go vet ./...

test: lint
	go test ./...

race-test: lint
	go test -race ./...

serve:
	go run main.go

assets:
ifndef GO_BINDATA
	go get -u github.com/jteeuwen/go-bindata/...
endif
	go-bindata -o=assets/bindata.go --nometadata --pkg=assets templates/... static/...

watch:
ifndef JUSTRUN
	go get -u github.com/jmhodges/justrun
endif
	justrun -v --delay=100ms -c 'make assets serve' $(WATCH_TARGETS)
