<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'content' and page/@type-id='175']">
		<xsl:call-template name="navibar" />
		

		
		<section class="results">
			<div class="wrapper">
				<div class="results__content">
					<div class="results__header">
						<div class="results__title h2">
							<xsl:value-of select=".//property[@name = 'h1']/value" />
						</div>
					</div>
					<xsl:apply-templates select="document('udata://catalog/getObjectsByFlag//8///novinka/')/udata" mode="str_novinki"/>
				</div>
			</div>
		</section>
	</xsl:template>
	
	
	
	
		<!--str_novinki-->
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']" mode="str_novinki"/>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag' and lines/item]" mode="str_novinki">
		<xsl:apply-templates select="lines" mode="str_novinki"/>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines" mode="str_novinki">
	     <div class="results__list">
			  <xsl:apply-templates select="item" mode="novinki_glavnaya"/>
          </div>
		  <xsl:apply-templates select="../total" mode="show_more"/>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines/item" mode="str_novinki">
	   <xsl:apply-templates select="." mode="short_view"/>
	</xsl:template>


</xsl:stylesheet>