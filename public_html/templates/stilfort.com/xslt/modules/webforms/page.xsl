<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:php="http://php.net/xsl"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:umi="http://www.umi-cms.ru/TR/umi"
	extension-element-prefixes="php"
	exclude-result-prefixes="php">
	
	<!--Cтраница контактов-->
    <xsl:template match="result[@module = 'webforms'][@method = 'page']">
		<div>
			<div class="wsite-multicol">
				<div class="wsite-multicol-table-wrap" style="margin:0 -20px;">
					<table class="wsite-multicol-table">
						<tbody class="wsite-multicol-tbody">
							<tr class="wsite-multicol-tr">
								<td class="wsite-multicol-col" style="width:58%; padding:0 20px;">
									<xsl:value-of select=".//property[@name = 'content']/value" disable-output-escaping="yes" />
									
									<xsl:apply-templates select="document(concat('udata://webforms/add/', .//property[@name = 'form_id']/value))/udata" mode="feedback"/>
								</td>
								<td class="wsite-multicol-col" style="width:42%; padding:0 20px;">
									<div class="r_col"><xsl:apply-templates select=".//group[@name='contacts']"/></div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
    </xsl:template>

	 <xsl:template match="group[@name='contacts']">
		<xsl:apply-templates select="property"/>
	 </xsl:template>
	 
	 <xsl:template match="group[@name='contacts']/property[@type='string']">
		<div style="text-align:left;">
			<font size="2" style="font-weight: normal;">
				<b><xsl:value-of select="title" disable-output-escaping="yes" />:</b> &nbsp; <xsl:value-of select="value" disable-output-escaping="yes" />
			</font>
		</div>
<!-- 		<div class="paragraph" style="text-align:left;">
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div> -->
	 </xsl:template>

	 <xsl:template match="group[@name='contacts']/property[@type='text']">
		<div class="wsite-map">
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>
	 </xsl:template>

</xsl:stylesheet>