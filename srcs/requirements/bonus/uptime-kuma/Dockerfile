FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
	git \
	curl \
	bash

SHELL ["/bin/bash", "-c"]

ENV NVM_DIR /root/.nvm

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
RUN . "$NVM_DIR/nvm.sh" && nvm install 24

WORKDIR /app
RUN git clone https://github.com/louislam/uptime-kuma.git .

COPY conf/kuma.db /app/init_db/kuma.db

COPY tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

EXPOSE 3001

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
	CMD curl -f http://localhost:3001/ || exit 1

ENTRYPOINT ["/usr/local/bin/script.sh"]
