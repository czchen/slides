.DEFAULT_GOAL:=build

.PHONY: build
build: lint
	latexmk -xelatex -interaction=nonstopmode *.tex

.PHONY: lint
lint:
	bibtex-tidy *.bib --modify --sort=key --sort-fields --no-escape
	tex-fmt *.tex
