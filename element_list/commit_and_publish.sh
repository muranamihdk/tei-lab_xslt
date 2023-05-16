cd `dirname $0`
git add .
git commit -m "modified elements list xslt and regenerate html"
git push
cp index.html /Users/earth/Dropbox/TEI/repository/muranamihdk/tei-elements-list/
cd /Users/earth/Dropbox/TEI/repository/muranamihdk/tei-elements-list
git add .
git commit -m "modified elements list html"
git push