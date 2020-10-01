<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'sitemap']">
		<xsl:call-template name="navibar" />
		<section class="flagmans">
			<div class="wrapper">
				<div class="flagmans__content">
					<div class="flagmans__title h2"><xsl:value-of select="/result/@header"/></div>
					
					<div class="field-text field_content">
						<xsl:apply-templates select="document('udata://content/sitemap')/udata/items" />
					</div>
				</div>
			</div>
		</section>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'sitemap' and @method = 'sitemap']//items">
		<ul id="{parent::node()/@id}" class="sitemap">
			<xsl:apply-templates select="item" />
		</ul>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'sitemap' and @method = 'sitemap']//item">
		<li>
			<a href="{@link}"><xsl:value-of select="@name" /></a>
			<xsl:apply-templates select="items" />
		</li>
	</xsl:template>

</xsl:stylesheet>