DSP := $(shell find . -name "*.dsp")
SVG	:= $(DSP:%.dsp=%.svg)
PDF	:= $(DSP:%.dsp=%.pdf)



all : $(PDF)

%.pdf : %.svg
	inkscape --export-pdf="$@" "$<"

%.svg : %.dsp
	faust -svg "$(<)" > /dev/null
	mv "$(<:.dsp=-svg)"/process.svg "$@"
	rm -rf "$(<:.dsp=-svg)"

clean :
	rm -f *.svg *.pdf