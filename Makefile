
docs:
	mkdir -p Documentation
	rm -rf Documentation/appledoc
	Libraries/appledoc/appledoc -t Libraries/appledoc/Templates -o Documentation/appledoc -p YelpKit -v 0.1.0 -c "YelpKit" --company-id "com.yelp" --warn-undocumented-object --warn-undocumented-member --warn-empty-description --warn-unknown-directive --warn-invalid-crossref --warn-missing-arg --no-repeat-first-par --keep-intermediate-files --create-html Classes/

gh-pages: docs
	git checkout gh-pages
	cp -R Documentation/appledoc/html/* .
	rm -rf Documentation
	git add .
	git commit -a -m 'Updating docs' && git push origin gh-pages
	git checkout master
