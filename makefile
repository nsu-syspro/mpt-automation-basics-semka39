CC = gcc
JQ = jq

NAME := $(shell $(JQ) -r .name config.json)
VERSION := $(shell $(JQ) -r .version config.json)

SHELL := /bin/bash
SRC = src/wordcount.c
CONFIG = config.json
TARGET = build/$(NAME)

CFLAGS = -DNAME='"$(NAME)"' -DVERSION='"$(VERSION)"'

.DEFAULT_GOAL := all

all: $(TARGET)

$(TARGET): $(SRC) $(CONFIG)
	mkdir -p build
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET)

clean:
	rm -rf build

.PHONY: all clean check

check: all
	@set -e; \
	for input in test/*.txt; do \
		expected="$${input%.txt}.expected"; \
		diff -u "$$expected" <(./$(TARGET) < "$$input"); \
	done
