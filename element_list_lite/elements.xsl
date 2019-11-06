<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
<!--exclude-result-prefixes="tei" >-->
<xsl:output method="html" encoding="utf-8" />

<!--
<xsl:template match="/">
  <xsl:value-of select="last()" />
  <xsl:value-of select="position()" />
  <xsl:value-of select="local-name()" />
  <xsl:value-of select="name()" />
  <xsl:value-of select="namespace-uri()" />

  <xsl:value-of select="count(*)" />
  <xsl:value-of select="local-name(.)" />
  <xsl:value-of select="name(.)" />
  <xsl:value-of select="namespace-uri(.)" />

  <xsl:for-each select="*">
    <xsl:value-of select="name(.)" />
    <xsl:text disable-output-escaping = "yes" >&#10;</xsl:text>
  </xsl:for-each>
</xsl:template>
-->


<!-- TEI Lite スキーマ読み込み -->
<xsl:variable name="tei-lite-doc" select="doc('./tei_lite.rng')" />


<!-- ページ構成 -->
<xsl:template match="/">
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TEI Lite 要素・属性一覧</title>
    <style type="text/css">
    table {
        border-collapse: collapse;
        border: 2px solid;
    }
    th, td {
        border: 1px solid;
        padding: 6px;
    }
    .td-border-right-none {
        border-right-style:none;
    }
    .td-border-left-none {
        border-left-style:none;
    }
    </style>
  </head>
  
  <body>
    <h1>TEI Lite 要素・属性一覧</h1>
      <p>
        <small>
        <xsl:apply-templates select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition" />
        </small>
      </p>
      <p>このページはTEIガイドラインで定義されている <xsl:value-of select="count(distinct-values(/tei:TEI/tei:text/tei:body//tei:elementSpec/@ident))" /> 個の要素と <xsl:value-of select="count(distinct-values(/tei:TEI/tei:text/tei:body//tei:attDef/@ident))"/> 個の属性を，ガイドラインに沿ってモジュール別に列挙したものである．</p>
      <p>このページでは要素は TEI Lite に採用されたもののみを列挙している。</p>
      
      <ul class="list-inline">
        <li class="list-inline-item"><a href="#module_list">モジュール一覧</a></li>
        <li class="list-inline-item"><a href="#elements_list">要素一覧</a></li>
        <li class="list-inline-item"><a href="#attribute-classes-list">属性クラス一覧</a></li>
        <li class="list-inline-item"><a href="#alphabetical-index">アルファベット順要素インデックス</a></li>
      </ul>

    <h2 id="module_list">モジュール一覧</h2>
      <p>TEIガイドラインのすべての要素は，その用途や使用分野に応じ，以下のモジュールのいずれかに分類されている．</p>
      <xsl:call-template name="list-for-modules" />

    <h2 id="elements_list">要素一覧</h2>
      <p> * 印はその要素が <a href="https://tei-c.org/guidelines/customization/Lite/">TEI Lite</a> サブセット <xsl:value-of select="count($tei-lite-doc/rng:grammar/rng:define/rng:element)" /> 個中に含まれる基本的な要素であることを示す．</p>
      <xsl:call-template name="list-of-elements" />
    <h2 id="attribute-classes-list">属性クラス一覧</h2>
      <p>属性クラスは複数の属性をグループ化する．ある要素で使用可能な属性は属性クラスでも指定することができる．</p>
      <xsl:call-template name="list-of-attribute-class" />

    <h2 id="alphabetical-index">アルファベット順要素インデックス</h2>
      <p>
        <xsl:call-template name="alphabetical-index" />
      </p>
  </body>
</html>
</xsl:template>


<!-- バージョン表示 -->
<xsl:template match="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition">
  <xsl:text>Generated from ODD files of the Guidelines version </xsl:text> 
  <xsl:value-of select="tei:ref[2]" />
  <xsl:text> updated on </xsl:text>
  <xsl:value-of select="tei:date" />
  <xsl:text> as revision </xsl:text>
  <xsl:value-of select="tei:ref[3]" />
  <xsl:text>, and a TEI Lite RELAX NG schema file.</xsl:text>
</xsl:template>


<!-- モジュール一覧 -->
<xsl:template name="list-for-modules">
<table>
  <tr>
    <th>モジュール名</th>
    <!--<th>Formal public identifier</th>-->
    <th>日本語訳モジュール名</th>
    <th>ガイドラインの対応する章</th>
  </tr>
  <!-- Get module names -->
  <xsl:for-each select="//tei:moduleSpec">
      <xsl:variable name="module_name" select="@ident" />
      <xsl:variable name="module_code"  select="@xml:id" />
      <tr>
        <td>
        <xsl:choose>
          <xsl:when test="@type">  <!-- 'tei' module -->
            <xsl:value-of select="@ident" />
          </xsl:when>
          <xsl:otherwise>
            <a>
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text><xsl:value-of select="@ident" />
            </xsl:attribute>
            <xsl:value-of select="@ident" />
            </a>
          </xsl:otherwise>
        </xsl:choose>
        </td>
        <!--<td><xsl:value-of select="tei:altIdent" /></td>-->
        <td><xsl:value-of select="tei:desc[@xml:lang='ja']" /></td>
        <td>
        <a>
          <xsl:attribute name="href">
            <xsl:text>https://www.tei-c.org/release/doc/tei-p5-doc/ja/html/</xsl:text>
            <xsl:choose>
              <xsl:when test="$module_name='tagdocs'">
                <xsl:value-of select="substring(@xml:id, 5)" />
              </xsl:when>
              <xsl:when test="$module_name='tei' or $module_name='dictionaries' or $module_name='msdescription' or $module_name='figures' or $module_name='corpus'">
                <xsl:value-of select="substring(@xml:id, 2, 2)" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="substring(@xml:id, 2)" />
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text>.html</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="target">
            <xsl:text>_blank</xsl:text>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$module_name='tagdocs'">
              <xsl:for-each select="/tei:TEI/tei:text/tei:body/tei:div[@type='div1']">
                <xsl:if test="@xml:id=substring($module_code, 5)">
                  <xsl:value-of select="position()" />
                </xsl:if>
              </xsl:for-each>
              <xsl:text>. </xsl:text>
              <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:div[@type='div1' and @xml:id=substring($module_code, 5)]/tei:head" />
            </xsl:when>
            <xsl:when test="$module_name='tei' or $module_name='dictionaries' or $module_name='msdescription' or $module_name='figures' or $module_name='corpus'">
              <xsl:for-each select="/tei:TEI/tei:text/tei:body/tei:div[@type='div1']">
                <xsl:if test="@xml:id=substring($module_code, 2, 2)">
                  <xsl:value-of select="position()" />
                </xsl:if>
              </xsl:for-each>
              <xsl:text>. </xsl:text>
              <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:div[@type='div1' and @xml:id=substring($module_code, 2, 2)]/tei:head" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:for-each select="/tei:TEI/tei:text/tei:body/tei:div[@type='div1']">
                <xsl:if test="@xml:id=substring($module_code, 2)">
                  <xsl:value-of select="position()" />
                </xsl:if>
              </xsl:for-each>
              <xsl:text>. </xsl:text>
              <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:div[@type='div1' and @xml:id=substring($module_code, 2)]/tei:head" />
            </xsl:otherwise>
          </xsl:choose>
          </a>
        </td>
      </tr>
  </xsl:for-each>
</table>
</xsl:template>


<!-- 要素一覧 -->
<xsl:template name="list-of-elements">
<table>
  <tr>
    <th colspan="2" class="td-border-right-none">要素名</th>
    <th>用途</th>
    <th>使用可能な属性クラス及び属性</th>
    <th>モジュール</th>
    <th>参照すべきガイドラインのセクション</th>
  </tr>
  <!-- Get module names -->
  <xsl:for-each select="//tei:moduleSpec">
    <xsl:if test="not(@type)"><!-- Exclude 'tei' module -->
      <xsl:call-template name="get-element-specs">
        <xsl:with-param name="module_name" select="@ident" />
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>
</table>
</xsl:template>

<xsl:template name="get-element-specs">
  <!-- Get element specs grouped with module -->
  <xsl:param name="module_name" />
  <xsl:for-each select="//tei:elementSpec[@module=$module_name and @ident=$tei-lite-doc/rng:grammar/rng:define/rng:element/@name]">
        <xsl:apply-templates select="." mode="toc-for-element" />
  </xsl:for-each>
</xsl:template>

<xsl:template match="tei:elementSpec" mode="toc-for-element">
<xsl:variable name="element_name" select="@ident" />
<xsl:variable name="module_name" select="@module" />
<tr>
  <!-- TEI Lite に含まれるか -->
  <td class="td-border-right-none">
    <xsl:if test="$tei-lite-doc/rng:grammar/rng:define/rng:element[@name=$element_name]">
      <xsl:text>*</xsl:text>
    </xsl:if>
  </td>
  <!-- 要素名 -->
  <td class="td-border-left-none">
    <a>
    <xsl:attribute name="href">
      <xsl:text>https://www.tei-c.org/release/doc/tei-p5-doc/ja/html/</xsl:text>
      <xsl:text>ref-</xsl:text>
      <xsl:value-of select="@ident" />
      <xsl:text>.html</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="target">
      <xsl:text>_blank</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="id">
      <xsl:value-of select="@ident" />
    </xsl:attribute>
    <xsl:value-of select="@ident" />
    </a>
  </td>
  <!-- 用途 -->
  <td>
  <xsl:choose>
    <xsl:when test="tei:desc[@xml:lang='ja']">
      <xsl:value-of select="translate(normalize-space(tei:desc[@xml:lang='ja']), '&#32;', '')" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="normalize-space(tei:desc[@xml:lang='en'])" />
    </xsl:otherwise>
  </xsl:choose>
  <!-- 上位要素が一つのみの場合は注記 -->
  <!-- gloss の日本語訳がされている場合は付加 -->
  <xsl:if test="tei:gloss[@xml:lang='ja']/text()">
    <xsl:text> (</xsl:text>
      <xsl:value-of select="tei:gloss[@xml:lang='ja']" />
    <xsl:text>)</xsl:text>
  </xsl:if>
  </td>
  <!-- 使用可能な属性クラスと属性 -->
  <td>
    <xsl:apply-templates select="tei:classes/tei:memberOf[starts-with(@key, 'att')]" />
    <xsl:if test="tei:attList">
      <br />
      <xsl:apply-templates select="tei:attList">
        <xsl:with-param name="element_name" select="@ident" />
      </xsl:apply-templates>
    </xsl:if>
  </td>
  <!-- 属するモジュール -->
  <td>
    <xsl:choose>
    <xsl:when test="preceding-sibling::tei:elementSpec[@module=$module_name]">
      <xsl:value-of select="@module" />
    </xsl:when>
    <xsl:otherwise>
      <a>
        <xsl:attribute name="id" select="@module" />
        <xsl:value-of select="@module" />
      </a>
    </xsl:otherwise>
    </xsl:choose>
  </td>
  <!-- 参照すべきガイドラインのセクション -->
  <td>
    <!-- <xsl:variable name="element_name" select="@ident" />
    <xsl:apply-templates select="/tei:TEI/tei:text/tei:body//tei:specList/tei:specDesc[@key=$element_name]" /> -->
    <xsl:apply-templates select="tei:listRef" />
  </td>
</tr>
</xsl:template>

<xsl:template match="/tei:TEI/tei:text/tei:body//tei:classes/tei:memberOf">
    <xsl:variable name="class_name" select="@key" />
    <xsl:for-each select=".">
      <a>
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:value-of select="translate(@key, '.', '-')" />
        </xsl:attribute>
      <xsl:value-of select="@key" />
      </a>
      <xsl:text> </xsl:text>
    </xsl:for-each>
    <xsl:if test="/tei:TEI/tei:text/tei:body//tei:classSpec[@ident=$class_name]/tei:classes">
      <xsl:apply-templates select="/tei:TEI/tei:text/tei:body//tei:classSpec[@ident=$class_name]/tei:classes/tei:memberOf[starts-with(@key, 'att')]" />
    </xsl:if>
</xsl:template>

<xsl:template match="//tei:attList">
    <xsl:param name="element_name" />
    <xsl:for-each select="tei:attDef">
      <xsl:text>@</xsl:text>
      <a>
        <xsl:attribute name="href">
          <xsl:text>https://www.tei-c.org/release/doc/tei-p5-doc/ja/html/</xsl:text>
          <xsl:text>ref-</xsl:text>
          <xsl:value-of select="$element_name" />
          <xsl:text>.html</xsl:text>
          <xsl:text>#tei_att.</xsl:text>
          <xsl:value-of select="@ident" />
        </xsl:attribute>
        <xsl:attribute name="target">
          <xsl:text>_blank</xsl:text>
        </xsl:attribute>
      <xsl:value-of select="@ident" />
      </a>
      <xsl:choose>
        <xsl:when test="@usage='req'">
          <xsl:text> (必須)</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> (任意)</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text> - </xsl:text>
      <xsl:choose>
        <xsl:when test="tei:desc[@xml:lang='ja']">
          <xsl:value-of select="translate(normalize-space(tei:desc[@xml:lang='ja']), '&#32;', '')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="normalize-space(tei:desc[@xml:lang='en'])" />
        </xsl:otherwise>
      </xsl:choose>
      <br />
  </xsl:for-each>
  <xsl:apply-templates select="tei:attList" />
</xsl:template>

<!-- 要素に対応するガイドラインのセクション (specList/specDesc による場合) -->
<xsl:template match="/tei:TEI/tei:text/tei:body//tei:specList/tei:specDesc">
  <a>
    <xsl:attribute name="href">
      <xsl:text>https://www.tei-c.org/release/doc/tei-p5-doc/ja/html/</xsl:text>
      <xsl:choose>
        <xsl:when test="substring(ancestor::tei:div[1]/@xml:id, 1, 2) = 'ms'">
          <xsl:text>MS</xsl:text>
        </xsl:when>
        <xsl:when test="substring(ancestor::tei:div[1]/@xml:id, 1, 2) = 'FD'">
          <xsl:text>FS</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring(ancestor::tei:div[1]/@xml:id, 1, 2)" />
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>.html</xsl:text>
      <xsl:text>#</xsl:text>
      <xsl:value-of select="ancestor::tei:div[1]/@xml:id" />
    </xsl:attribute>
    <xsl:attribute name="target">
      <xsl:text>_blank</xsl:text>
    </xsl:attribute>
    <xsl:text>§ </xsl:text>
    <xsl:if test="ancestor::tei:div[5]/preceding-sibling::tei:div/tei:head">
      <xsl:value-of select="count(ancestor::tei:div[5]/preceding-sibling::tei:div/tei:head) + 1" />
      <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:if test="ancestor::tei:div[4]/preceding-sibling::tei:div/tei:head">
      <xsl:value-of select="count(ancestor::tei:div[4]/preceding-sibling::tei:div/tei:head) + 1" />
      <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:if test="ancestor::tei:div[3]/preceding-sibling::tei:div/tei:head">
      <xsl:value-of select="count(ancestor::tei:div[3]/preceding-sibling::tei:div/tei:head) + 1" />
      <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:if test="ancestor::tei:div[2]/preceding-sibling::tei:div/tei:head">
      <xsl:value-of select="count(ancestor::tei:div[2]/preceding-sibling::tei:div/tei:head) + 1" />
      <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:value-of select="count(ancestor::tei:div[1]/preceding-sibling::tei:div/tei:head) + 1" />
    <xsl:text> </xsl:text>
    <xsl:value-of select="ancestor::tei:div[1]/tei:head" />
  </a>
  <br/>
</xsl:template>

<!-- 要素に対応するガイドラインのセクション (elementSpec/listRef による場合) -->
<xsl:template match="//tei:elementSpec/tei:listRef">
  <xsl:for-each select="tei:ptr">
    <xsl:variable name="listRef_target" select="substring(@target, 2)" />
    <xsl:apply-templates select="//tei:div[@xml:id=$listRef_target]" />
  </xsl:for-each>
</xsl:template>

<xsl:template match="//tei:div">
  <a>
    <xsl:attribute name="href">
      <xsl:text>https://www.tei-c.org/release/doc/tei-p5-doc/ja/html/</xsl:text>
      <xsl:choose>
        <xsl:when test="substring(@xml:id, 1, 2) = 'ms'">
          <xsl:text>MS</xsl:text>
        </xsl:when>
        <xsl:when test="substring(@xml:id, 1, 2) = 'FD'">
          <xsl:text>FS</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring(@xml:id, 1, 2)" />
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>.html</xsl:text>
      <xsl:text>#</xsl:text>
      <xsl:value-of select="@xml:id" />
    </xsl:attribute>
    <xsl:attribute name="target">
      <xsl:text>_blank</xsl:text>
    </xsl:attribute>
    <xsl:text>§ </xsl:text>
    <xsl:if test="ancestor::tei:div[4]/preceding-sibling::tei:div/tei:head">
      <xsl:value-of select="count(ancestor::tei:div[4]/preceding-sibling::tei:div/tei:head) + 1" />
      <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:if test="ancestor::tei:div[3]/preceding-sibling::tei:div/tei:head">
      <xsl:value-of select="count(ancestor::tei:div[3]/preceding-sibling::tei:div/tei:head) + 1" />
      <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:if test="ancestor::tei:div[2]/preceding-sibling::tei:div/tei:head">
      <xsl:value-of select="count(ancestor::tei:div[2]/preceding-sibling::tei:div/tei:head) + 1" />
      <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:if test="ancestor::tei:div[1]/preceding-sibling::tei:div/tei:head">
      <xsl:value-of select="count(ancestor::tei:div[1]/preceding-sibling::tei:div/tei:head) + 1" />
      <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:value-of select="count(preceding-sibling::tei:div/tei:head) + 1" />
    <xsl:text> </xsl:text>
    <xsl:value-of select="tei:head" />
  </a>
  <br/>
</xsl:template>


<!-- 属性クラス一覧 -->
<xsl:template name="list-of-attribute-class">
<table>
  <tr>
    <th>属性クラス名</th>
    <th>このクラスの説明</th>
    <th>このクラスに含まれる属性とその用途</th>
  </tr>
  <xsl:apply-templates select="/tei:TEI/tei:text/tei:body//tei:classSpec[@type='atts']">
    <xsl:sort select="@ident" data-type="text" order="ascending" />
  </xsl:apply-templates>
</table>
</xsl:template>

<xsl:template match="/tei:TEI/tei:text/tei:body//tei:classSpec">
  <xsl:for-each select=".">
  <xsl:variable name="attribute_class_name" select="@ident" />
  <tr>
    <!-- 属性クラス名 -->
    <td>
    <xsl:attribute name="id">
      <xsl:value-of select="translate(@ident, '.', '-')" />
    </xsl:attribute>
    <a>
    <xsl:attribute name="href">
      <xsl:text>https://www.tei-c.org/release/doc/tei-p5-doc/ja/html/</xsl:text>
      <xsl:text>ref-</xsl:text>
      <xsl:value-of select="@ident" />
      <xsl:text>.html</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="target">
      <xsl:text>_blank</xsl:text>
    </xsl:attribute>
    <xsl:value-of select="@ident" />
    </a>
    </td>
    <!-- このクラスの説明 -->
    <td>
    <xsl:choose>
      <xsl:when test="tei:desc[@xml:lang='ja']">
        <xsl:value-of select="translate(normalize-space(tei:desc[@xml:lang='ja']), '&#32;', '')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="normalize-space(tei:desc[@xml:lang='en'])" />
      </xsl:otherwise>
    </xsl:choose>
    </td>
    <!-- このクラスに含まれる属性とその意味 -->
    <td>
      <xsl:for-each select="tei:attList/tei:attDef">
        <xsl:text>@</xsl:text>
        <a>
        <xsl:attribute name="href">
          <xsl:text>https://www.tei-c.org/release/doc/tei-p5-doc/ja/html/</xsl:text>
          <xsl:text>ref-</xsl:text>
          <xsl:value-of select="$attribute_class_name" />
          <xsl:text>.html</xsl:text>
          <xsl:text>#tei_att.</xsl:text>
          <xsl:value-of select="@ident" />
        </xsl:attribute>
        <xsl:attribute name="target">
          <xsl:text>_blank</xsl:text>
        </xsl:attribute>
        <xsl:value-of select="@ident" />
        </a>
        <xsl:text> - </xsl:text>
        <xsl:choose>
          <xsl:when test="tei:desc[@xml:lang='ja']">
            <xsl:value-of select="translate(normalize-space(tei:desc[@xml:lang='ja']), '&#32;', '')" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="normalize-space(tei:desc[@xml:lang='en'])" />
          </xsl:otherwise>
        </xsl:choose>
        <br />
      </xsl:for-each>
    </td>
  </tr>
  </xsl:for-each>
</xsl:template>


<!-- アルファベット順インデックス -->
<xsl:template name="alphabetical-index">
  <xsl:variable name="doc" select="/" />
  <xsl:variable name="alphabet" select="('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')" />
  <table>
  <xsl:for-each select="$alphabet">
  <xsl:variable name="index" select="." />
  <xsl:if test="$doc/tei:TEI/tei:text/tei:body//tei:elementSpec[starts-with(@ident, $index) or starts-with(@ident, lower-case($index))]">
    <tr>
    <td>
    <xsl:text> [</xsl:text>
    <xsl:value-of select="$index" />
    <xsl:text>] </xsl:text>
    </td>
    <td>
    <xsl:apply-templates select="$doc/tei:TEI/tei:text/tei:body//tei:elementSpec[(starts-with(@ident, $index) or starts-with(@ident, lower-case($index))) and @ident=$tei-lite-doc/rng:grammar/rng:define/rng:element/@name]" mode="alphabetical-index">
      <xsl:sort select="@ident" data-type="text" order="ascending"/>
    </xsl:apply-templates>
    </td>
    </tr>
  </xsl:if>
  </xsl:for-each>
  </table>
</xsl:template>

<xsl:template match="/tei:TEI/tei:text/tei:body//tei:elementSpec" mode="alphabetical-index">
  <xsl:for-each select=".">
    <a>
    <xsl:attribute name="href">
      <xsl:text>#</xsl:text>
      <xsl:value-of select="@ident" />
    </xsl:attribute>
    <xsl:value-of select="@ident" />
    </a>
    <xsl:text >  </xsl:text>
  </xsl:for-each>
</xsl:template>


<!-- 属性定義 -->
<xsl:template match="tei:attDef">
  <xsl:value-of select="@ident" />
  <xsl:text disable-output-escaping = "yes" >	</xsl:text>
  <xsl:choose>
    <xsl:when test="tei:desc[@xml:lang='ja']">
      <xsl:value-of select="translate(normalize-space(tei:desc[@xml:lang='ja']), '&#32;', '')" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="normalize-space(tei:desc[@xml:lang='en'])" />
    </xsl:otherwise>
  </xsl:choose>
  <xsl:text disable-output-escaping = "yes" >&#10;</xsl:text>
</xsl:template>


<!-- 要素個別の情報 -->
<xsl:template name="elements-body">
  <!-- Get module names -->
  <xsl:for-each select="//tei:moduleSpec">
    <xsl:call-template name="elements-specs-body">
      <xsl:with-param name="module_name" select="@ident" />
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>

<xsl:template name="elements-specs-body">
  <!-- Get element specs grouped with module -->
  <xsl:param name="module_name" />
  <xsl:for-each select="//tei:elementSpec[@module=$module_name]">
    <xsl:apply-templates select="." mode="element-spec-body" />
  </xsl:for-each>
</xsl:template>

<xsl:template match="tei:elementSpec" mode="element-spec-body">
  <xsl:param name="module_name" select="@module" />
<h3>
<xsl:attribute name="id">
  <xsl:value-of select="@ident" />
</xsl:attribute>
<xsl:text>◇ </xsl:text>
<a>
<xsl:attribute name="href">
<xsl:text>https://www.tei-c.org/release/doc/tei-p5-doc/ja/html/</xsl:text>
<xsl:text>ref-</xsl:text>
<xsl:value-of select="@ident" />
<xsl:text>.html</xsl:text>
</xsl:attribute>
<xsl:attribute name="target">
<xsl:text>_blank</xsl:text>
</xsl:attribute>
<xsl:value-of select="@ident" />
</a>
</h3>
<table>
  <tr>
    <td>要素名</td>
    <td><xsl:value-of select="@ident" /></td>
  </tr>
  <tr>
    <td>モジュール</td>
    <td>
      <xsl:value-of select="@module" />
      <xsl:text> </xsl:text>
      <xsl:value-of select="//tei:moduleSpec[@ident=$module_name]/tei:desc[@xml:lang='ja']" />
    </td>
  </tr>
  <tr>
    <td>説明</td>
    <td>
  <xsl:choose>
    <xsl:when test="tei:desc[@xml:lang='ja']">
      <xsl:value-of select="translate(normalize-space(tei:desc[@xml:lang='ja']), '&#32;', '')" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="normalize-space(tei:desc[@xml:lang='en'])" />
    </xsl:otherwise>
  </xsl:choose>
    </td>
  </tr>
  <xsl:if test="tei:desc[@xml:lang='ja']">
    <tr>
      <td></td>
      <td>
        <xsl:value-of select="normalize-space(tei:desc[@xml:lang='en'])" />
      </td>
    </tr>
  </xsl:if>
  <!--<xsl:if test="tei:remarks[@xml:lang='en']">
    <td>注記</td>
    <td>
      <xsl:apply-templates select="tei:remarks" />
    </td>
  </xsl:if>-->
</table>
</xsl:template>

<xsl:template match="tei:elementSpec/tei:remarks">
  <xsl:choose>
    <xsl:when test="@xml:lang='ja'">
      <xsl:value-of select="translate(normalize-space(.), '&#32;', '')" />
    </xsl:when>
    <xsl:when test="@xml:lang='en'">
      <xsl:value-of select="normalize-space(.)" />
    </xsl:when>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
