ifeq (, $(shell which keg))
	EMACS	= emacs
else
	EMACS	= keg emacs
endif
EL		?= text-adjust.el
ELC		= $(EL:%.el=%.elc)
ELFLAGS = -q -Q -no-site-file -batch

all: $(ELC)
%.elc: %.el
	$(EMACS) $(ELFLAGS) -L . -f batch-byte-compile $<

# clean up
clean:
	-rm -f $(ELC)

distclean: clean

maintainer-clean: clean

test: run-test
run-test: $(ELC)
	$(EMACS) $(ELFLAGS) -L . -l test/run-test.el

# cl: git2cl
# git2cl:
# 	@git log --date=short --pretty=format:"%ad  %an  <%ae>%n%n* %s%n%b%n" | \
# 	sed -e 's/^\(.*\)$$/\t\1/g' | \
# 	sed -e 's/^\t\([0-9]*-[0-9]*-[0-9]*.*\)$$/\1/g' | \
# 	sed -e 's/^\t$$//g' | \
# 	sed ':loop; N; $$!b loop; s/\n\n\n/\n\n/g' \
# 	> ChangeLog
# # create tar.gz
# release:
# 	@git archive --format=tar --prefix=rail-$(RAILVER)/ HEAD \
# 	  | gzip -9 > ../rail-$(RAILVER).tar.gz
