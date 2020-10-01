<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[

]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="/">
		<xsl:apply-templates select="udata"/>
	</xsl:template>
	
	<xsl:template match="udata">
		Быстрый просмотр
		<xsl:apply-templates select="page"/>
	</xsl:template>
	
	<xsl:template match="page">
	
		<div class="summary entry-summary">
			<h1 itemprop="name" class="product_title entry-title"><xsl:value-of select=".//property[@name = 'h1']/value" /></h1>
			<img src="{.//group[@name = 'kartinki_tovara' and property/@type = 'img_file']/property[1]/value}"/>
		</div>
	</xsl:template>

</xsl:stylesheet>