FROM debian:bookworm

RUN apt-get update && apt-get install -y python3

WORKDIR /var/www/memory

COPY conf/index.html .

EXPOSE 8080

CMD ["python3", "-m", "http.server", "8080", "--bind", "0.0.0.0"]
