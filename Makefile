SRC = intro.md circuits.md signals.md instructions.md memsignals.md compilation.md examples.md conclusion.md

PDF = $(SRC:.md=.pdf)

slides.pdf : $(SRC) examples/*.dsp prolog.tex title.yaml
	make -C examples
	pandoc --to=beamer --standalone -H prolog.tex --output=slides.pdf -s title.yaml $(SRC)

%.pdf : %.md prolog.tex Makefile title.yaml
	make -C examples
	pandoc --to=beamer --standalone -H prolog.tex --output=$@ -s title.yaml $<

clean:
	rm -f *.pdf
	make -C examples clean
