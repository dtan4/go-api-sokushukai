BINARY := server
LDFLAGS := -ldflags="-s -w"

GLIDE_VERSION := 0.11.1

.DEFAULT_GOAL := bin/server

bin/server: deps
	go build $(LDFLAGS) -o bin/server

.PHONY: clean
clean:
	rm -rf bin/*
	rm -rf vendor/*

.PHONY: deps
deps: glide
	./glide install

glide:
ifeq ($(shell uname),Darwin)
	curl -fL https://github.com/Masterminds/glide/releases/download/v$(GLIDE_VERSION)/glide-v$(GLIDE_VERSION)-darwin-amd64.zip -o glide.zip
	unzip glide.zip
	mv ./darwin-amd64/glide glide
	rm -fr ./darwin-amd64
	rm ./glide.zip
else
	curl -fL https://github.com/Masterminds/glide/releases/download/v$(GLIDE_VERSION)/glide-v$(GLIDE_VERSION)-linux-amd64.zip -o glide.zip
	unzip glide.zip
	mv ./linux-amd64/glide glide
	rm -fr ./linux-amd64
	rm ./glide.zip
endif

.PHONY: update-deps
update-deps: glide
	./glide update
