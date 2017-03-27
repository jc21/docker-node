# docker-node

Can be used for production, dev and testing.

Will automatically run `node src/index.js` from the internal `/srv/app` folder.

As this image is designed to run on smaller AWS instances, the default node cmd will fire the garbage collector at 250mb.

```bash
docker pull jc21/node
```

## Globally installed packages

- mocha
- istanbul
- nodemon
- gulp
- bower
- mocha-bamboo-reporter
- tick
