pwd := $(shell pwd)
ipaddr := $(shell hostname -I | cut -d ' ' -f 1)

.PHONY:
prereq:
	@sudo sysctl -w vm.max_map_count=262144

.PHONY:
docker_ubuntu:
	@cd ../ubuntu && make build && cd $(pwd)
.PHONY:
docker_jdk:
	@cd ../jdk && make build && cd $(pwd)
.PHONY:
docker_go:
	@cd ../go && make build && cd $(pwd)

.PHONY:
all: build run

.PHONY:
clean: stop
	@docker rm apm_server kibana elasticsearch
	@-docker rm -v $(docker ps -a -q -f status=exited)
	@-docker rmi $(docker images -f "dangling=true" -q)
	# rm -rf $(pwd)/data

.PHONY:
build: build_es build_kbn build_apm

.PHONY:
run: run_es run_kbn run_apm

.PHONY:
stop: 
	@-docker stop apm_server 
	@-docker stop kibana
	@-docker stop elasticsearch

.PHONY:
build_es: docker_ubuntu docker_jdk
	@docker build -t bwes -f Dockerfile.es .

.PHONY:
build_kbn: docker_ubuntu
	@docker build -t bwkbn -f Dockerfile.kbn .

.PHONY:
build_apm: docker_ubuntu docker_go
	@docker build -t bwapm -f Dockerfile.apm .

.PHONY:
run_es: prereq
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

.PHONY:
run_apm:
	[ -d data ] || mkdir -p data

	docker run \
		--name apm_server \
		-p 18200:8200 \
		-p 15066:5066 \
		-v $(pwd)/data:/data \
	    -e ES_IP=$(ipaddr) \
	    -e ES_PORT=19200 \
	    -e KBN_IP=$(ipaddr) \
	    -e KBN_PORT=15601 \
		--restart=unless-stopped \
		-m 1G --memory-swap -1 \
		--cpuset-cpus="0,1" \
		-d \
		bwapm
