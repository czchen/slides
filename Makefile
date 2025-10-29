.DEFAULT_GOAL:=build

.PHONY: build
build:
	latexmk -xelatex -interaction=nonstopmode *.tex
