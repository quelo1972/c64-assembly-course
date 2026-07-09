.PHONY: quality-check build-lessons deploy release-docs hook-install

quality-check:
	./scripts/quality-check.sh

build-lessons:
	./scripts/build-lesson-examples.sh

deploy:
	./.venv/bin/mkdocs gh-deploy --clean -b gh-pages -r origin

release-docs:
	./scripts/release-docs.sh

hook-install:
	git config core.hooksPath .githooks
	chmod +x .githooks/pre-push scripts/quality-check.sh scripts/release-docs.sh
	@echo "Git hook path set to .githooks"
