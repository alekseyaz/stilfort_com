<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/system/listErrorMessages.xsl'">
	<!ENTITY module_method	"@module = 'system' and @method = 'listErrorMessages'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="udata[&module_method;]" />
	<xsl:template match="udata[&module_method; and items/item]">
		<div class="system_listErrorMessages">
			<xsl:apply-templates select="items/item" />
		</div>
	</xsl:template>
	
	<xsl:template match="udata[&module_method;]/items/item">
		<div class="system_listErrorMessages_item">
			<xsl:value-of select="." />
		</div>
	</xsl:template>

</xsl:stylesheet>