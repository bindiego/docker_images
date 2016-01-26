.PHONY:
build:
	docker build -t ptmysql -f Dockerfile .

.PHONY:
run:
	docker run \
		--name ptmysql5_5 \
		-e MYSQL_ROOT_PASSWORD=root \
		-p 3306:3306 \
		-v /home/wubin/data/mysql5_5:/var/lib/mysql \
		--restart=unless-stopped -m 1G --memory-swap -1 --cpuset-cpus="0,1" \
		-d \
		ptmysql
