FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
	git \
	curl \
	bash


WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_24.x | bash -
RUN apt-get install -y nodejs

RUN git clone https://github.com/louislam/uptime-kuma.git .

COPY conf/kuma.db /app/init_db/kuma.db

COPY tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

EXPOSE 3001

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
	CMD curl -f http://localhost:3001/ || exit 1

ENTRYPOINT ["/usr/local/bin/script.sh"]
