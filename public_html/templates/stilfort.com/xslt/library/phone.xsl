<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	
	<xsl:template match="property" mode="a_tel">
		<a>
			<xsl:apply-templates select="." mode="href_tel"/>
			<xsl:value-of select="value" disable-output-escaping="yes"/>
		</a>
	</xsl:template>
	
	<xsl:template match="property" mode="href_tel">
		<xsl:attribute name="href">
			<xsl:value-of select="concat('tel:', translate(value, translate(value, '+0123456789', ''), ''))" disable-output-escaping="yes"/>
		</xsl:attribute>
	</xsl:template>

</xsl:stylesheet>
