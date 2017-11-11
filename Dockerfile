FROM docker.io/node:alpine

RUN npm install -g mocha istanbul nodemon gulp bower mocha-bamboo-reporter tick grunt grunt-cli

WORKDIR /srv/app

CMD [ "node", "src/index.js", "--max_old_space_size=250" ]
