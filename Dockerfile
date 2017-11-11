FROM docker.io/node:9-slim

RUN npm install -g mocha istanbul nodemon gulp bower mocha-bamboo-reporter tick grunt grunt-cli

WORKDIR /srv/app

CMD [ "node", "src/index.js", "--max_old_space_size=250" ]
