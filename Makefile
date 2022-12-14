BUILD := build
EMBEDS_SRC := $(shell fd --exact-depth=1 --type d . embeds)
EMBEDS_OUT := $(addprefix $(BUILD)/,$(EMBEDS_SRC))
SRC := src
FNL := $(shell fd --strip-cwd-prefix --type f --extension fnl .)
LUA := $(patsubst $(SRC)/%.fnl, $(BUILD)/%.lua, ${FNL})
XML := $(shell fd --strip-cwd-prefix --type f --extension xml .)
XML_OUT := $(patsubst $(SRC)/%.xml, $(BUILD)/%.xml, ${XML})

all: $(LUA) $(XML_OUT) $(BUILD)/sInterface.toc $(BUILD)/media/bar.tga $(EMBEDS_OUT)

$(BUILD)/sInterface.toc: $(SRC)/sInterface.toc
	@mkdir -p $(@D)
	cp $< $@

$(BUILD)/embeds/%: embeds/%
	@mkdir -p $(@D)
	cp -r $< $@

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
