all:
	jekyll build
	pandoc -o _site/cscorley_cv.pdf vita.md
	rsync -avz --no-p --no-g --no-t --delete --exclude "x/*" _site/ christop.club:/srv/http

clean:
	rm -rf _site/
