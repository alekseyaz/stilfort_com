<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/news/lastlents.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="udata[@module = 'news' and @method = 'lastlents']">
		<xsl:apply-templates select="items"/>
	</xsl:template>

	<xsl:template match="udata[@module = 'news' and @method = 'lastlents']/items">
		<h2>Разделы</h2>
		<ul  class="nav nav-pills nav-stacked mb15">
			<xsl:apply-templates select="item" />
		</ul>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'news' and @method = 'lastlents']/items/item">
		<li>
			<xsl:if test="$result/page/@id = @id or $result/parents/page/@id = @id">
				<xsl:attribute name="class">active</xsl:attribute>
			</xsl:if>
			<a href="{@link}"><xsl:value-of select="." /></a>
		</li>
	</xsl:template>

	<xsl:template match="udata[@module = 'news' and @method = 'lastlents']" mode="root_lents">
		<xsl:apply-templates select="items" mode="root_lents"/>
	</xsl:template>

	<xsl:template match="udata[@module = 'news' and @method = 'lastlents']/items" mode="root_lents">
		<h2>Разделы</h2>
		<ul  class="nav nav-pills nav-stacked mb15">
			<xsl:apply-templates select="item" mode="root_lents"/>
		</ul>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'news' and @method = 'lastlents']/items/item" mode="root_lents">
		<li>
			<xsl:if test="$result/page/@id = @id">
				<xsl:attribute name="class">active</xsl:attribute>
			</xsl:if>
			<a href="{@link}"><xsl:value-of select="." /></a>
		</li>
		<xsl:apply-templates select="document(concat('udata://news/lastlents/', @id, '//100/1/'))/udata/items/item"/>
	</xsl:template>

</xsl:stylesheet>