all: build

build:
	jekyll build
	pandoc -o cscorley_cv.pdf vita.md
	libreoffice --convert-to pdf cscorley_resume.odt

clean:
	rm -rf _site/
