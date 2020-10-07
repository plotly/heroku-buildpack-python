![python](https://cloud.githubusercontent.com/assets/51578/13712821/b68a42ce-e793-11e5-96b0-d8eb978137ba.png)

# Heroku Buildpack: Python

<<<<<<< HEAD
This is a fork of https://github.com/heroku/heroku-buildpack-python/ maintained
by Plotly, and includes the following changes:
=======
[![Build Status](https://travis-ci.com/heroku/heroku-buildpack-python.svg?branch=main)](https://travis-ci.com/heroku/heroku-buildpack-python)
>>>>>>> heroku/main

* Better support for airgap (fully offline) builds
* Improved debugging on build / deployment
* Links to [DDS](https://dash.plot.ly/dash-deployment-server) docs instead of
to Heroku

## Changelog

<<<<<<< HEAD
Please update the changelog with all updates made to our fork of the upstream buildpack.
This helps maintain a list of behaviour that we are looking to preserve should the need
to resolve any conflicts with upstream arises.
=======
Python packages with C dependencies that are not [available on the stack image](https://devcenter.heroku.com/articles/stack-packages) are generally not supported, unless `manylinux` wheels are provided by the package maintainers (common). For recommended solutions, check out [this article](https://devcenter.heroku.com/articles/python-c-deps) for more information.

See it in Action
----------------
```
$ ls
my-application		requirements.txt	runtime.txt

$ git push heroku main
Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), 276 bytes | 276.00 KiB/s, done.
Total 4 (delta 0), reused 0 (delta 0)
remote: Compressing source files... done.
remote: Building source:
remote:
remote: -----> Python app detected
remote: -----> Installing python
remote: -----> Installing pip
remote: -----> Installing SQLite3
remote: -----> Installing requirements with pip
remote:        Collecting flask (from -r /tmp/build_c2c067ef79ff14c9bf1aed6796f9ed1f/requirements.txt (line 1))
remote:          Downloading ...
remote:        Installing collected packages: Werkzeug, click, MarkupSafe, Jinja2, itsdangerous, flask
remote:        Successfully installed Jinja2-2.10 MarkupSafe-1.1.0 Werkzeug-0.14.1 click-7.0 flask-1.0.2 itsdangerous-1.1.0
remote:
remote: -----> Discovering process types
remote:        Procfile declares types -> (none)
remote:
```

A `requirements.txt` must be present at the root of your application's repository to deploy.

To specify your python version, you also need a `runtime.txt` file - unless you are using the default Python runtime version.

Current default Python Runtime: Python 3.6.12

Alternatively, you can provide a `setup.py` file, or a `Pipfile`.
Using `pipenv` will generate `runtime.txt` at build time if one of the field `python_version` or `python_full_version` is specified in the `requires` section of your `Pipfile`.

Specify a Buildpack Version
---------------------------

You can specify the latest production release of this buildpack for upcoming builds of an existing application:

    $ heroku buildpacks:set heroku/python


Specify a Python Runtime
------------------------

Supported runtime options include:

- `python-3.9.0`
- `python-3.8.6`
- `python-3.7.9`
- `python-3.6.12`
- `python-2.7.18`
>>>>>>> heroku/main

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
