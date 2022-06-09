PYFONT_DIR = pyfonts
EXAMPLE_DIR = examples

FONT_TO_PY_DIR = ../micropython-font-to-py
FONT_TO_PY = .venv/bin/python $(FONT_TO_PY_DIR)/font_to_py.py --iterate


#scalable_font_sizes += 10
scalable_font_sizes += 12
scalable_font_sizes += 16
scalable_font_sizes += 20
scalable_font_sizes += 24
scalable_font_sizes += 32
scalable_font_sizes += 40

scalable_fonts += DejaVuSans
scalable_fonts += DejaVuSans_Bold
scalable_fonts += Inter
scalable_fonts += Inter_Bold
scalable_fonts += Montserrat
scalable_fonts += Montserrat_Bold
scalable_fonts += Segoe_UI
scalable_fonts += Segoe_UI_Bold
scalable_fonts += Tahoma
scalable_fonts += Tahoma_Bold
scalable_fonts += Verdana
scalable_fonts += Verdana_Bold

all_scalable_fonts = $(foreach font,$(scalable_fonts),$(foreach size,$(scalable_font_sizes),$(font)_$(size)))
all_scalable_pyfont_files = $(foreach font,$(all_scalable_fonts),$(PYFONT_DIR)/$(font).py)


bitmap_fonts += helvR08
bitmap_fonts += helvR10
bitmap_fonts += helvR12
bitmap_fonts += helvR14
bitmap_fonts += helvR18
bitmap_fonts += helvR24

bitmap_fonts += helvB08
bitmap_fonts += helvB10
bitmap_fonts += helvB12
bitmap_fonts += helvB14
bitmap_fonts += helvB18
bitmap_fonts += helvB24

bitmap_fonts += luRS08
bitmap_fonts += luRS10
bitmap_fonts += luRS12
bitmap_fonts += luRS14
bitmap_fonts += luRS18
bitmap_fonts += luRS19
bitmap_fonts += luRS24

bitmap_fonts += luBS08
bitmap_fonts += luBS10
bitmap_fonts += luBS12
bitmap_fonts += luBS14
bitmap_fonts += luBS18
bitmap_fonts += luBS19
bitmap_fonts += luBS24

#charset = charsets/standard/secs.charset
#charset = charsets/standard/ascii.charset
charset = charsets/custom/iso-8859-15+specials.charset
#charset = charsets/standard/cp437.charset


all_bitmap_fonts = $(foreach font,$(bitmap_fonts),$(foreach dpi,75 100,$(font)_$(dpi)dpi))
all_bitmap_pyfont_files = $(foreach font,$(all_bitmap_fonts),$(PYFONT_DIR)/$(font).py)

all_pyfont_files += $(all_bitmap_pyfont_files) #$(all_scalable_pyfont_files) 
all_pyfont_examples = $(foreach pyfont,$(all_pyfont_files),$(patsubst $(PYFONT_DIR)/%.py,$(EXAMPLE_DIR)/%-example.png,$(pyfont)))

all: pyfont-examples

pyfonts: venvpy $(all_pyfont_files)
	@echo $(all_pyfont_files)
.PHONY: pyfonts

pyfont-examples: venvpy $(all_pyfont_examples)
	@echo $(all_pyfont_examples)
.PHONY: pyfont-examples


.py: .ttf
	mkdir -p $(PYFONT_DIR)

$(PYFONT_DIR)/%_75dpi.py: fonts/bdf/75dpi/%.bdf $(charset)
	mkdir -p $(PYFONT_DIR)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< 100 $@

$(PYFONT_DIR)/%_100dpi.py: fonts/bdf/100dpi/%.bdf $(charset)
	mkdir -p $(PYFONT_DIR)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< 100 $@


.png: .py
	mkdir -p $(EXAMPLE_DIR)


$(PYFONT_DIR)/DejaVuSans_%.py: fonts/ttf/DejaVuSans.ttf $(charset)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/DejaVuSans_%.py,%,$@) $@

$(PYFONT_DIR)/DejaVuSans_Bold_%.py: fonts/ttf/DejaVuSans-Bold.ttf $(charset)
	ls -l $<
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/DejaVuSans_Bold_%.py,%,$@) $@

$(PYFONT_DIR)/Inter_%.py: fonts/ttf/Inter-Regular.ttf $(charset)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Inter_%.py,%,$@) $@

$(PYFONT_DIR)/Inter_Bold_%.py: fonts/ttf/Inter-Bold.ttf $(charset)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Inter_Bold_%.py,%,$@) $@

$(PYFONT_DIR)/Montserrat_%.py: fonts/ttf/Montserrat-Regular.ttf $(charset)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Montserrat_%.py,%,$@) $@

$(PYFONT_DIR)/Montserrat_Bold_%.py: fonts/ttf/Montserrat-Bold.ttf $(charset)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Montserrat_Bold_%.py,%,$@) $@

$(PYFONT_DIR)/Segoe_UI_%.py: fonts/ttf/Segoe_UI.ttf $(charset)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Segoe_UI_%.py,%,$@) $@

$(PYFONT_DIR)/Segoe_UI_Bold_%.py: fonts/ttf/Segoe_UI_Bold.ttf $(charset)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Segoe_UI_Bold_%.py,%,$@) $@

$(PYFONT_DIR)/Tahoma_%.py: fonts/ttf/Tahoma.ttf $(charset)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Tahoma_%.py,%,$@) $@

$(PYFONT_DIR)/Tahoma_Bold_%.py: fonts/ttf/Tahoma_Bold.ttf $(charset)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Tahoma_Bold_%.py,%,$@) $@

$(PYFONT_DIR)/Verdana_%.py: fonts/ttf/Verdana.ttf $(charset)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Verdana_%.py,%,$@) $@

$(PYFONT_DIR)/Verdana_Bold_%.py: fonts/ttf/Verdana_Bold.ttf $(charset)
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Verdana_Bold_%.py,%,$@) $@



$(EXAMPLE_DIR)/%-example.png: $(PYFONT_DIR)/%.py create-font-sample.py
	.venv/bin/python create-font-sample.py $< $@


clean:
	-rm -rf $(PYFONT_DIR)/*
	-rm -rf $(EXAMPLE_DIR)/*
.PHONY: clean



VENVPY_DIR = $(PWD)/.venv
VENVPY_PYTHON3 = $(VENVPY_DIR)/bin/python3
VENVPY_PIP3 = $(VENVPY_DIR)/bin/pip3
VENVPY_PYLINT = $(VENVPY_DIR)/bin/pylint
VENVPY_PYTEST = $(VENVPY_PYTHON3) -m pytest
VENVPY_PYTEST_COV = $(VENVPY_PYTEST) --cov-config=$(PWD)/_coveragerc  --cov-report html:$(PWD)/_build/test/$@ --cov=. 

venvpy: $(VENVPY_DIR)/.done
.PHONY: venvpy

venvpy-uninstall:
	-rm -rf $(VENVPY_DIR)
.PHONY: venvpy-uninstall

$(VENVPY_DIR)/.done: pip-requirements.txt $(VENVPY_PIP3)
	$(VENVPY_PIP3) install -r pip-requirements.txt
	ln -fs $(VENVPY_DIR)/bin/pyserial-miniterm $(VENVPY_DIR)/bin/miniterm
	touch $@

$(VENVPY_PIP3):
	python3 -m venv $(VENVPY_DIR)
