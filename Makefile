.PHONY: all build push deploy

REV:=$(shell git rev-parse --short HEAD)

all: build push deploy

build:
	@./gradlew clean build -PbuildNumber=${REV}
	@docker build --no-cache --pull -t wisvch/kube-auth:latest -t wisvch/kube-auth:${REV} .

push:
	@docker push wisvch/kube-auth:latest
	@docker push wisvch/kube-auth:${REV}

deploy:
	@kubectl set image deployment kube-auth kube-auth=wisvch/kube-auth:${REV}
