pwd := $(shell pwd)
ipaddr := $(shell hostname -I | cut -d ' ' -f 1)

rustbuilder: $(pwd)/Dockerfile.d/Dockerfile.builder.rust
	@docker build \
		-t rustbuilder \
		-f $(pwd)/Dockerfile.d/Dockerfile.builder.rust .

rustbuilder_rebuild: $(pwd)/Dockerfile.d/Dockerfile.builder.rust
	@docker build --no-cache \
		-t rustbuilder \
		-f $(pwd)/Dockerfile.d/Dockerfile.builder.rust .

