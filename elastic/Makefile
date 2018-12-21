pwd := $(shell pwd)
ipaddr := $(shell hostname -I | cut -d ' ' -f 1)

.PHONY:
all: build run

.PHONY:
clean:
	@docker stop kibana elasticsearch
	@docker rm kibana elasticsearch
	@-docker rm -v $(docker ps -a -q -f status=exited)
	@-docker rmi $(docker images -f "dangling=true" -q)
	# rm -rf $(pwd)/data

.PHONY:
build: build_es build_kbn

.PHONY:
run: run_es run_kbn

.PHONY:
build_es:
	@docker build -t bwes -f Dockerfile.es .

.PHONY:
build_kbn:
	@docker build -t bwkbn -f Dockerfile.kbn .

.PHONY:
run_es:
	[ -d data ] || mkdir -p data

	docker run \
		--name elasticsearch \
		-p 19200:9200 \
	    -e ES_HEAP=1g \
		-v $(pwd)/data:/data \
		--restart=unless-stopped \
		-m 2G --memory-swap -1 \
		--cpuset-cpus="0,1" \
		-d \
		bwes

.PHONY:
run_kbn:
	[ -d data ] || mkdir -p data

	docker run \
		--name kibana \
		-p 15601:5601 \
		-v $(pwd)/data:/data \
	    -e ES_IP=$(ipaddr) \
	    -e ES_PORT=19200 \
		--restart=unless-stopped \
		-m 1G --memory-swap -1 \
		--cpuset-cpus="0,1" \
		-d \
		bwkbn