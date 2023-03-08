IMG_NAME := local/abq-ahca-coreq
TAG := 1.1

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

img:         ## Build docker image
	@docker build --progress=plain -t $(IMG_NAME):$(TAG) -f Dockerfile .

run:         ## Start container and connect to it
	docker run -it --rm -P --entrypoint /bin/bash $(IMG_NAME):$(TAG)


