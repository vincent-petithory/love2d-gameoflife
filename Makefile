SRC := src
SOURCES := $(shell find $(SRC) -type f)
DEPS_WIN64 := $(addprefix love-0.10.2-win64/, license.txt \
	love.dll \
	lua51.dll \
	mpg123.dll \
	msvcp120.dll \
	msvcr120.dll \
	OpenAL32.dll \
	SDL2.dll)

GAME_WIN64 := dist/GameOfLife.exe
DIST_WIN64 := dist/GameOfLife-win64.zip

GAME := dist/GameOfLife.love

all: $(GAME)
.PHONY: all

dist:
	mkdir -p $@

run:
	love $(SRC)
.PHONY: run

$(GAME): $(SOURCES) dist
	cd $(SRC) && zip -9 -r ../$(GAME) *

clean:
	rm -f $(GAME) $(GAME_WIN64) $(DIST_WIN64)
.PHONY: clean

$(GAME_WIN64): love-0.10.2-win64/love.exe $(GAME)
	cat $^ > $@

$(DIST_WIN64): $(GAME_WIN64) $(DEPS_WIN64)
	zip -9 -j $@ $^

