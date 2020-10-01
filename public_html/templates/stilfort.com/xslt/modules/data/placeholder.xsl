<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	
	
	<xsl:template match="field" mode="placeholder">
		<xsl:attribute name="placeholder">
			<xsl:apply-templates select="." mode="placeholder_value"/>
		</xsl:attribute>
	</xsl:template>
	
	<!--Если placeholder не определен то выводим name поля, в админке должно красиво называться-->
	<xsl:template match="field" mode="placeholder_value">
		<xsl:value-of select="@name" disable-output-escaping="yes" />
	</xsl:template>
	
	<xsl:template match="field[@title]" mode="placeholder_value">
		<xsl:value-of select="@title" disable-output-escaping="yes" />
	</xsl:template>
	
	<xsl:template match="field[@tip]" mode="placeholder_value">
		<xsl:value-of select="@tip" disable-output-escaping="yes" />
	</xsl:template>

	
</xsl:stylesheet>