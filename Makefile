.DEFAULT_GOAL:=build

.PHONY: build
build: fmt
	latexmk -xelatex -interaction=nonstopmode *.tex

.PHONY: lint
lint:
	bibtex-tidy --modify --sort=key --sort-fields *.bib
	tex-fmt *.tex
