<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="property[@type = 'date']">
		<xsl:param name="pattern" select="'d.m.Y'" />
		<xsl:value-of select="document(concat('udata://system/convertDate/', value/@unix-timestamp, '/(', $pattern, ')'))/udata" />
	</xsl:template>
	
</xsl:stylesheet>
