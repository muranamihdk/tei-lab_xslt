<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format"
xmlns:s="http://www.ascc.net/xml/schematron"
xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
xmlns:html="http://www.w3.org/1999/xhtml"
xmlns:rng="http://relaxng.org/ns/structure/1.0"
xmlns:tei="http://www.tei-c.org/ns/1.0"
xmlns:teix="http://www.tei-c.org/ns/Examples"
xmlns:sch="http://purl.oclc.org/dsdl/schematron"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
exclude-result-prefixes="fo s a tei html rng teix xs sch" version="2.0">
<xsl:output method="text" encoding="utf-8" />
<!--<xsl:text disable-output-escaping = "yes" >&#10;</xsl:text>
<xsl:call-template name="before-key" />
<xsl:call-template name="after-key-before-name" />
<xsl:call-template name="after-name" />
<xsl:call-template name="before-children" />
<xsl:call-template name="after-children" />
<xsl:call-template name="before-child" />
<xsl:call-template name="after-child" />
<xsl:call-template name="before-next-element" />
<xsl:call-template name="after-last-element" />-->


<!-- TEI Lite スキーマ読み込み -->
<xsl:variable name="tei-lite-doc" select="doc('tei_lite.rng')" />
<!-- TEI Lite に含まれる要素だけ出力するか -->
<xsl:variable name="only-tei-lite-elements">false</xsl:variable>
<!-- ガイドラインの章立て順のモジュールリストを作成 -->
<xsl:variable name="modules_list" select="//tei:moduleSpec/@ident" />





<xsl:param name="oddmode">html</xsl:param>

<xsl:key match="tei:elementSpec" name="ELEMENTS" use="@ident"/>
<xsl:key match="tei:elementSpec" name="ELEMENTS" use="tei:altIdent"/>
<xsl:key match="tei:classSpec" name="CLASSES" use="@ident"/>
<xsl:key match="rng:ref" name="REFS"  use="@name"/>
<xsl:key match="tei:elementRef" name="REFS"  use="@key"/>
<xsl:key match="tei:classRef" name="REFS"  use="@key"/>
<xsl:key match="tei:macroRef" name="REFS"  use="@key"/>
<xsl:key match="tei:dataRef" name="REFS"  use="@key"/>
<xsl:key match="rng:ref[contains(@name,'_')]" name="REFS" use="substring-before(@name,'_')"/>

<xsl:key match="tei:elementSpec|tei:classSpec" name="CLASSMEMBERS" use="tei:classes/tei:memberOf/@key"/>
<xsl:key match="tei:elementSpec" name="CLASSMEMBERS-ELEMENTS" use="tei:classes/tei:memberOf/@key"/>
<xsl:key match="tei:classSpec" name="CLASSMEMBERS-CLASSES" use="tei:classes/tei:memberOf/@key"/>
<xsl:key match="tei:elementSpec|tei:classSpec|tei:macroSpec|tei:dataSpec" name="IDENTS" use="concat(@prefix,@ident)"/>

<xsl:variable name="targetLanguage">
      <xsl:text>ja</xsl:text>
</xsl:variable>





<!-- 要素テンプレート -->
<xsl:template name="before-key">
    <xsl:text>    </xsl:text>
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
</xsl:template>

<xsl:template name="after-key-before-name">
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
    <xsl:text>: {</xsl:text>
    <xsl:text disable-output-escaping = "yes">&#10;</xsl:text>
    <xsl:text>        </xsl:text>
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
    <xsl:text>name</xsl:text>
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
    <xsl:text>: </xsl:text>
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
</xsl:template>

<xsl:template name="after-name-before-desc">
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
    <xsl:text>,</xsl:text>
    <xsl:text disable-output-escaping = "yes">&#10;</xsl:text>
    <xsl:text>        </xsl:text>
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
    <xsl:text>desc</xsl:text>
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
    <xsl:text>: </xsl:text>
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
</xsl:template>

<xsl:template name="after-desc">
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
</xsl:template>

<xsl:template name="before-children">
    <xsl:text>,</xsl:text>
    <xsl:text disable-output-escaping = "yes">&#10;</xsl:text>
    <xsl:text>        </xsl:text>
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
    <xsl:text>parents</xsl:text>
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
    <xsl:text>: [</xsl:text>
    <xsl:text disable-output-escaping = "yes">&#10;</xsl:text>
</xsl:template>

<xsl:template name="after-children">
    <xsl:text>            </xsl:text>
    <xsl:text>]</xsl:text>
</xsl:template>

<xsl:template name="before-child">
    <xsl:text>            </xsl:text>
    <xsl:text>{"name": </xsl:text>
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
</xsl:template>

<xsl:template name="after-child">
    <xsl:text disable-output-escaping = "yes">&#34;</xsl:text>
    <xsl:text>},</xsl:text>
    <xsl:text disable-output-escaping = "yes">&#10;</xsl:text>
</xsl:template>

<xsl:template name="before-next-element">
    <xsl:text disable-output-escaping = "yes">&#10;</xsl:text>
    <xsl:text>        </xsl:text>
    <xsl:text>}</xsl:text>
    <xsl:text>,</xsl:text>
    <xsl:text disable-output-escaping = "yes">&#10;</xsl:text>
</xsl:template>

<xsl:template name="after-last-element">
    <xsl:text disable-output-escaping = "yes">&#10;</xsl:text>
    <xsl:text>        </xsl:text>
    <xsl:text>}</xsl:text>
    <xsl:text disable-output-escaping = "yes">&#10;</xsl:text>
</xsl:template>




<!-- JSONルート -->
<xsl:template match="/">
{
    <xsl:apply-templates select="//tei:elementSpec" />
}
</xsl:template>

<!-- elementSpec を選択し TEI Lite によりフィルタ -->
<xsl:template match="tei:elementSpec">
    <xsl:variable name="element_name" select="@ident" />
    <xsl:choose>
        <!-- TEI Lite に含まれる要素だけを処理 -->
        <xsl:when test="$only-tei-lite-elements = 'true'">
            <xsl:if test="$tei-lite-doc/rng:grammar/rng:define/rng:element[@name=$element_name]">
                <xsl:call-template name="generateItem" />
            </xsl:if>
        </xsl:when>
        <!-- すべての要素を処理 -->
        <xsl:otherwise>
            <xsl:call-template name="generateItem" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- JSON の各 Item を生成 -->
<xsl:template name="generateItem">
    <xsl:variable name="description">
        <xsl:choose>
            <xsl:when test="tei:desc[@xml:lang=$targetLanguage]">
                <xsl:value-of select="normalize-space(tei:desc[@xml:lang=$targetLanguage])" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space(tei:desc[@xml:lang='en'])" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="before-key" />
    <xsl:value-of select="@ident"/>
    <xsl:call-template name="after-key-before-name" />
    <xsl:value-of select="@ident"/>
    <xsl:call-template name="after-name-before-desc" />
    <xsl:value-of select="$description"/>
    <xsl:call-template name="after-desc" />
    <xsl:call-template name="before-children" />
    <xsl:call-template name="generateIndirectParents" />
    <xsl:call-template name="after-children" />
    <xsl:call-template name="before-next-element" />
</xsl:template>






  <xsl:template name="generateIndirectParents">
      <xsl:variable name="Parents">
        <xsl:call-template name="ProcessDirectRefs"/>
        <!-- now look at class membership -->
        <xsl:for-each select="tei:classes/tei:memberOf">
          <xsl:for-each select="key('CLASSES', @key)">
            <xsl:if test="@type = 'model'">
              <xsl:call-template name="ProcessClass"/>
            </xsl:if>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:variable>
      <xsl:call-template name="displayElementsByModule">
        <xsl:with-param name="context">parents</xsl:with-param>
        <xsl:with-param name="List">
          <xsl:copy-of select="$Parents"/>
        </xsl:with-param>
      </xsl:call-template>
  </xsl:template>

  <xsl:template name="ProcessDirectRefs">
    <!-- direct parents -->
    <xsl:for-each
      select="key('REFS', concat(@prefix, @ident))/ancestor::tei:content/parent::tei:*">
      <xsl:choose>
        <xsl:when test="self::tei:elementSpec">
          <Element prefix="{@prefix}" type="{local-name()}" module="{@module}"
            name="{tei:createSpecName(.)}"/>
        </xsl:when>
        <xsl:when test="self::tei:macroSpec">
          <xsl:call-template name="ProcessDirectRefs"/>
        </xsl:when>
        <xsl:when test="self::tei:dataSpec">
          <xsl:call-template name="ProcessDirectRefs"/>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="ProcessClass">
    <xsl:for-each
      select="key('REFS', concat(@prefix, @ident))/ancestor::tei:content/parent::tei:*">
      <xsl:choose>
        <xsl:when test="self::tei:elementSpec">
          <Element prefix="{@prefix}" type="{local-name()}" module="{@module}"
            name="{tei:createSpecName(.)}"/>
        </xsl:when>
        <xsl:when test="self::tei:macroSpec | self::tei:dataSpec">
          <xsl:call-template name="ProcessDirectRefs"/>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
    <xsl:for-each select="tei:classes/tei:memberOf">
      <xsl:for-each select="key('CLASSES', @key)">
        <xsl:if test="@type = 'model'">
          <xsl:call-template name="ProcessClass"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  
  
  
  
  
  
<xsl:template name="displayElementsByModule">
    <xsl:param name="context"/>
    <xsl:param name="List"/>
    <xsl:variable name="here" select="."/>
    <xsl:for-each select="$List">
    <xsl:text disable-output-escaping = "yes" >&#10;</xsl:text>
        <xsl:choose>
            <xsl:when test="$context = 'parents' and count(Element) = 0">
                <xsl:text>—</xsl:text>
            </xsl:when>
            <xsl:when test="Element[@type = 'TEXT'] and count(Element) = 1">
                <xsl:call-template name="before-child" />
                <xsl:text>Character data only</xsl:text>
                <xsl:call-template name="after-child" />
            </xsl:when>
            <xsl:when test="count(Element) = 0">
                <xsl:call-template name="before-child" />
                <xsl:text>Empty element</xsl:text>
                <xsl:call-template name="after-child" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each-group select="*" group-by="@module">
                    <xsl:sort select="@module_order"/>
                    <xsl:choose>
                        <xsl:when test="@type='TEXT'">
                            <xsl:call-template name="before-child" />
                            <xsl:text>character data</xsl:text>
                            <xsl:call-template name="after-child" />
                        </xsl:when>
                        <xsl:when test="@type='ANYXML'">
                            <xsl:for-each select="$here">
                                <xsl:call-template name="before-child" />
                                <xsl:call-template name="linkTogether">
                                    <xsl:with-param name="name">macro.anyXML</xsl:with-param>
                                    <xsl:with-param name="class">link_odd</xsl:with-param>
                                </xsl:call-template>
                                <xsl:call-template name="after-child" />
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <!--<xsl:if test="string-length(current-grouping-key()) > 0">
                                <xsl:value-of select="current-grouping-key()"/>
                                <xsl:text>: </xsl:text>
                            </xsl:if>-->
                            <xsl:for-each-group select="current-group()" group-by="@name">
                                <!--<xsl:sort select="@name"/>-->
                                <xsl:variable name="me" select="concat(@prefix, @name)"/>
                                <xsl:variable name="element_name" select="@name"/>
                                <xsl:variable name="type" select="@type"/>
                                <!-- TEI Lite による選択 -->
                                <xsl:choose>
                                    <!-- TEI Lite に含まれる要素だけ処理 -->
                                    <xsl:when test="$only-tei-lite-elements">
                                        <xsl:if test="$tei-lite-doc/rng:grammar/rng:define/rng:element[@name=$element_name]">
                                            <xsl:for-each select="$here">
                                                <xsl:call-template name="before-child" />
                                                <xsl:call-template name="linkTogether">
                                                    <xsl:with-param name="name" select="$me"/>
                                                    <xsl:with-param name="reftext" select="$element_name"/>
                                                    <xsl:with-param name="class">
                                                        link_odd_<xsl:value-of select="$type"/>
                                                    </xsl:with-param>
                                                </xsl:call-template>
                                                <xsl:call-template name="after-child" />
                                            </xsl:for-each>
                                            <xsl:if test="not(position() = last())">
                                                <xsl:call-template name="showSpaceBetweenItems"/>
                                            </xsl:if>
                                        </xsl:if>
                                    </xsl:when>
                                    <!-- すべての要素を処理 -->
                                    <xsl:otherwise>
                                        <xsl:for-each select="$here">
                                            <xsl:call-template name="before-child" />
                                            <xsl:call-template name="linkTogether">
                                                <xsl:with-param name="name" select="$me"/>
                                                <xsl:with-param name="reftext" select="$element_name"/>
                                                <xsl:with-param name="class">
                                                    link_odd_<xsl:value-of select="$type"/>
                                                </xsl:with-param>
                                            </xsl:call-template>
                                            <xsl:call-template name="after-child" />
                                        </xsl:for-each>
                                        <xsl:if test="not(position() = last())">
                                            <xsl:call-template name="showSpaceBetweenItems"/>
                                        </xsl:if>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each-group>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each-group>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
</xsl:template>





<xsl:template name="followRef">
  <xsl:if test=".//rng:text or .//rng:data or .//tei:textNode">
    <Element prefix="{@prefix}" type="TEXT" module="~TEXT"/>
  </xsl:if>
  <xsl:for-each
    select=".//rng:ref | .//tei:elementRef | .//tei:classRef | .//tei:macroRef | .//tei:dataRef">
    <xsl:if
      test="not(starts-with(@name, 'any') or starts-with(@name, 'macro.any') or starts-with(@key, 'macro.any') or @name = 'AnyThing')">
      <xsl:variable name="Name"
        select="replace(@name | @key, '_(alternation|sequenceOptionalRepeatable|sequenceOptional|sequenceRepeatable|sequence)', '')"/>
      <xsl:variable name="except" select="@except"/>
      <xsl:variable name="include" select="@include"/>
      <xsl:for-each select="key('IDENTS', $Name)">
        <xsl:choose>
          <xsl:when test="self::tei:elementSpec">
              <xsl:variable name="module-order">
                <xsl:choose>
                    <xsl:when test="@module='tei'">a</xsl:when>
                    <xsl:when test="@module='header'">b</xsl:when>
                    <xsl:when test="@module='core'">c</xsl:when>
                    <xsl:when test="@module='textstructure'">d</xsl:when>
                    <xsl:when test="@module='gaiji'">e</xsl:when>
                    <xsl:when test="@module='verse'">f</xsl:when>
                    <xsl:when test="@module='drama'">g</xsl:when>
                    <xsl:when test="@module='spoken'">h</xsl:when>
                    <xsl:when test="@module='dictionaries'">i</xsl:when>
                    <xsl:when test="@module='msdescription'">j</xsl:when>
                    <xsl:when test="@module='transcr'">k</xsl:when>
                    <xsl:when test="@module='textcrit'">l</xsl:when>
                    <xsl:when test="@module='namesdates'">m</xsl:when>
                    <xsl:when test="@module='figures'">n</xsl:when>
                    <xsl:when test="@module='corpus'">o</xsl:when>
                    <xsl:when test="@module='linking'">p</xsl:when>
                    <xsl:when test="@module='analysis'">q</xsl:when>
                    <xsl:when test="@module='iso-fs'">r</xsl:when>
                    <xsl:when test="@module='nets'">s</xsl:when>
                    <xsl:when test="@module='certainty'">t</xsl:when>
                    <xsl:when test="@module='tagdocs'">u</xsl:when>
                  </xsl:choose>
              </xsl:variable>
            <Element prefix="{@prefix}" module="{@module}" module_order="{$module-order}"
              type="{local-name()}" name="{tei:createSpecName(.)}"/>
          </xsl:when>
          <xsl:when test="self::tei:macroSpec">
            <xsl:for-each select="tei:content">
              <xsl:choose>
                <xsl:when test="(rng:text or rng:data) and count(rng:*) = 1">
                  <Element prefix="{@prefix}" type="TEXT" module="~TEXT"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:call-template name="followRef"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="self::tei:dataSpec">
            <xsl:for-each select="tei:content">
              <xsl:choose>
                <xsl:when test="(rng:text or rng:data) and count(rng:*) = 1">
                  <Element prefix="{@prefix}" type="TEXT" module="~TEXT"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:call-template name="followRef"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="self::tei:classSpec">
            <xsl:call-template name="followMembers">
              <xsl:with-param name="include" select="$include"/>
              <xsl:with-param name="except" select="$except"/>
            </xsl:call-template>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="@key = 'macro.anyXML'">
      <Element type="ANYXML" module="~anyXML"/>
    </xsl:if>
  </xsl:for-each>
</xsl:template>





<xsl:template name="followMembers">
  <xsl:param name="include"/>
  <xsl:param name="except"/>
  <xsl:for-each select="key('CLASSMEMBERS', @ident)">
    <xsl:choose>
      <xsl:when test="self::tei:elementSpec">
        <xsl:if test="tei:includeMember(@ident, $except, $include)">
              <xsl:variable name="module-order">
                <xsl:choose>
                    <xsl:when test="@module='tei'">a</xsl:when>
                    <xsl:when test="@module='header'">b</xsl:when>
                    <xsl:when test="@module='core'">c</xsl:when>
                    <xsl:when test="@module='textstructure'">d</xsl:when>
                    <xsl:when test="@module='gaiji'">e</xsl:when>
                    <xsl:when test="@module='verse'">f</xsl:when>
                    <xsl:when test="@module='drama'">g</xsl:when>
                    <xsl:when test="@module='spoken'">h</xsl:when>
                    <xsl:when test="@module='dictionaries'">i</xsl:when>
                    <xsl:when test="@module='msdescription'">j</xsl:when>
                    <xsl:when test="@module='transcr'">k</xsl:when>
                    <xsl:when test="@module='textcrit'">l</xsl:when>
                    <xsl:when test="@module='namesdates'">m</xsl:when>
                    <xsl:when test="@module='figures'">n</xsl:when>
                    <xsl:when test="@module='corpus'">o</xsl:when>
                    <xsl:when test="@module='linking'">p</xsl:when>
                    <xsl:when test="@module='analysis'">q</xsl:when>
                    <xsl:when test="@module='iso-fs'">r</xsl:when>
                    <xsl:when test="@module='nets'">s</xsl:when>
                    <xsl:when test="@module='certainty'">t</xsl:when>
                    <xsl:when test="@module='tagdocs'">u</xsl:when>
                  </xsl:choose>
              </xsl:variable>
          <Element prefix="{@prefix}" module="{@module}"  module_order="{$module-order}" type="{local-name()}"
            name="{tei:createSpecName(.)}"/>
        </xsl:if>
      </xsl:when>
      <xsl:when test="self::tei:classSpec">
        <xsl:call-template name="followMembers">
          <xsl:with-param name="include" select="$include"/>
          <xsl:with-param name="except" select="$except"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>





<xsl:template name="showSpaceBetweenItems">
  <xsl:text> </xsl:text>
</xsl:template>





<xsl:template name="linkTogether">
  <xsl:param name="name"/>
  <xsl:param name="reftext"/>
  <xsl:param name="class">link_odd</xsl:param>
  <xsl:variable name="partialname">
    <xsl:value-of select="replace($name,'_(alternation|sequenceOptionalRepeatable|sequenceOptional|sequenceRepeatable|sequence)','')"/>
  </xsl:variable>
  <xsl:variable name="link">
    <xsl:choose>
      <xsl:when test="$reftext=''">
        <xsl:value-of select="$name"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$reftext"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="glossAndDesc">
    <xsl:choose>
      <xsl:when test="starts-with( $partialname, 'model.')">
        <xsl:apply-templates select="key('CLASSES', $partialname)" mode="glossDesc"/>
      </xsl:when>
      <xsl:when test="starts-with( $partialname, 'att.')">
        <xsl:apply-templates select="key('CLASSES', replace( $partialname, '\.attributes$',''))" mode="glossDesc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="key('ELEMENTS', $partialname )" mode="glossDesc"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="not(key('IDENTS',$partialname))">
      <xsl:value-of select="$link"/>
    </xsl:when>
    <xsl:when test="$oddmode='html'">
      <!--<a title="{$glossAndDesc}"
        href="{concat('ref-',$partialname,'.html')}"
        module="{@module}">-->
        <xsl:value-of select="$link"/>
      <!--</a>-->
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$link"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>





<xsl:template name="getSpecURL">
  <xsl:param name="name"/>
  <xsl:param name="type"/>
  <xsl:choose>
    <xsl:when test="$type='macro'">
      <xsl:for-each select="id('REFENT')">
        <xsl:apply-templates mode="generateLink" select="."/>
      </xsl:for-each>
    </xsl:when>
    <xsl:when test="$type='element'">
      <xsl:for-each select="id('REFTAG')">
        <xsl:apply-templates mode="generateLink" select="."/>
      </xsl:for-each>
    </xsl:when>
    <xsl:when test="$type='class'">
      <xsl:for-each select="id('REFCLA')">
        <xsl:apply-templates mode="generateLink" select="."/>
      </xsl:for-each>
    </xsl:when>
  </xsl:choose>
  <xsl:text>#</xsl:text>
  <xsl:value-of select="$name"/>
</xsl:template>





<xsl:function name="tei:includeMember" as="xs:boolean">
  <xsl:param name="ident"  as="xs:string"/>
  <xsl:param name="exc" />
  <xsl:param name="inc" />
    <xsl:choose>
	<xsl:when test="not($exc) and not($inc)">true</xsl:when>
	<xsl:when test="$inc and $ident cast as xs:string  = tokenize($inc, ' ')">true</xsl:when>
	<xsl:when test="$inc">false</xsl:when>
	<xsl:when test="$exc and $ident cast as xs:string = tokenize($exc, ' ')">false</xsl:when>
	<xsl:otherwise>true</xsl:otherwise>
    </xsl:choose>
</xsl:function>





  <xsl:function name="tei:createSpecName" as="xs:string">
    <xsl:param name="context"/>
    <xsl:for-each select="$context">
      <xsl:value-of select="if (tei:altIdent) then
                            normalize-space(tei:altIdent) else @ident"/>
    </xsl:for-each>
  </xsl:function>





  <xsl:template match="tei:elementSpec|tei:classSpec" mode="glossDesc">
    <!-- We should probably be more careful about the possibility -->
    <!-- of sub-languages (e.g., having descriptions in both 'en-US' and -->
    <!-- 'en-UK'). However, as of now there are no cases of any sublanguages -->
    <!-- that would cause a problem here. -->
    <xsl:variable name="generatedTitleAttrVal">
      <xsl:if test="tei:gloss[ lang( $targetLanguage ) ]">
        <xsl:text>(</xsl:text>
        <xsl:apply-templates select="tei:gloss[ lang( $targetLanguage ) ]" mode="glossDescTitle"/>
        <xsl:text>) </xsl:text>
      </xsl:if>
      <xsl:apply-templates select="tei:desc[ lang( $targetLanguage ) ]" mode="glossDescTitle"/>
    </xsl:variable>
    <xsl:value-of select="normalize-space($generatedTitleAttrVal)"/>
  </xsl:template>





  <!-- process <gloss> and <desc> to make title= attribute values -->
  <xsl:template match="tei:gloss" mode="glossDescTitle">
    <!-- At the moment the only descendants of a <gloss> that appears in <elementSpec> or <classSpec> -->
    <!-- are 3 <gloss> and 1 <ident>, so we can get away with just taking the value, rather than -->
    <!-- applying templates. -->
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>
  <xsl:template match="tei:desc" mode="glossDescTitle">
    <!-- 
         	 As of 2014-08-12, revision 12970, the only descendants of a
	 <desc> that appears in an <elementSpec> or a <classSpec> are:
           329 gi
            79 term
            68 att
            11 soCalled
             6 mentioned
             5 ident
             2 q
             2 val
             1 foreign
             1 ref
             1 title
         You might think that from here we can just <apply-templates>
         and be done with it. But if we do that, we end up with an infinite-
	 loop of called templates problem. To wit, inside the <desc> we are
	 processing there are (e.g.) <gi> elements. They get caught by a
	 template in html/html_oddprocessing.xsl, which goes about calling
	 linkTogether, which goes about applying templates (in mode glossDesc)
	 to the <elementSpec> that defines the element mentioned in the content
	 of the <gi>. That, in turn, would apply templates to the <desc> that
	 we started with.
    -->
    <xsl:apply-templates mode="#current"/>
  </xsl:template>
  <xsl:template match="tei:gi" mode="glossDescTitle">
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>></xsl:text>
  </xsl:template>
  <xsl:template match="tei:att" mode="glossDescTitle">
    <xsl:text>@</xsl:text>
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>
  <xsl:template match="tei:term|tei:ref|tei:ident|tei:code|tei:foreign" mode="glossDescTitle">
    <xsl:value-of select="."/>
  </xsl:template>
  <xsl:template match="tei:mentioned|tei:q" mode="glossDescTitle">
    <xsl:text>“</xsl:text>
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>”</xsl:text>
  </xsl:template>
  <xsl:template match="tei:val" mode="glossDescTitle">
    <xsl:text>"</xsl:text>
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>"</xsl:text>
  </xsl:template>
  <xsl:template match="tei:soCalled" mode="glossDescTitle">
    <xsl:text>‘</xsl:text>
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>’</xsl:text>
  </xsl:template>
  <xsl:template match="tei:title" mode="glossDescTitle">
    <xsl:text>_</xsl:text>
    <xsl:value-of select="translate( normalize-space(.), ' ', '_' )"/>
    <xsl:text>_</xsl:text>
  </xsl:template>
  





</xsl:stylesheet>
