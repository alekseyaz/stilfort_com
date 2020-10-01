<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/emarket/cart.xsl'">
	<!ENTITY module_method	"@module = 'emarket' and @method = 'fast_purchase'">
]>

<xsl:stylesheet	version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:xlink="http://www.w3.org/TR/xlink">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="result[&module_method;]">
		<div id="template_emarket_purchase">
			<xsl:call-template name="debug"><xsl:with-param name="template_file" select="&template_file;" /><xsl:with-param name="xpath" select="." /><xsl:with-param name="module" select="$module" /><xsl:with-param name="method" select="$method" /></xsl:call-template>
			<h1>&emarket_purchase_h1;</h1>
			<div>
				<xsl:apply-templates select="document('udata://emarket/purchase/')/udata" />
			</div>
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]">
		<xsl:apply-templates select="purchasing" />
	</xsl:template>

	<xsl:template match="udata[&module_method;]/purchasing[@stage = 'required' and @step = 'personal']">
		<form enctype="multipart/form-data" method="post" action="{$lang-prefix}/emarket/purchase/required/personal/do/">
			<xsl:apply-templates select="document(concat('udata://data/getEditForm/', customer-id))" />
			<div>
				<input type="submit" class="button" value="Оформить" />
			</div>
		</form>
	</xsl:template>


	
	<xsl:template match="udata[&module_method;]/purchasing[@stage = 'result' and @step = 'successful']">&emarket_purchase_successful;</xsl:template>
	<xsl:template match="udata[&module_method;]/purchasing[@stage = 'result' and @step = 'failed']">&emarket_purchase_failed;</xsl:template>

</xsl:stylesheet>