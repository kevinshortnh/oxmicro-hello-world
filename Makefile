#!/usr/bin/env make -f

        PYPIRC_REPO     = faws-kevi9532
test:   PYPIRC_REPO     = testpypi
live:   PYPIRC_REPO     = pypi

        PACKAGE_NAME    = oxmicro_hello_world
        PACKAGE_VER     = 0.3

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-15s %s\n", $$1, $$2}'

clean: ## clean
	make setup-clean
	$(RM) -r build
	$(RM) -r dist
	$(RM) -r setup.cfg
	$(RM) -r oxmicro_hello_world.egg-info
	$(RM) *.pyc */*.pyc

#---

setup-build: ## Build everything needed to install
	python setup.py build

setup-build_scripts: ## Build scripts (copy and fixup #! line)
	python setup.py build_scripts

setup-clean: ## Clean up temporary files from 'build' command
	python setup.py clean

setup-install: ## Install everything from build directory
	python setup.py install

setup-sdist: ## Create a source distribution (tarball, zip file, etc.)
	python setup.py sdist

setup-register: ## Register the distribution with the Python package index
	python setup.py register -r $(PYPIRC_REPO)

setup-bdist: ## Create a built (binary) distribution
	python setup.py bdist

setup-upload: ## Upload upload binary package to PyPI
	python setup.py sdist upload -r $(PYPIRC_REPO)

setup-check: ## Perform some checks on the package
	python setup.py check

#---

extras-saveopts: ## save supplied options to setup.cfg or other config file
	python setup.py saveopts

extras-develop: ## install package in 'development mode'
	python setup.py develop

extras-setopt: ## set an option in setup.cfg or another config file
	python setup.py setopt

extras-install_egg_info: ## Install an .egg-info directory for the package
	python setup.py install_egg_info

extras-rotate: ## delete older distributions, keeping N newest files
	python setup.py rotate

extras-egg_info: ## create a distribution's .egg-info directory
	python setup.py egg_info

extras-bdist_egg: ## create an "egg" distribution
	python setup.py bdist_egg

#---

twine-upload: ## Twine upload
	twine upload dist/* -r $(PYPIRC_REPO)

#---

devpi-upload: ## devpi upload
	devpi upload --index $(DEV_INDEX)

devpi-push: ## devpi push
	devpi use $(DEV_INDEX)
	devpi push oxmicro_hello_world==0.3 $(PROD_INDEX)

devpi-remove: ## devpi remove
	devpi remove -y --index $(DEV_INDEX) $(PACKAGE_NAME)

devpi-reindex: ## devpi-server reindex
	devpi-server --stop
	devpi-server --recreate-search-index
	devpi-server --start

devpi-restart: ## devpi-server restart
	devpi-server --stop
	devpi-server --start --host=0.0.0.0 --port 3141
