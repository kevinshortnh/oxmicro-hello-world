#!/usr/bin/env make -f

	DEVPI_INDEX     = http://migration-jenkins-n01.prod.dfw1.cit.rackspace.net:3141/kevi9532/qe/

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-15s %s\n", $$1, $$2}'

clean: ## clean
	python setup.py clean
	$(RM) -r dist
	$(RM) -r *.egg-info
#	$(RM) -r build
#	$(RM) -r setup.cfg
#	$(RM) *.pyc */*.pyc

#---

publish: ## Register, build Source Distribution, and Upload to Repository
	python setup.py register -r $(DEVPI_INDEX) sdist upload -r $(DEVPI_INDEX)
