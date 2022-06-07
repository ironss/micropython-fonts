PYFONT_DIR = pyfonts
EXAMPLE_DIR = examples

FONT_TO_PY_DIR = ../micropython-font-to-py
FONT_TO_PY = .venv/bin/python $(FONT_TO_PY_DIR)/font_to_py.py


varfont_sizes += 10
varfont_sizes += 12
varfont_sizes += 16
varfont_sizes += 20
varfont_sizes += 24
varfont_sizes += 32
varfont_sizes += 40

varfonts += DejaVuSans
varfonts += DejaVuSans_Bold
varfonts += Verdana
varfonts += Verdana_Bold

all_varfonts = $(foreach font,$(varfonts),$(foreach size,$(varfont_sizes),$(font)_$(size)))
all_var_pyfont_files = $(foreach font,$(all_varfonts),$(PYFONT_DIR)/$(font).py)

all_pyfont_files += $(all_var_pyfont_files) $(all_fixed_pyfont_files)
all_pyfont_examples = $(foreach pyfont,$(all_pyfont_files),$(patsubst $(PYFONT_DIR)/%.py,$(EXAMPLE_DIR)/%-example.png,$(pyfont)))

pyfont-examples:

pyfonts: $(all_pyfont_files)
	@echo $(all_pyfont_files)
.PHONY:pyfonts

pyfont-examples: $(all_pyfont_examples)
	@echo $(all_pyfont_examples)
.PHONY:pyfont-examples


.py: .ttf
	mkdir -p $(PYFONT_DIR)

.png: .py
	mkdir -p $(EXAMPLE_DIR)


$(PYFONT_DIR)/DejaVuSans_%.py: /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf charsets/iso-8859-15+specials.charset
	mkdir -p $(PYFONT_DIR)
	$(FONT_TO_PY) -k charsets/iso-8859-15+specials.charset $< $(patsubst $(PYFONT_DIR)/DejaVuSans_%.py,%,$@) $@

$(PYFONT_DIR)/DejaVuSans_Bold_%.py: /usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf charsets/iso-8859-15+specials.charset
	mkdir -p $(PYFONT_DIR)
	$(FONT_TO_PY) -k charsets/iso-8859-15+specials.charset $< $(patsubst $(PYFONT_DIR)/DejaVuSans_Bold_%.py,%,$@) $@

$(PYFONT_DIR)/Verdana_%.py: /usr/share/fonts/truetype/msttcorefonts/Verdana.ttf charsets/iso-8859-15+specials.charset
	mkdir -p $(PYFONT_DIR)
	$(FONT_TO_PY) -k charsets/iso-8859-15+specials.charset $< $(patsubst $(PYFONT_DIR)/Verdana_%.py,%,$@) $@

$(PYFONT_DIR)/Verdana_Bold_%.py: /usr/share/fonts/truetype/msttcorefonts/Verdana_Bold.ttf charsets/iso-8859-15+specials.charset
	mkdir -p $(PYFONT_DIR)
	$(FONT_TO_PY) -k charsets/iso-8859-15+specials.charset $< $(patsubst $(PYFONT_DIR)/Verdana_Bold_%.py,%,$@) $@

$(EXAMPLE_DIR)/%-example.png: $(PYFONT_DIR)/%.py create-font-sample.py
	mkdir -p $(EXAMPLE_DIR)
	.venv/bin/python create-font-sample.py $< $@

clean:
	-rm -rf $(PYFONT_DIR)/*
	-rm -rf $(EXAMPLE_DIR)/*
	
