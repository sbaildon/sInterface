BUILD := build
SRC := src
FNL := $(shell fd --strip-cwd-prefix --type f --extension fnl .)
LUA := $(patsubst $(SRC)/%.fnl, $(BUILD)/%.lua, ${FNL})
XML := $(shell fd --strip-cwd-prefix --type f --extension xml .)
XML_OUT := $(patsubst $(SRC)/%.xml, $(BUILD)/%.xml, ${XML})

all: $(LUA) $(XML_OUT) $(BUILD)/sInterface.toc $(BUILD)/media/bar.tga

$(BUILD)/sInterface.toc: $(SRC)/sInterface.toc
	@mkdir -p $(@D)
	cp $< $@

$(BUILD)/media/bar.tga: media/bar.tga
	@mkdir -p $(@D)
	cp $< $@

$(BUILD)/%.lua: $(SRC)/%.fnl
	@mkdir -p $(@D)
	fennel --compile $< > $@

$(BUILD)/%.xml: $(SRC)/%.xml
	@mkdir -p $(@D)
	cp $< $@

clean:
	rm -rf $(BUILD)
