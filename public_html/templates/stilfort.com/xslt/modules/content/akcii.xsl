<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'content' and page/@type-id = '168']">
		<xsl:call-template name="navibar" />

		<section class="results">
			<div class="wrapper">
				<div class="results__content">
					<div class="results__header">
						<div class="results__title h2">
							<xsl:value-of select=".//property[@name = 'h1']/value" />
						</div>
					</div>
					
					<xsl:apply-templates select="document('udata://catalog/getObjectsByFlag//8///cena_so_skidkoj/')/udata" mode="str_novinki"/>
					<!--<xsl:apply-templates select=".//property[@name='akcionnye_tovary']" mode="akcionnye_tovary"/>-->

				</div>
			</div>
		</section>
	</xsl:template>

	<xsl:template match="property" mode="akcionnye_tovary">
		<div class="results__list">
			<xsl:apply-templates select="value/page" mode="akcionnye_tovary"/>
		</div>
	</xsl:template>
	
	<xsl:template match="property/value/page" mode="akcionnye_tovary">
		<xsl:variable name="element" select="document(concat('upage://', @id))/udata"/>
		<xsl:apply-templates select="$element" mode="short_view"/>
	</xsl:template>
	
</xsl:stylesheet>