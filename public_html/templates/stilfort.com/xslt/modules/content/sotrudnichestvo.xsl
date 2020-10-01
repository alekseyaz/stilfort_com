<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'content' and page/@id = '63']">
		<xsl:call-template name="navibar" />
		<section class="flagmans">
			<div class="wrapper">
				<div class="flagmans__content">
					<div class="flagmans__title h2"><xsl:value-of select=".//property[@name = 'h1']/value" /></div>
					
					<xsl:apply-templates select=".//property[@name = 'content']"/>
					
				
				</div>
				<xsl:apply-templates select="document('udata://webforms/add/147')/udata" />
			</div>
		</section>
	</xsl:template>


</xsl:stylesheet>