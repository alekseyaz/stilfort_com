<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/faq/category.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:xlink="http://www.w3.org/TR/xlink">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="result[@module = 'faq' and @method = 'category']">
		<xsl:apply-templates select="document(concat('udata://faq/category/notemplate/', $pId, '/99/'))/udata" />
	</xsl:template>
	
	<xsl:template match="udata[@module = 'faq' and @method = 'category']">

	</xsl:template>

	<xsl:template match="udata[@module = 'faq' and @method = 'category']/items/item">

	</xsl:template>

</xsl:stylesheet>