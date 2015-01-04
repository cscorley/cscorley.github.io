all:
	jekyll build
	pandoc -o _site/cscorley_cv.pdf vita.md
	rsync -avz --no-p --no-g --no-t --delete _site/ christop.club:/srv/http
