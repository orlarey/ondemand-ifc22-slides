slides.pdf : slides.md examples/*.dsp
	make -C examples
	pandoc --to=beamer --standalone --output=slides.pdf slides.md

clean:
	rm -f slides.pdf
	make -C examples clean
