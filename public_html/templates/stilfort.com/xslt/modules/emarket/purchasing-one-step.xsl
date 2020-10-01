<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/TR/xlink">

		
	<xsl:template match="result[@module = 'emarket' and @method = 'purchasing_one_step']">
		<xsl:apply-templates select="document('udata://emarket/cart')" />
	</xsl:template>

	<xsl:template match="udata[@module = 'emarket' and @method = 'purchasing_one_step'][onestep]">
		<form class="without-steps" action="/emarket/saveInfo" method="POST">
			<xsl:apply-templates select="onestep/customer" />
			<xsl:apply-templates select="onestep/delivery_choose" />
			<xsl:apply-templates select="onestep/delivery" />
			<xsl:apply-templates select="onestep/payment" />
			<input type="submit" value="&continue;" class="button big" />
		</form>
	</xsl:template>

	<xsl:template match="udata[@module = 'emarket' and @method = 'purchasing_one_step']/onestep/customer">
		<div style="display: block;" class="customer onestep">
			<xsl:apply-templates select="document(concat('udata://data/getEditForm/', @id))" />
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'emarket' and @method = 'purchasing_one_step']/onestep/delivery">
		<div style="display: block;" class="delivery onestep">
			<xsl:apply-templates select="document(concat('udata://data/getCreateForm/',@type-id))" />
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'emarket' and @method = 'purchasing_one_step']/onestep/delivery[items/item]">
		<div style="display: block;" class="delivery onestep">
			<h4>&choose-delivery-address;</h4>
			<xsl:apply-templates select="items" mode="delivery-address" />
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'emarket' and @method = 'purchasing_one_step']/onestep/delivery_choose" />
	<xsl:template match="udata[@module = 'emarket' and @method = 'purchasing_one_step']/onestep/delivery_choose[items/item]">
		<div style="display: block;" class="dychoose onestep">
			<h4>&delivery-agent;</h4>
			<xsl:apply-templates select="items" mode="delivery-choose" />
		</div>			
	</xsl:template>
	
	<xsl:template match="udata[@module = 'emarket' and @method = 'purchasing_one_step']/onestep/payment" />
	<xsl:template match="udata[@module = 'emarket' and @method = 'purchasing_one_step']/onestep/payment[items/item]">
		<div style="display: block;" class="payment onestep">
			<h4>&payment-type;</h4>
			<xsl:apply-templates select="items/item" mode="payment_one_step" />
		</div>
	</xsl:template>

</xsl:stylesheet>