FROM resin/armv7hf-debian-qemu

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

RUN [ "cross-build-start" ]

RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
RUN apt-get update \
    && apt-get install -y nodejs python make g++ git build-essential \
    && apt-get clean \
    && npm install -g mocha istanbul nodemon gulp mocha-bamboo-reporter tick grunt grunt-cli \
    && curl -o- -L https://yarnpkg.com/install.sh | bash

RUN [ "cross-build-end" ]

WORKDIR /srv/app

CMD [ "node", "src/index.js", "--max_old_space_size=250" ]
