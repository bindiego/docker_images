pwd := $(shell pwd)
ipaddr := $(shell hostname -I | cut -d ' ' -f 1)

.PHONY:
build: build_es build_kbn

.PHONY:
build_es:
	docker build -t bwes -f Dockerfile.es .

.PHONY:
build_kbn:
	docker build -t bwkbn -f Dockerfile.kbn .

.PHONY:
run_es:
	[ -d data ] || mkdir -p data

	docker run \
		--name elasticsearch \
		-p 19200:9200 \
		-v $(pwd)/data:/data \
		--restart=unless-stopped \
		-m 2G --memory-swap -1 \
		--cpuset-cpus="0,1" \
		-d \
		bwes
