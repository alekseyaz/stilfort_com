<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/search/search_do.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="result[@module = 'search' and @method = 'search_do']">
		<xsl:call-template name="navibar" />

		<section class="results catalog">
			<div class="wrapper">
				<div class="catalog__content">
					<div class="catalog__title h2">
						&search_search_do_h1;
					</div>
				</div>
				<div class="results__content">
					<xsl:apply-templates select="document('udata://search/search_do')/udata" />
				</div>
			</div>
		</section>
	</xsl:template>

	<xsl:template match="udata[@module = 'search' and @method = 'search_do']">
		
		<!--<form class="search" action="/search/search_do/" method="get">
			<input type="text" value="{$search_string}" name="search_string" class="textinputs" />
			<input type="submit" class="button" value="Найти" />
		</form>-->
		
		<xsl:apply-templates select="items" />
	</xsl:template>

	<xsl:template match="udata[@module = 'search' and @method = 'search_do']/items">
		<div class="results__header">
			<xsl:text>&search_search_do_title;</xsl:text>
			<xsl:value-of select="$search_string" />
			<xsl:text>&search_search_do_nothing;</xsl:text>
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'search' and @method = 'search_do']/items[item]">
		<div class="results__header">
			<xsl:text>&search_search_do_title;</xsl:text>
			<xsl:value-of select="$search_string" />
			<xsl:text>&search_search_do_founded;</xsl:text>
			<xsl:value-of select="../total" />
		</div>
		<div class="results__list">
			<xsl:apply-templates select="item" />
		</div>
		<xsl:apply-templates select="../total" mode="show_more"/>
	</xsl:template>

	
	<xsl:template match="udata[@module = 'search' and @method = 'search_do']/items/item">
		<xsl:apply-templates select="." mode="short_view"/>
	</xsl:template>




</xsl:stylesheet>