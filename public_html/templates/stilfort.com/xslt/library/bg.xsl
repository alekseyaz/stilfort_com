<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	
	<xsl:template match="property" mode="bg"/>
	
	<xsl:template match="property[@type = 'img_file']" mode="bg">
		<xsl:apply-templates select="value" mode="bg"/>
	</xsl:template>
	
	<xsl:template match="property[@type = 'img_file']/value" mode="bg">
		<xsl:attribute name="style">
			<xsl:text>background:url('</xsl:text>
				<xsl:value-of select="."/>
			<xsl:text>') center center no-repeat;</xsl:text>
		</xsl:attribute>
	</xsl:template>
	
	<xsl:template match="property" mode="bg_img"/>
	
	<xsl:template match="property[@type = 'img_file']" mode="bg_img">
		<xsl:apply-templates select="value" mode="bg_img"/>
	</xsl:template>
	
	<xsl:template match="property[@type = 'img_file']/value" mode="bg_img">
		<xsl:attribute name="style">
			<xsl:text>background-image:url('</xsl:text>
				<xsl:value-of select="."/>
			<xsl:text>');</xsl:text>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>
