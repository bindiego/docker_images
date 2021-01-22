pwd := $(shell pwd)
ipaddr := $(shell hostname -I | cut -d ' ' -f 1)

# ============ Rust builder ==============
# Rust env builder
rustbuilder: $(pwd)/Dockerfile.d/Dockerfile.builder.rust
	@docker build \
		-t rustbuilder \
		-f $(pwd)/Dockerfile.d/Dockerfile.builder.rust .

rustbuilder_rebuild: $(pwd)/Dockerfile.d/Dockerfile.builder.rust
	@docker build --no-cache \
		-t rustbuilder \
		-f $(pwd)/Dockerfile.d/Dockerfile.builder.rust .

# Rust nightly env builder
rbnightly: rustbuilder $(pwd)/Dockerfile.d/Dockerfile.builder.rust.nightly
	@docker build \
		-t rustbuilder_nightly \
		-f $(pwd)/Dockerfile.d/Dockerfile.builder.rust.nightly .

rbnightly_rebuild: rustbuilder_rebuild $(pwd)/Dockerfile.d/Dockerfile.builder.rust.nightly
	@docker build --no-cache \
		-t rustbuilder_nightly \
		-f $(pwd)/Dockerfile.d/Dockerfile.builder.rust.nightly .

# ============ Polkadot ==============
# Polkadot builder
polkadot_builder: rbnightly $(pwd)/Dockerfile.d/Dockerfile.builder.polkadot
	@docker build \
		-t polkadot_builder \
		-f $(pwd)/Dockerfile.d/Dockerfile.builder.polkadot .

# build the polkadot binary
build_polkadot: polkadot_builder
	@[ -d $(pwd)/builder_polkadot ] || mkdir $(pwd)/builder_polkadot
	@[ -f $(pwd)/builder_polkadot/polkadot_build.sh ] || cp $(pwd)/bin/polkadot_build.sh $(pwd)/builder_polkadot/polkadot_build.sh \
		&& chmod +x $(pwd)/builder_polkadot/polkadot_build.sh
	@docker run --name polkadot_builder -it \
		-v $(pwd)/builder_polkadot:/builder:rw \
		polkadot_builder /builder/polkadot_build.sh
	@docker rm polkadot_builder

# build the polkadot container/runner
polkadot_runner: build_polkadot $(pwd)/Dockerfile.d/Dockerfile.runner.polkadot
	@docker build \
		-t polkadot_runner\
		-f $(pwd)/Dockerfile.d/Dockerfile.runner.polkadot .

# ============ Phala ==============
# Phala_node builder
phala_node_builder: rbnightly $(pwd)/Dockerfile.d/Dockerfile.builder.phala_node
	@docker build \
		-t phala_node_builder \
		-f $(pwd)/Dockerfile.d/Dockerfile.builder.phala_node .

# build the phala binary
build_phala_node: phala_node_builder
	@[ -d $(pwd)/builder_phala ] || mkdir $(pwd)/builder_phala
	@[ -f $(pwd)/builder_phala/phala_node_build.sh ] || cp $(pwd)/bin/phala_node_build.sh $(pwd)/builder_phala/phala_node_build.sh \
		&& chmod +x $(pwd)/builder_phala/phala_node_build.sh
	@docker run --name phala_node_builder -it \
		-v $(pwd)/builder_phala:/builder:rw \
		phala_node_builder /builder/phala_node_build.sh
	@docker rm phala_node_builder

# build the phala node container/runner
phala_node_runner: build_phala_node $(pwd)/Dockerfile.d/Dockerfile.runner.phala_node
	@docker build \
		-t phala_node_runner\
		-f $(pwd)/Dockerfile.d/Dockerfile.runner.phala_node .

# clean the build, use with cautious
clean:
	@-sudo rm -rf builder_*
# .PHONY: build_polkadot
