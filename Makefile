BUILD := build
SRC := src
FNL := $(shell fd --strip-cwd-prefix --type f --extension fnl .)
LUA := $(patsubst $(SRC)/%.fnl, $(BUILD)/%.lua, ${FNL})

all: $(LUA)

$(BUILD)/%.lua: $(SRC)/%.fnl
	@mkdir -p $(@D)
	fennel --compile $< > $@

clean:
	rm -rf $(BUILD)
