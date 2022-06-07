PYFONT_DIR = pyfonts
EXAMPLE_DIR = examples

FONT_TO_PY_DIR = ../micropython-font-to-py
FONT_TO_PY = .venv/bin/python $(FONT_TO_PY_DIR)/font_to_py.py --iterate


varfont_sizes += 10
varfont_sizes += 12
varfont_sizes += 16
varfont_sizes += 20
varfont_sizes += 24
varfont_sizes += 32
varfont_sizes += 40

varfonts += DejaVuSans
varfonts += DejaVuSans_Bold
varfonts += Tahoma
varfonts += Tahoma_Bold
varfonts += Verdana
varfonts += Verdana_Bold

all_varfonts = $(foreach font,$(varfonts),$(foreach size,$(varfont_sizes),$(font)_$(size)))
all_var_pyfont_files = $(foreach font,$(all_varfonts),$(PYFONT_DIR)/$(font).py)

all_pyfont_files += $(all_var_pyfont_files) $(all_fixed_pyfont_files)
all_pyfont_examples = $(foreach pyfont,$(all_pyfont_files),$(patsubst $(PYFONT_DIR)/%.py,$(EXAMPLE_DIR)/%-example.png,$(pyfont)))

pyfont-examples:

pyfonts: venvpy $(all_pyfont_files)
	@echo $(all_pyfont_files)
.PHONY: pyfonts

pyfont-examples: venvpy $(all_pyfont_examples)
	@echo $(all_pyfont_examples)
.PHONY: pyfont-examples


.py: .ttf
	mkdir -p $(PYFONT_DIR)

.png: .py
	mkdir -p $(EXAMPLE_DIR)


$(PYFONT_DIR)/DejaVuSans_%.py: fonts/ttf/DejaVuSans.ttf charsets/iso-8859-15+specials.charset
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/DejaVuSans_%.py,%,$@) $@

$(PYFONT_DIR)/DejaVuSans_Bold_%.py: fonts/ttf/DejaVuSans-Bold.ttf charsets/iso-8859-15+specials.charset
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/DejaVuSans_Bold_%.py,%,$@) $@

$(PYFONT_DIR)/Tahoma_%.py: fonts/ttf/Tahoma.ttf charsets/iso-8859-15+specials.charset
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Tahoma_%.py,%,$@) $@

$(PYFONT_DIR)/Tahoma_Bold_%.py: fonts/ttf/Tahoma_Bold.ttf charsets/iso-8859-15+specials.charset
	echo here
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Tahoma_Bold_%.py,%,$@) $@

$(PYFONT_DIR)/Verdana_%.py: fonts/ttf/Verdana.ttf charsets/iso-8859-15+specials.charset
	$(FONT_TO_PY) -k $(filter %.charset,$^) $< $(patsubst $(PYFONT_DIR)/Verdana_%.py,%,$@) $@

$(PYFONT_DIR)/Verdana_Bold_%.py: fonts/ttf/Verdana_Bold.ttf charsets/iso-8859-15+specials.charset
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
