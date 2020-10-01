<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	
	<xsl:template match="property[@type = 'wysiwyg']">
		<div class="field-text field_{@name}">
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>
	</xsl:template>
	
</xsl:stylesheet>
