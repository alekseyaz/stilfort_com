<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	
	<xsl:template match="result" mode="h1">
		<div class="page-title">
			<h1>
				<xsl:apply-templates select="." mode="h1_value"/>
			</h1>
		</div>
	</xsl:template>
	
	<xsl:template match="result[page/@is-default = '1']" mode="h1">
		<div class="page-title">
			<h1>
				<xsl:apply-templates select="." mode="h1_value"/>
			</h1>
		</div>
	</xsl:template>
	
	<xsl:template match="result" mode="h1_value">
		<xsl:value-of select="@header" disable-output-escaping="yes"/>
	</xsl:template>
	
	<xsl:template match="result[page//property[@name = 'h1']]" mode="h1_value">
		<xsl:value-of select=".//property[@name = 'h1']/value" disable-output-escaping="yes"/>
	</xsl:template>
	
</xsl:stylesheet>
