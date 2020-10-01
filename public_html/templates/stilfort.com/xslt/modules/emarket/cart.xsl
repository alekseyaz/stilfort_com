<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/emarket/cart.xsl'">
	<!ENTITY module_method	"((@module = 'emarket' and @method = 'cart')or(@module = 'emarket' and @method = 'basket'))">
]>

<xsl:stylesheet	version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:xlink="http://www.w3.org/TR/xlink">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="result[&module_method;]">
		<div id="template_emarket_cart">
			<xsl:call-template name="debug"><xsl:with-param name="template_file" select="&template_file;" /><xsl:with-param name="xpath" select="." /><xsl:with-param name="module" select="$module" /><xsl:with-param name="method" select="$method" /></xsl:call-template>
			<h1>&emarket_cart_h1;</h1>
			<div>
				<xsl:apply-templates select="document('udata://emarket/cart/')/udata" />
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[&module_method;]">
		<xsl:text>Ваша корзина пуста</xsl:text>
	</xsl:template>

	<xsl:template match="udata[&module_method;][items/item]">
		<form action="/emarket/purchase/" method="post">
			<table>
				<thead>
					<tr>
						<td>Наименование</td>
						<td>Цена</td>
						<td>Кол-во</td>
						<td>Сумма</td>
						<td></td>
					</tr>
				</thead>
				<tbody>
					<xsl:apply-templates select="items/item" />
				</tbody>
				<tfoot>
					<tr>
						<td align="right" colspan="5"><div class="price cart_summary"><span class="title">Итого:</span><span class="value"><xsl:value-of select="summary/price/actual" /></span><span class="curency">&default_curency;</span></div></td>
					</tr>
				</tfoot>
			</table>
			<input type="submit" value="Оформить" />
		</form>
	</xsl:template>

	<xsl:template match="udata[&module_method;]/items/item">
		<xsl:variable name="element" select="document(concat('upage://', page/@id))/udata/page" />
		<tr>
			<td><a href="{$element/@link}"><xsl:value-of select="$element/name" /></a></td>
			<td><div class="price"><span class="value"><xsl:value-of select="price/actual" /></span><span class="curency">&default_curency;</span></div></td>
			<td><input type="text" name="" value="{amount}" /></td>
			<td><div class="price total_price"><span class="value"><xsl:value-of select="total-price/actual" /></span><span class="curency">&default_curency;</span></div></td>
			<td><a href="/emarket/basket/remove/element/{$element/@id}/"><span>X</span></a></td>
		</tr>
	</xsl:template>

	<xsl:template match="udata[&module_method;]" mode="short_card">
		<div class="title">Корзина</div>
		<div class="summary">В вашей корзине нет товаров</div>
	</xsl:template>

	<xsl:template match="udata[&module_method; and items/item]" mode="short_card">
		<div class="title"><a href="/emarket/cart/">Корзина</a></div>
		<xsl:apply-templates select="summary[amount]" mode="short_card" />
	</xsl:template>
	
	<xsl:template match="udata[&module_method;]/summary" mode="short_card">
		<div class="summary">
			<div class="quanity"><span>Товаров:</span><span class="value"><xsl:value-of select="amount" /></span><span class="curency">&default_mesure;</span></div>
			<div class="price"><span>Сумма:</span><span class="value"><xsl:value-of select="price/actual" /></span><span class="curency">&default_curency;</span></div>
		</div>
	</xsl:template>

</xsl:stylesheet>