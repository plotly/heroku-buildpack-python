![python](https://cloud.githubusercontent.com/assets/51578/13712821/b68a42ce-e793-11e5-96b0-d8eb978137ba.png)

# Heroku Buildpack: Python

This is a fork of https://github.com/heroku/heroku-buildpack-python/ maintained
by Plotly, and includes the following changes:

* Better support for airgap (fully offline) builds
* Improved debugging on build / deployment
* Links to [DDS](https://dash.plot.ly/dash-deployment-server) docs instead of
to Heroku

## Tests

The buildpack tests use [Docker](https://www.docker.com/) to simulate
Heroku's [stack images.](https://devcenter.heroku.com/articles/stack)

To run the test suite:

```
make test
```

Or to test in a particular stack:

```
make test-heroku-18
make test-heroku-16
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

Note that the base Herokuish version is set in `.circleci/config.yml`.
