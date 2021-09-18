all: pdf site

pdf:
	pandoc -o cscorley_cv.pdf vita.md
	libreoffice --convert-to pdf cscorley_resume.odt

site:
	jekyll build

clean:
	rm -rf _site/
