SHELL=/bin/bash
ENV_GENERATOR=gen_env.sh
ARG_GENERATOR=docker_args.sh
ENV_FILE=.env

.PHONY: env build run clean

-include $(ENV_FILE)

build: env
	docker build -t $(IMAGE) $(shell . $(ARG_GENERATOR)) .

env: base.env
	$(SHELL) $(ENV_GENERATOR)

run: build
	docker run --rm -v $(TARGET):/target/$(notdir $(TARGET)) $(IMAGE)

clean:
	rm $(ENV_FILE)
	docker rmi $(IMAGE)
	docker rmi $(docker images -f 'dangling=true' -q)

