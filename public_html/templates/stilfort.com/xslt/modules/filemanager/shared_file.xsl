<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/filemanager/shared_file.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:xlink="http://www.w3.org/TR/xlink">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="result[@module = 'filemanager' and @method = 'shared_file']">
		<xsl:apply-templates select="//property[@name = 'fs_file']" />
	</xsl:template>
	
	<xsl:template match="result[@module = 'filemanager' and @method = 'shared_file']//property[@name = 'fs_file']">
		<xsl:value-of select="document(concat('udata://content/redirect/(', value ,')'))" />
	</xsl:template>


</xsl:stylesheet>