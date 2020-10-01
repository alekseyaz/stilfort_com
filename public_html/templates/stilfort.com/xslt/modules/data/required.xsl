<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	
	<xsl:template match="field" mode="required"/>
	
	<xsl:template match="field[@required]" mode="required">
		<xsl:attribute name="required">required</xsl:attribute>
	</xsl:template>
	
	<xsl:template match="field[@required and (@name='email' and @name='e-mail')]" mode="required">
		<xsl:attribute name="required">required</xsl:attribute>
		<xsl:attribute name="type">email</xsl:attribute>
	</xsl:template>
	
</xsl:stylesheet>