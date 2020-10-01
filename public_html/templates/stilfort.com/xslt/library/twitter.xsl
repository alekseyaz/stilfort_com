<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	
    <xsl:template match="result" mode="twitter">
		<meta name="twitter:card" content="summary_large_image" />
		<xsl:apply-templates select="." mode="twitter_description"/>
		<meta name="twitter:title" content="{@title}" />
		<xsl:apply-templates select="." mode="twitter_image"/>
    </xsl:template>

	
	<xsl:template match="group[@name='twitter']/property" mode="twitter">
		<meta property="{title}" content="{value}"/>
	</xsl:template>
	
	<xsl:template match="result" mode="twitter_description">
		<meta property="twitter:description">
			<xsl:attribute name="content">
				<xsl:value-of select="meta/description"/>
			</xsl:attribute>
		</meta>
	</xsl:template>
	
	
	<xsl:template match="result" mode="twitter_image"/>
	
	<xsl:template match="result[.//property[@name = 'header_pic']/value]" mode="twitter_image">
		<meta property="twitter:image" content="{$result/@protocol}://{$result/@domain}{.//property[@name = 'header_pic']/value}"/>
	</xsl:template>
	


	
</xsl:stylesheet>
