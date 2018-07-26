FROM resin/armv7hf-debian-qemu

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

RUN [ "cross-build-start" ]

RUN apt-get update \
    && apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - \
    && apt-get install -y nodejs python make g++ git build-essential \
    && apt-get clean \
    && npm config set unsafe-perm true \
    && npm install -g mocha istanbul nodemon gulp mocha-bamboo-reporter tick grunt grunt-cli \
    && curl -o- -L https://yarnpkg.com/install.sh | bash \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && sudo apt-get install yarn

RUN [ "cross-build-end" ]

WORKDIR /srv/app

CMD [ "node", "src/index.js", "--max_old_space_size=250" ]

