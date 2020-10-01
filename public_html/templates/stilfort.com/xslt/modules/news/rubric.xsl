<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/news/rubric.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'news' and @method = 'rubric']">
	   <xsl:call-template name="navibar" />
            <section class="results news">
			<div class="wrapper">
				<div class="results__content">
					<div class="results__header">
						<div class="results__title h2">
							<xsl:value-of select=".//property[@name = 'h1']/value" />
						</div>
			
					</div>
					
					<div class="row">
					    <div class="col-xs-12 col-md-push-3 col-md-9">
								<xsl:apply-templates select="document(concat('udata://news/lastlist/',page/@id,'//////10/?extProps=name,anons_pic,publish_time'))/udata" mode="news_lent"/>
						</div>
					     <div class="col-xs-12 col-md-pull-9 col-md-3 mt20 hidden-sm">
							<xsl:apply-templates select="document('udata://news/lastlents/0//100/1/')/udata" mode="root_lents"/>
					     </div>
                     </div>
				</div>
			</div>
		</section>		
	</xsl:template>



</xsl:stylesheet>