<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[

]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsList']">
		<xsl:apply-templates select="lines"/>
	</xsl:template>

	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsList']/lines">
		<div id="catalog_getObjectsList" class="items">
			<xsl:apply-templates select="item" />
			<xsl:call-template name="numpages" />
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsList']/lines/item">
		<xsl:param name="element" select="document(concat('upage://', @id))/udata/page" />
		<div class="catalog_getObjectsList_item item">
			<div class="photo">
				<xsl:variable name="photo" select="$element//group[@name = 'photos']/property[@type = 'img_file'][1]" />
				<xsl:apply-templates select="$photo">
					<xsl:with-param name="element" select="$element" />
					<xsl:with-param name="width" select="string('130')" />
					<xsl:with-param name="height" select="string('130')" />
					<xsl:with-param name="mode" select="string('canvas')" />
				</xsl:apply-templates>
			</div>
			<div class="name"><a href="{$element/@link}"><xsl:value-of select="$element/name" /></a></div>
			<div class="price">
				<span class="value">
					<xsl:apply-templates select="document(concat('udata://emarket/price/',@id))"/>
				</span>
			</div>
		</div>
	</xsl:template>
	
</xsl:stylesheet>