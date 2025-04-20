IMAGE_NAME = jkutkut/docker4osmia

build:
	docker build -t ${IMAGE_NAME} .

versions:
	@docker run --rm -t ${IMAGE_NAME} -v | \
		grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | \
		sed -E 's/v//'

cli-version:
	@make versions | head -n 2 | tail -n 1

lib-version:
	@make versions | tail -n 2 | head -n 1

docker-version:
	@echo "$(shell make cli-version)-$(shell make lib-version)"

release: build
	docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:$(shell make docker-version)
	docker push ${IMAGE_NAME}:$(shell make docker-version)
	docker push ${IMAGE_NAME}:latest

open-dockerhub:
	@open https://hub.docker.com/r/${IMAGE_NAME}
