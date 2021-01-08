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
- Create a PR against the appropriate branch (maintenance releases should be made
against the release branch), get it approved, and merge.

## Upstream Rebase

After each major release of Dash Enterprise, our buildpack fork should be
rebased onto `heroku/heroku-buildpack-python` as needed. This should happen
as soon as possible after a major release to allow for enough time to test
and resolve any issues before the start of another freeze cycle. These
rebases could potentially introduce a substantial amount of changes,
which are likely too risky to introduce during a feature freeze.

Steps for rebase:

    # add a fresh heroku remote
    git remote rm heroku || true
    git remote add heroku https://github.com/heroku/heroku-buildpack-python

    # fetch heroku changes
    git fetch heroku
    git checkout origin/master
    git branch -D rebase-on-upstream || true
    git checkout -b rebase-on-upstream

    # rebase our commits onto `heroku/heroku-buildpack-python`
    # resolve any conflicts as necessary
    # update vendored get-pip.py as necessary
    git rebase heroku/master
    git push origin rebase-on-upstream

Once the rebase is complete, simply run through the release process as detailed above.

### Dependency sync between the buildpack and [`dds-vendor`](https://github.com/plotly/dds-vendor)

Our fork of the buildpack relies on [`dds-vendor`](https://github.com/plotly/dds-vendor) for installing python's basic dependencies such as `pip`, `wheel` and `setuptools` so, the person syncing the buildpack should ensure that new versions of those dependencies also get updated on the `dds-vendor`'s [Dockerfile](https://github.com/plotly/dds-vendor/blob/master/Dockerfile).
