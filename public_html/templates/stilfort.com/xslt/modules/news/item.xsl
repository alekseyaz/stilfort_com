<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/news/item.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'news' and @method = 'item']">
	   <xsl:call-template name="navibar" />
		   <section class="results news">
			<div class="wrapper">
				<div class="results__content">

					
					<div class="row">
					    <div class="hidden-xs hidden-sm col-xs-12 col-md-3">
					        <xsl:apply-templates select="document('udata://news/lastlents/0//100/1/')/udata" mode="root_lents"/>
                            </div>
					     <div class="col-xs-12 col-md-9" >
					<div class="results__header">
						<div class="results__title h2">
							<xsl:value-of select=".//property[@name = 'h1']/value" />
						</div>
			
					</div>
                                  <xsl:apply-templates select=".//property[@name='publish_pic']"  mode="news_publish_pic"/>

                                   <div  class="field-text field_content">
					            <xsl:value-of select=".//property[@name = 'content']/value" disable-output-escaping="yes" />
				           </div>
					
					<xsl:apply-templates select=".//property[@name='produkciya_v_proekte']"  mode="produkciya_v_proekte"/>
					
					<xsl:apply-templates select="$settings//property[@name = 'share']"/>

						 <xsl:apply-templates select="document(concat('udata://news/lastlist/',parents/page[1]/@id,'//5////10/?extProps=name,anons_pic,publish_time'))/udata" mode="last_news"/>
                        </div>
				</div>
			</div>
			</div>
		</section>		
	   

	</xsl:template>
	
	
	<xsl:template match="property"  mode="produkciya_v_proekte">		
		<div class="products__more">
			<div class="more__title h2">
			<xsl:value-of select="../property[@name='produkciya_v_proekte']/title" disable-output-escaping="yes" />:
			</div>
			
			<xsl:apply-templates select="value"  mode="produkciya_v_proekte"/>
		</div>
	</xsl:template>
	
	
	<xsl:template match="value"  mode="produkciya_v_proekte">
	  <div class="results__list">
	    <xsl:apply-templates select="page"  mode="produkciya_v_proekte"/>
		</div>
	</xsl:template>
	
	<xsl:template match="page"  mode="produkciya_v_proekte">
		<xsl:apply-templates select="."  mode="short_view"/>
	</xsl:template>
	
	
	<xsl:template match="property"  mode="news_publish_pic">
		<div class="product_gallery">
							  
			<img src="{value}" alt="{value/@alt}" class="maxw"/>
	     </div>
	</xsl:template>

</xsl:stylesheet>