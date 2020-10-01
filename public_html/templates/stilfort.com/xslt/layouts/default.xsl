<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"[
	<!ENTITY ajax	"php:function('getRequest', 'ajax')">
]>

<xsl:stylesheet	version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:xlink="http://www.w3.org/TR/xlink" xmlns:php="http://php.net/xsl" exclude-result-prefixes="xsl umi php">
	<xsl:output method="html" indent="yes"/>
	
	<xsl:include href="ajax.xsl" />
	<xsl:include href="index.xsl" />

	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="&ajax;">
				<xsl:apply-templates select="." mode="ajax" />
			</xsl:when>
			<xsl:when test="count(udata) = 0">
				<xsl:apply-templates select="." mode="index" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="result">
		<!--<xsl:if test="not($debug = 1)"><xsl:value-of select="document('udata://content/redirect/')" /></xsl:if>-->
		<p><strong>Модуль:</strong> <xsl:value-of select="@module" /></p>
		<p><strong>Метод:</strong> <xsl:value-of select="@method" /></p>
	</xsl:template>
	
	<xsl:template name="debug">
		<xsl:param name="module" select="$module" />
		<xsl:param name="method" select="$method" />
		<xsl:param name="template_file" />
		<xsl:param name="xpath" />
		<xsl:if test="$debug = 1">
			<div id="j_debug">
				<div class="container">
					<div><span class="title">Module:</span><span class="value"><xsl:value-of select="$module" /></span></div>
					<div><span class="title">Method:</span><span class="value"><xsl:value-of select="$method" /></span></div>
					<div><span class="title">Template File:</span><span class="value"><xsl:value-of select="$template_file" /></span></div>
					<div><span class="title">Template XPATH:</span><textarea><xsl:copy-of select="$xpath" /></textarea></div>
				</div>
			</div>
		</xsl:if>
	</xsl:template>


</xsl:stylesheet>