<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/system/numpages.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template name="numpages">
		<xsl:param name="total" select="../total" />
		<xsl:param name="per_page" select="../per_page" />
		<xsl:apply-templates select="document(concat('udata://system/numpages/', $total, '/', $per_page, '/'))/udata[items]" />
	</xsl:template>


	<xsl:template match="udata[@module = 'system' and @method = 'numpages']">
		<div class="numpages">

			<xsl:apply-templates select="toprev_link" />
			<xsl:apply-templates select="items" />
			<xsl:apply-templates select="tonext_link" />
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'system' and @method = 'numpages']/items">
			<xsl:apply-templates select="item" />
	</xsl:template>

	<xsl:template match="udata[@module = 'system' and @method = 'numpages']/items/item">
		<span><a href="{@link}"><xsl:value-of select="." /></a></span>
	</xsl:template>

	<xsl:template match="udata[@module = 'system' and @method = 'numpages']/items/item[@is-active]">
		<span class="active"><xsl:value-of select="." /></span>
	</xsl:template>

	<xsl:template match="udata[@module = 'system' and @method = 'numpages']/toprev_link">
		<a href="{.}" class="toprev_link"><span>&system_numpages_toprev_link;</span></a>
	</xsl:template>

	<xsl:template match="udata[@module = 'system' and @method = 'numpages']/tonext_link">
		<a href="{.}" class="tonext_link"><span>&system_numpages_tonext_link;</span></a>
	</xsl:template>


	<xsl:template match="total" mode="show_more">
		<xsl:param name="total" select="." />
		<xsl:param name="per_page" select="../per_page" />
		<div class="pagination_wrap">
			<xsl:apply-templates select="document(concat('udata://system/numpages/', $total, '/', $per_page, '/'))/udata[items]" mode="show_more"/>
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'system' and @method = 'numpages']" mode="show_more">
		<xsl:apply-templates select="tonext_link" mode="show_more"/>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'system' and @method = 'numpages']/tonext_link" mode="show_more">
		<a href="{.}" class="showmore__button btn-show_more js-show_more" data-num="{@page-num}">
			<span>
				<xsl:text>Показать еще</xsl:text>
			</span>
		</a>
	</xsl:template>
	
</xsl:stylesheet>