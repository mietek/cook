.PHONY: all depbuild configure build run clean depclean

all: build

package-file   := $(wildcard *.cabal)
package-name   := $(patsubst %.cabal,%,$(package-file))
sources        := $(shell find src -type f -name '*.hs')
sandbox-dir    := .cabal-sandbox
sandbox-config := cabal.sandbox.config
output         := dist
setup-config   := $(output)/setup-config
executable     := $(output)/build/$(package-name)/$(package-name)

depbuild: $(sandbox-config)
$(sandbox-config): $(package-file)
	cabal sandbox init
	cabal install --dependencies-only

configure: $(setup-config)
$(setup-config): $(package-file) $(sandbox-config)
	cabal configure

build: $(executable)
$(executable): $(package-file) $(sandbox-config) $(setup-config) $(sources)
	cabal build || ( touch -r src $(@D) ; exit 1 )

run: $(executable)
	$(executable) ${ARGS}

clean:
	rm -rf $(output)

depclean:
	rm -rf $(sandbox-dir) $(sandbox-config) $(output)
