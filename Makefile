.PHONY: all build push deploy

REV:=$(shell git rev-parse --short HEAD)

all: build push deploy

build:
	@./gradlew clean build -PbuildNumber=${REV}
	@docker build --no-cache --pull -t wisvch-docker-registry.bintray.io/kube-auth:latest -t wisvch-docker-registry.bintray.io/kube-auth:${REV} .

push:
	@docker push wisvch-docker-registry.bintray.io/kube-auth:latest
	@docker push wisvch-docker-registry.bintray.io/kube-auth:${REV}

deploy:
	@kubectl set image deployment kube-auth kube-auth=wisvch-docker-registry.bintray.io/kube-auth:${REV}
