all: build

build:
	jekyll build
	pandoc -o _site/cscorley_cv.pdf vita.md

deploy: build
	rsync -avz --no-p --no-g --no-t _site/ christop.club:/srv/http

clean:
	rm -rf _site/
