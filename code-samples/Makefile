UNIT_SOURCES:=$(wildcard *.pas)
PROGRAM_SOURCES:=$(wildcard *.lpr) $(wildcard *.dpr)

PROGRAM_UNIX_BINARIES:=$(PROGRAM_SOURCES:.lpr=)
PROGRAM_UNIX_BINARIES:=$(PROGRAM_UNIX_BINARIES:.dpr=)

PROGRAM_WINDOWS_BINARIES:=$(PROGRAM_SOURCES:.lpr=.exe)
PROGRAM_WINDOWS_BINARIES:=$(PROGRAM_WINDOWS_BINARIES:.dpr=.exe)

.PHONY: all
all:
	$(foreach UNIT_NAME,$(UNIT_SOURCES),fpc $(UNIT_NAME) && ) true
	$(foreach PROGRAM_NAME,$(PROGRAM_SOURCES),fpc $(PROGRAM_NAME) && ) true

# Delphi (dcc) command line options.
# See https://github.com/castle-engine/castle-engine/blob/master/tools/build-tool/code/toolcompile.pas#L858
# for how Castle Game Engine build tool invokes dcc for some hints.
# -NS below follows the DPROJ settings generated by Delphi for new projects.
DELPHI_OPTIONS_COMMON:='-NSSystem;Xml;Data;Datasnap;Web;Soap'
DELPHI_WIN32_COMMAND:=dcc32 $(DELPHI_OPTIONS_COMMON)
DELPHI_WIN64_COMMAND:=dcc64 $(DELPHI_OPTIONS_COMMON)

.PHONY: all-delphi-win32
all-delphi-win32:
	$(foreach UNIT_NAME,$(UNIT_SOURCES),$(DELPHI_WIN32_COMMAND) $(UNIT_NAME) && ) true
	$(foreach PROGRAM_NAME,$(PROGRAM_SOURCES),$(DELPHI_WIN32_COMMAND) $(PROGRAM_NAME) && ) true

.PHONY: all-delphi-win64
all-delphi-win64:
	$(foreach UNIT_NAME,$(UNIT_SOURCES),$(DELPHI_WIN64_COMMAND) $(UNIT_NAME) && ) true
	$(foreach PROGRAM_NAME,$(PROGRAM_SOURCES),$(DELPHI_WIN64_COMMAND) $(PROGRAM_NAME) && ) true

.PHONY: clean
clean:
	rm -Rf *.o *.ppu $(PROGRAM_UNIX_BINARIES) $(PROGRAM_WINDOWS_BINARIES)
