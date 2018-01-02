FROM docker.io/node:9-slim

RUN apt-get update && apt-get install -y python make g++ git && apt-get clean

RUN npm install -g mocha istanbul nodemon gulp mocha-bamboo-reporter tick grunt grunt-cli

WORKDIR /srv/app

CMD [ "node", "src/index.js", "--max_old_space_size=250" ]

