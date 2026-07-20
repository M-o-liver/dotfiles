CHEATSHEET.pdf: CHEATSHEET.md
	pandoc CHEATSHEET.md -o CHEATSHEET.pdf \
		-V geometry:margin=1in \
		-V colorlinks=true \
		--metadata title="GNOME Desktop Cheat-Sheet"

.PHONY: clean
clean:
	rm -f CHEATSHEET.pdf
