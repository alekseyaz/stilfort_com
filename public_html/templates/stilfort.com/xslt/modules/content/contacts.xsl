<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'content' and page/@alt-name = 'kontakty']">
		<!--
		<div id="content_content">
			<h1><xsl:value-of select=".//property[@name = 'h1']/value" /></h1>
			<div>
				<xsl:value-of select=".//property[@name = 'content']/value" disable-output-escaping="yes" />
			</div>
		</div>
		-->
		
		<xsl:call-template name="navibar" />
		  <xsl:apply-templates select="$homepage//group[@name='kontakty']" mode="page_kontakty" />
          <xsl:apply-templates select="document('udata://webforms/add/141')/udata" />


	</xsl:template>
	
	
	
		<!--page_kontakty-->
	<xsl:template match="group" mode="page_kontakty">
	 <section class="contacts contacts__single">
        <div class="wrapper">
            <div class="contacts__content">
                <div class="contacts__left">
                    <div class="contacts__title h2">Как нас найти</div>

                    <div class="contacts__list">
					  <xsl:apply-templates select=".//property[starts-with(@name,'contact_')]" mode="contacts" />
                

                    <div class="contacts__button">
                        <div class="button">
                        <a href="#modalCallback" class="popup-modal">Заказать звонок</a>
                        </div>
                    </div>
                    </div>
                </div>
                  <xsl:apply-templates select=".//property[@name='map']" mode="contact_map" />
            </div>
        </div>
      </section> 
	</xsl:template>


</xsl:stylesheet>