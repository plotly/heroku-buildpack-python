![python](https://cloud.githubusercontent.com/assets/51578/13712821/b68a42ce-e793-11e5-96b0-d8eb978137ba.png)

# Heroku Buildpack: Python

This is a fork of https://github.com/heroku/heroku-buildpack-python/ maintained
by Plotly, and includes the following changes:

* Better support for airgap (fully offline) builds
* Improved debugging on build / deployment
* Links to [DDS](https://dash.plot.ly/dash-deployment-server) docs instead of
to Heroku

## Changelog

Please update the changelog with all updates made to our fork of the upstream buildpack.
This helps maintain a list of behaviour that we are looking to preserve should the need
to resolve any conflicts with upstream arises.

## Tests

The buildpack tests use [Docker](https://www.docker.com/) to simulate
Heroku's [stack images.](https://devcenter.heroku.com/articles/stack)

To run the test suite against the default stack:

```
make test
```

Or to test against a particular stack:

```
make test STACK=heroku-16
```

To run only a subset of the tests:

```
make test TEST_CMD=tests/versions
```

The tests are run via the vendored
[shunit2](https://github.com/kward/shunit2)
test framework.

## Releasing

To create a release:

- Rebase the last three commits onto `heroku/heroku-buildpack-python`
    ```shell
    git remote rm heroku || true
    git remote add heroku https://github.com/plotly/heroku-buildpack-python
    git rebase heroku/master master
    git push -f origin master
    ```
- Create a tag. This tag should correspond with the current herokuish release to indicate what release we're building on top of.
    ```shell
    # if latest gliderlabs/herokuish is 0.4.5
    git tag 0.4.5-1
    git push --tags
    ```
- CI will build a release and push to quay.io
