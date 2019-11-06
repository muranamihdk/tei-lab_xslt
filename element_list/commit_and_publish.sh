cd `dirname $0`
git add .
git commit -m "modified elememt list xslt and regenerate html"
git push
cp index.html /Users/earth/Dropbox/TEI/tei-lab/tei-lab.github.io/element_list/
cd /Users/earth/Dropbox/TEI/tei-lab/tei-lab.github.io/element_list
git add .
git commit -m "modified elememt list html"
git push