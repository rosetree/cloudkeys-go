VERSION = $(shell git describe --tags)

default: build

build: $(GOPATH)/bin/godep bindata.go
	$(GOPATH)/bin/godep go build -ldflags "-X main.version=$(VERSION)" .

pre-commit: bindata.go

container: bindata.go
	docker build .

gen_css:
	lessc --verbose -O2 -x less/*.less assets/style.css

gen_js:
	coffee --compile -o assets coffee/*.coffee

bindata.go: gen_css gen_js
	go generate

$(GOPATH)/bin/godep:
	go get github.com/tools/godep
