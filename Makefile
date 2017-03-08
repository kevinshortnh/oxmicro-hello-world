#!/usr/bin/env make -f

		REPOSITORY      = testpypi
live:           REPOSITORY     = pypi

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-15s %s\n", $$1, $$2}'

#---

build: ## Build everything needed to install
	python setup.py build

build_scripts: ## Build scripts (copy and fixup #! line)
	python setup.py build_scripts

clean: ## Clean up temporary files from 'build' command
	python setup.py clean
	$(RM) -r build
	$(RM) -r dist
	$(RM) -r setup.cfg
	$(RM) -r oxmicro_hello_world.egg-info

install: ## Install everything from build directory
	python setup.py install

sdist: ## Create a source distribution (tarball, zip file, etc.)
	python setup.py sdist

register: ## Register the distribution with the Python package index
	python setup.py register -r $(REPOSITORY)

bdist: ## Create a built (binary) distribution
	python setup.py bdist

upload: ## Upload upload binary package to PyPI
	python setup.py sdist upload -r $(REPOSITORY)

check: ## Perform some checks on the package
	python setup.py check

#---

extra-saveopts: ## save supplied options to setup.cfg or other config file
	python setup.py saveopts

extra-develop: ## install package in 'development mode'
	python setup.py develop

extra-setopt: ## set an option in setup.cfg or another config file
	python setup.py setopt

extra-install_egg_info: ## Install an .egg-info directory for the package
	python setup.py install_egg_info

extra-rotate: ## delete older distributions, keeping N newest files
	python setup.py rotate

extra-egg_info: ## create a distribution's .egg-info directory
	python setup.py egg_info

extra-bdist_egg: ## create an "egg" distribution
	python setup.py bdist_egg

#---

twine-upload: ## Twine upload
	twine upload dist/* -r $(REPOSITORY)
