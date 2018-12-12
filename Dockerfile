FROM docker.io/node:10-slim

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

RUN apt-get update && apt-get install -y python make g++ git && apt-get clean
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN yarn global add mocha istanbul nodemon gulp mocha-bamboo-reporter tick grunt grunt-cli

WORKDIR /srv/app

CMD [ "node", "src/index.js", "--max_old_space_size=250" ]

