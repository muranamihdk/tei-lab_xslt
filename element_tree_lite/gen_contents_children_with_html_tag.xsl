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
<xsl:output method="html" encoding="utf-8" />
<!--<xsl:text disable-output-escaping = "yes" >&#10;</xsl:text>-->

<!-- TEI Lite スキーマ読み込み -->
<xsl:variable name="tei-lite-doc" select="doc('./tei_lite.rng')" />





  <xsl:param name="langAttributeName">lang</xsl:param>
  <xsl:param name="documentationLanguage">ja</xsl:param>





  <xsl:param name="STDOUT">true</xsl:param>
  <xsl:param name="TEIC">false</xsl:param>
  <xsl:param name="autoGlobal">false</xsl:param>
  <xsl:param name="configDirectory"/>
  <xsl:param name="currentDirectory"/>
  <xsl:param name="defaultSource"></xsl:param>
  <xsl:param name="defaultTEIServer">http://www.tei-c.org/Vault/P5/</xsl:param>
  <xsl:param name="defaultTEIVersion">current</xsl:param>
  <xsl:param name="idPrefix"/>
  <xsl:param name="lang"/>
  <xsl:param name="localsource"/>
  <xsl:param name="lookupDatabase">false</xsl:param>
  <xsl:param name="outputDir"/>
  <xsl:param name="outputSuffix">.html</xsl:param>
  <xsl:param name="patternPrefix"/>
  <xsl:param name="outputEncoding">utf-8</xsl:param>
  <xsl:param name="schemaBaseURL">http://localhost/schema/relaxng/</xsl:param>
  <xsl:param name="splitLevel">-1</xsl:param>
  <xsl:param name="verbose">false</xsl:param>
  <!-- Not sure whether this should be specified here or in odd2relax.xsl, or, -->
  <!-- for that matter, whether we really want it at all. It is the max # of   -->
  <!-- clauses of RELAX NG we'll generate in response to @maxOccurs (more than -->
  <!-- this, just allow "unbounded", and insert an annotation saying so). —Syd -->
  <xsl:param name="maxint" select="400"/>
  




  <xsl:param name="oddmode">html</xsl:param>
  <xsl:param name="xrefName">a</xsl:param>
  <xsl:param name="urlName">href</xsl:param>
  <xsl:param name="ulName">ul</xsl:param>
  <xsl:param name="dlName">dl</xsl:param>
  <xsl:param name="codeName">span</xsl:param>
  <xsl:param name="colspan">colspan</xsl:param>
  <xsl:param name="ddName">dd</xsl:param>
  <xsl:param name="dtName">dt</xsl:param>
  <xsl:param name="hiName">span</xsl:param>
  <xsl:param name="itemName">li</xsl:param>
  <xsl:param name="labelName">dt</xsl:param>
  <xsl:param name="rendName">class</xsl:param>
  <xsl:param name="rowName">tr</xsl:param>
  <xsl:param name="tableName">table</xsl:param>
  <xsl:param name="cellName">td</xsl:param>
  <xsl:param name="divName">div</xsl:param>
  <xsl:param name="sectionName">div</xsl:param>
  <xsl:param name="segName">span</xsl:param>
  <xsl:param name="outputNS">http://www.w3.org/1999/xhtml</xsl:param>
  <xsl:key name="MODEL-CLASS-MODULE" match="tei:classSpec[@type='model']" use="@module"/>
  <xsl:key name="ATT-CLASS-MODULE" match="tei:classSpec[@type='atts']" use="@module"/>
  <xsl:key name="ELEMENT-MODULE" match="tei:elementSpec" use="@module"/>
  <xsl:key name="MACRO-MODULE" match="tei:macroSpec" use="@module"/>
  <xsl:key name="MACRO-MODULE" match="tei:dataSpec" use="@module"/>
  <xsl:key name="ELEMENT-ALPHA" match="tei:elementSpec" use="substring(translate(@ident,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),1,1)"/>
  <xsl:key name="MODEL-CLASS-ALPHA" match="tei:classSpec[@type='model']" use="substring(translate(@ident,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),7,1)"/>
  <xsl:key name="ATT-CLASS-ALPHA" match="tei:classSpec[@type='atts']" use="substring(translate(@ident,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),5,1)"/>
  <xsl:key match="tei:moduleSpec[@ident]" name="FILES" use="@ident"/>
  <xsl:variable name="top" select="/"/>





  <xsl:key match="tei:elementSpec|tei:classSpec|tei:macroSpec|tei:dataSpec" name="LOCALIDENTS" use="@ident"/>
  <xsl:key match="tei:dataSpec|tei:macroSpec" name="MACROS" use="@ident"/>
  <xsl:key match="tei:elementSpec" name="ELEMENTS" use="@ident"/>
  <xsl:key match="tei:elementSpec" name="ELEMENTS" use="tei:altIdent"/>
  <xsl:key match="tei:classSpec" name="CLASSES" use="@ident"/>
  <xsl:key match="rng:ref" name="REFS"  use="@name"/>
  <xsl:key match="tei:elementRef" name="REFS"  use="@key"/>
  <xsl:key match="tei:classRef" name="REFS"  use="@key"/>
  <xsl:key match="tei:macroRef" name="REFS"  use="@key"/>
  <xsl:key match="tei:dataRef" name="REFS"  use="@key"/>
  <xsl:key match="rng:ref[contains(@name,'_')]" name="REFS" use="substring-before(@name,'_')"/>

  <xsl:key
      match="tei:elementSpec/tei:attList//tei:attDef/tei:datatype/rng:ref"
      name="REFSTO-ELEMENT" 
      use="@name"/>
  <xsl:key
    match="tei:elementSpec/tei:attList//tei:attDef/tei:datatype/tei:dataRef"
    name="REFSTO-ELEMENT" 
    use="@key"/>
  <xsl:key 
      match="tei:classSpec/tei:attList//tei:attDef/tei:datatype/rng:ref" 
      name="REFSTO-CLASS" 
      use="@name"/>
  <xsl:key 
    match="tei:classSpec/tei:attList//tei:attDef/tei:datatype/tei:dataRef" 
    name="REFSTO-CLASS" 
    use="@key"/>

  <xsl:key match="tei:macroSpec/tei:content//rng:ref" name="MACROREFS"  use="@name"/>
  <xsl:key match="tei:macroSpec/tei:content//tei:macroRef" name="MACROREFS"  use="@key"/>
  <xsl:key match="tei:dataSpec/tei:content//tei:dataRef" name="MACROREFS"  use="@key"/>

  <xsl:key match="tei:elementSpec|tei:classSpec" name="CLASSMEMBERS" use="tei:classes/tei:memberOf/@key"/>
  <xsl:key match="tei:elementSpec" name="CLASSMEMBERS-ELEMENTS" use="tei:classes/tei:memberOf/@key"/>
  <xsl:key match="tei:classSpec" name="CLASSMEMBERS-CLASSES" use="tei:classes/tei:memberOf/@key"/>
  <xsl:key match="tei:elementSpec|tei:classSpec|tei:macroSpec|tei:dataSpec" name="IDENTS" use="concat(@prefix,@ident)"/>

  <xsl:key match="tei:macroSpec|tei:dataSpec" name="MACRODOCS" use="1"/>
  <xsl:key match="tei:attDef" name="ATTDOCS" use="1"/>
  <xsl:key match="tei:attDef" name="ATTRIBUTES" use="@ident"/>
  <xsl:key match="tei:classSpec//tei:attDef" name="ATTRIBUTES-CLASS" use="@ident"/>
  <xsl:key match="tei:elementSpec//tei:attDef" name="ATTRIBUTES-ELEMENT" use="@ident"/>
  <xsl:key match="tei:classSpec[@type='atts']" name="ATTCLASSDOCS" use="1"/>
  <xsl:key match="tei:classSpec[@type='model']" name="MODELCLASSDOCS" use="1"/>
  <xsl:key match="tei:elementSpec" name="ELEMENTDOCS" use="1"/>
  <xsl:key match="tei:elementSpec" name="ElementModule" use="@module"/>
  <xsl:key match="tei:classSpec" name="ClassModule" use="@module"/>
  <xsl:key match="tei:macroSpec" name="MacroModule" use="@module"/>
  <xsl:key match="tei:dataSpec" name="MacroModule" use="@module"/>
  <xsl:key match="tei:dataSpec" name="DataMacroModule" use="@module"/>
  <xsl:key match="tei:moduleSpec" name="Modules" use="1"/>
  <xsl:key match="tei:moduleSpec" name="MODULES" use="@ident"/>
  <xsl:key match="tei:classSpec[@predeclare='true']" name="predeclaredClasses" use="1"/>
  <xsl:key match="tei:macroSpec[@predeclare='true']" name="PredeclareMacros" use="@ident"/>
  <xsl:key match="tei:macroSpec[@predeclare='true']" name="PredeclareMacrosModule" use="@module"/>
  <xsl:key match="tei:macroSpec[@predeclare='true']" name="PredeclareAllMacros" use="1"/>





  <xsl:key name="CHILDMOD" match="Element" use="@module"/>
  <xsl:variable name="Original" select="/"/>
  <xsl:param name="teiWeb">
    <xsl:text>http://www.tei-c.org/release/doc/tei-p5-doc/</xsl:text>
  </xsl:param>





  <xsl:template match="/">
      <xsl:apply-templates select="//tei:elementSpec" mode="genChildren" />
  </xsl:template>

  <xsl:template match="tei:elementSpec" mode="genChildren" >
  <!-- TEI Lite に含まれるか -->
    <xsl:variable name="element_name" select="@ident" />
    <xsl:if test="$tei-lite-doc/rng:grammar/rng:define/rng:element[@name=$element_name]">
      <xsl:call-template name="generateChildren" />
    </xsl:if>
  </xsl:template>

  <xsl:template name="generateChildren">
    <xsl:variable name="name" select="concat(@prefix, @ident)"/>
    <xsl:choose>
      <xsl:when test="tei:content//rng:ref[@name = 'macro.anyXML']">
        <xsl:element namespace="{$outputNS}" name="{$segName}">
          <xsl:attribute name="{$langAttributeName}">
            <xsl:value-of select="$documentationLanguage"/>
          </xsl:attribute>
          <xsl:text>ANY</xsl:text>
        </xsl:element>
      </xsl:when>
      <xsl:when test="tei:content/tei:textNode and count(tei:content/*) = 1">
        <xsl:element namespace="{$outputNS}" name="{$segName}">
          <xsl:attribute name="{$langAttributeName}">
            <xsl:value-of select="$documentationLanguage"/>
          </xsl:attribute>
          <xsl:text>Character data only</xsl:text>
        </xsl:element>
      </xsl:when>
      <xsl:when test="tei:content/rng:text and count(tei:content/rng:*) = 1">
        <xsl:element namespace="{$outputNS}" name="{$segName}">
          <xsl:attribute name="{$langAttributeName}">
            <xsl:value-of select="$documentationLanguage"/>
          </xsl:attribute>
          <xsl:text>Character data only</xsl:text>
        </xsl:element>
      </xsl:when>
      <xsl:when test="tei:content/rng:empty">
        <xsl:element namespace="{$outputNS}" name="{$segName}">
          <xsl:attribute name="{$langAttributeName}">
            <xsl:value-of select="$documentationLanguage"/>
          </xsl:attribute>
          <xsl:text>Empty element</xsl:text>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="Children">
          <xsl:for-each select="tei:content">
            <xsl:call-template name="followRef"/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:call-template name="displayElementsByModule">
          <xsl:with-param name="context">children</xsl:with-param>
          <xsl:with-param name="List">
            <xsl:copy-of select="$Children"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>





  <xsl:template name="displayElementsByModule">
    <xsl:param name="List"/>
    <xsl:param name="context"/>
    <xsl:variable name="here" select="."/>
    <xsl:for-each select="$List">
      <xsl:choose>
        <xsl:when test="$context = 'parents' and count(Element) = 0">
          <xsl:text>—</xsl:text>
        </xsl:when>
        <xsl:when test="Element[@type = 'TEXT'] and count(Element) = 1">
          <xsl:element namespace="{$outputNS}" name="{$segName}">
            <xsl:attribute name="{$langAttributeName}">
              <xsl:value-of select="$documentationLanguage"/>
            </xsl:attribute>
            <xsl:text>Character data only</xsl:text>
          </xsl:element>
        </xsl:when>
        <xsl:when test="count(Element) = 0">
          <xsl:element namespace="{$outputNS}" name="{$segName}">
            <xsl:attribute name="{$langAttributeName}">
              <xsl:value-of select="$documentationLanguage"/>
            </xsl:attribute>
            <xsl:text>Empty element</xsl:text>
          </xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element namespace="{$outputNS}" name="{$divName}">
            <xsl:attribute name="{$rendName}">
              <xsl:text>specChildren</xsl:text>
            </xsl:attribute>
            <xsl:for-each-group select="*" group-by="@module">
              <xsl:sort select="@module"/>
              <xsl:element namespace="{$outputNS}" name="{$divName}">
                <xsl:attribute name="{$rendName}">
                  <xsl:text>specChild</xsl:text>
                </xsl:attribute>
                <xsl:choose>
                  <xsl:when test="@type='TEXT'">
                    <xsl:text>character data</xsl:text>
                  </xsl:when>
                  <xsl:when test="@type='ANYXML'">
                    <xsl:for-each select="$here">
                      <xsl:call-template name="linkTogether">
                        <xsl:with-param name="name">macro.anyXML</xsl:with-param>
                        <xsl:with-param name="class">link_odd</xsl:with-param>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:if test="string-length(current-grouping-key()) > 0">
                      <xsl:element namespace="{$outputNS}" name="{$segName}">
                        <xsl:attribute name="{$rendName}">
                          <xsl:text>specChildModule</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="current-grouping-key()"/>
                        <xsl:text>: </xsl:text>
                      </xsl:element>
                    </xsl:if>
                    <xsl:element namespace="{$outputNS}" name="{$segName}">
                      <xsl:attribute name="{$rendName}">
                        <xsl:text>specChildElements</xsl:text>
                      </xsl:attribute>
                      <xsl:for-each-group select="current-group()" group-by="@name">
                        <xsl:sort select="@name"/>
                        <xsl:variable name="me" select="concat(@prefix, @name)"/>
                        <xsl:variable name="display" select="@name"/>
                        <xsl:variable name="type" select="@type"/>
                        <xsl:for-each select="$here">
                          <xsl:call-template name="linkTogether">
                            <xsl:with-param name="name" select="$me"/>
                            <xsl:with-param name="reftext" select="$display"/>
                            <xsl:with-param name="class">link_odd_<xsl:value-of
                                select="$type"/></xsl:with-param>
                          </xsl:call-template>
                        </xsl:for-each>
                        <xsl:if test="not(position() = last())">
                          <xsl:call-template name="showSpaceBetweenItems"/>
                        </xsl:if>
                      </xsl:for-each-group>
                    </xsl:element>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:element>
            </xsl:for-each-group>
          </xsl:element>
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
              <Element prefix="{@prefix}" module="{@module}"
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
            <Element prefix="{@prefix}" module="{@module}" type="{local-name()}"
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
      <xsl:when test="$oddmode='html' and number($splitLevel)=-1">
        <a xmlns="http://www.w3.org/1999/xhtml" class="{$class}" href="#{$partialname}">
          <xsl:value-of select="$link"/>
        </a>
      </xsl:when>
      <xsl:when test="$oddmode='html' and $STDOUT='true'">
        <a xmlns="http://www.w3.org/1999/xhtml" class="{$class}">
          <xsl:attribute name="href">
            <xsl:for-each select="key('IDENTS',$partialname)">
              <xsl:call-template name="getSpecURL">
                <xsl:with-param name="name">
                  <xsl:value-of select="$partialname"/>
                </xsl:with-param>
                <xsl:with-param name="type">
                  <xsl:value-of select="substring-before(local-name(),'Spec')"/>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:attribute>
          <xsl:value-of select="$link"/>
        </a>
      </xsl:when>
      <xsl:when test="$oddmode='html'">
        <a xmlns="http://www.w3.org/1999/xhtml" class="{$class}" title="{$glossAndDesc}"
          href="{concat('ref-',$partialname,'.html')}">
          <xsl:value-of select="$link"/>
        </a>
      </xsl:when>
      <xsl:when test="$oddmode='pdf'">
        <fo:inline>
          <xsl:value-of select="$link"/>
        </fo:inline>
      </xsl:when>
      <xsl:when test="$oddmode='tei'">
        <tei:ref target="#{$partialname}">
          <xsl:value-of select="$link"/>
        </tei:ref>
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





</xsl:stylesheet>
