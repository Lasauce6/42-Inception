FROM debian:bookworm

RUN apt-get update && apt-get install -y git curl bash

WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_24.x | bash -
RUN apt-get install -y nodejs

RUN git clone https://github.com/Lasauce6/raphaelbaticle.fr.git .
RUN npm install
RUN npm run build

EXPOSE 3000

CMD ["node", ".output/server/index.mjs"]
