<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'content' and page/@id = '53']">
		<div class="scrumbs">
			<div class="wrapper">
				<xsl:call-template name="navibar" />
			</div>
		</div>
		<section class="results catalog favorit_content">
			<div class="wrapper">
				<div class="catalog__content">
					<div class="catalog__title h2">
						<xsl:value-of select=".//property[@name='h1']/value" />
					</div>
				</div>
				<div class="results__content">
					<xsl:apply-templates select="document('udata://content/getRecentPages//favorit/?extProps=name')/udata" mode="izbrannoe" />
				</div>
			</div>
		</section>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'getRecentPages']" mode="izbrannoe">
		<xsl:apply-templates select="items[item]" mode="izbrannoe" />
	</xsl:template>
	
	<xsl:template match="udata[@method = 'getRecentPages']/items" mode="izbrannoe">
		<div class="results__list">
			<xsl:apply-templates select="item" mode="izbrannoe" />
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'getRecentPages']/items/item" mode="izbrannoe">
		<xsl:apply-templates select="." mode="short_view"/>
	</xsl:template>

</xsl:stylesheet>