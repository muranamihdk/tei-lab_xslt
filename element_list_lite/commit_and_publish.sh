cd `dirname $0`
git add .
git commit -m "modified elememt list lite xslt and regenerate html"
git push
cp index.html /Users/earth/Dropbox/TEI/tei-lab/tei-lab.github.io/element_list_lite/
cd /Users/earth/Dropbox/TEI/tei-lab/tei-lab.github.io/element_list_lite
git add .
git commit -m "modified elememt list lite html"
git push