<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/system/numpages.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template name="navibar">
     <div class="scrumbs">
      <div class="wrapper">
        <div class="scrumbs__content">
         <ul class="scrumbs__List">
					
			<li><a href="/">Главная</a></li>
			<xsl:apply-templates select="/result//parents/page" mode="navibar" />
			<xsl:choose>
				<xsl:when test="/result/page/name">
					<li>
					  <span><xsl:value-of select="/result/page/name" disable-output-escaping="yes"/></span>
					</li>
				</xsl:when>
				<xsl:otherwise>
					<li>
					  <span><xsl:value-of select="/result/@header" disable-output-escaping="yes"/></span>
					</li>
				</xsl:otherwise>
			</xsl:choose>
			
		 </ul>
        </div>
       </div>
      </div>
	</xsl:template>

	<xsl:template match="//page" mode="navibar">
		<li>
		  <a href="{@link}"><xsl:value-of select="name" disable-output-escaping="yes"/></a>
		</li>
	</xsl:template>



</xsl:stylesheet>