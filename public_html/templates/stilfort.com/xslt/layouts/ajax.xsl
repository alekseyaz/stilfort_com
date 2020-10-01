<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/layaouts/ajax.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="utf-8" method="xml" indent="yes" />

	<xsl:template match="/" mode="ajax"><xsl:apply-templates select="result|udata" mode="ajax" /></xsl:template>
	<xsl:template match="result|udata" mode="ajax"><xsl:apply-templates select="." /></xsl:template>

</xsl:stylesheet>