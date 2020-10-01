<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/emarket/cart.xsl'">
	<!ENTITY module_method	"@module = 'emarket' and @method = 'purchase'">
]>

<xsl:stylesheet	version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	<xsl:include href="purchase/required.xsl" />
	<xsl:include href="purchase/delivery.xsl" />
	<xsl:include href="purchase/payment.xsl" />
	
	<xsl:template match="result[&module_method;]">
		<div class='container-wrapper bg-6'>
			<div class='container'>
				<div class='row'>
					<div class='col-sm-offset-2 col-sm-20 col-md-16 col-md-offset-4'>
						<xsl:apply-templates select="." mode="h1"/>
						<xsl:apply-templates select="document('udata://emarket/purchase/')/udata" />
					</div>
				</div>
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