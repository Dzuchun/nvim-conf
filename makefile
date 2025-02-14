BIN_DIR = $(HOME)/.local/bin
CONFIG_DIR = $(XDG_CONFIG_HOME)/ndzu

BIN_FILES = ndzu
install_bin:
	@for fname in $(BIN_FILES); do \
		cp ./bin/$$fname $(BIN_DIR)/$$fname; \
    done
	@$(foreach fname,$(BIN_FILES),cp -v ./bin/$(fname) $(BIN_DIR);)

remove_bin:
	@if [ -z $(BIN_DIR) ]; then \
		echo "Bin dir not set"; \
		exit 1; \
	fi
	@$(foreach fname,$(BIN_FILES),rm -vf $(BIN_DIR)/$(fname);)

nvim/spell/uk.utf-8.spl:
	@wget https://ftp.nluug.nl/pub/vim/runtime/spell/uk.utf-8.spl
	@mv uk.utf-8.spl nvim/spell

CONFIG_FILES = $(shell cd nvim; find -name "*.lua") spell/uk.utf-8.spl
CONFIG_FILES_FILE = $(CONFIG_DIR)/config_files
install_cfg: remove_cfg nvim/spell/uk.utf-8.spl
	@mkdir -p $(CONFIG_DIR)
	@cd nvim; $(foreach fname,$(CONFIG_FILES),cp --parent -vr $(fname) $(CONFIG_DIR);)
	@touch $(CONFIG_FILES_FILE)
	@$(foreach fname,$(CONFIG_FILES),echo $(fname) >> $(CONFIG_FILES_FILE);)

remove_cfg:
	@if [ -z $(CONFIG_DIR) ]; then \
		echo "Config dir not set"; \
		exit 1; \
	fi
	@if [ -f $(CONFIG_FILES_FILE) ]; then \
		$(foreach fname,$(shell cat $(CONFIG_FILES_FILE)),rm -v $(CONFIG_DIR)/$(fname);) \
		rm $(CONFIG_FILES_FILE); \
	fi

install: install_bin install_cfg

remove: remove_bin remove_cfg
