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

- Rebase our commits onto `heroku/heroku-buildpack-python`
    ```shell
    # clone the repository
    git clone https://github.com/plotly/heroku-buildpack-python
    cd heroku-buildpack-python

    # fetch heroku changes
    git remote rm heroku || true
    git remote add heroku https://github.com/heroku/heroku-buildpack-python
    git fetch heroku

    # rebase our commits onto `heroku/heroku-buildpack-python`
    # resolve any conflicts as necessary
    git pull --rebase heroku master

    # force push onto master
    git push --force origin master
    ```
- Create a tag, of the form `3.1.0b1`, where `3.1.0` is the On-Prem release
we're currently working on and `b1` is a build ID that's incremented for
each build.
    ```shell
    git tag 3.1.0b1
    git push --tags
    ```
- Update
[`plotly/herokuish`](https://github.com/plotly/herokuish/blob/master/Dockerfile)
to use the new version,
[create a new Herokuish release](https://github.com/plotly/herokuish#releasing),
and test with DDS.
- If needed, fix things on your branch and iterate by creating a new tag and
a new Herokuish release.
- Create a PR, get it approved, and merge.
