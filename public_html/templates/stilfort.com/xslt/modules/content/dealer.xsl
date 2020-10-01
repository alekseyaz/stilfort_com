<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="/">
		<xsl:apply-templates select="udata"/>
	</xsl:template>
	
	<xsl:template match="udata">
		<div id="content_content">
			<h1><xsl:value-of select=".//property[@name = 'h1']/value" /></h1>
			<div>
				<xsl:value-of select=".//property[@name = 'content']/value" disable-output-escaping="yes" />
			</div>
		</div>
	</xsl:template>


</xsl:stylesheet>