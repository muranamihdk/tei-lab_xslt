cd `dirname $0`
#saxon -s:../TEI/P5/p5.xml -xsl:elements.xsl -o:index.html  # for OS X Saxon
#saxon-xslt -o index.html ../TEI/P5/p5.xml elements.xsl # for CentOS Saxon
/usr/local/bin/saxon -s:../TEI/P5/p5.xml -xsl:elements.xsl -o:index.html  # for TEIC Docker Saxon
#xsltproc elements.xsl ../TEI/P5/p5.xml