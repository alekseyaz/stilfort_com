<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/system/thumbnail.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:xlink="http://www.w3.org/TR/xlink">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="udata[@module = 'custom' and @method = 'makeThumb']">
		<xsl:param name="alt" />
		<xsl:param name="element-id" />
		<xsl:param name="field-name" />
		<xsl:param name="class" />
		<img src="/images/j-lib/nophoto.gif" width="130" height="110">
			<xsl:if test="$class"><xsl:attribute name="class"><xsl:value-of select="$class" /></xsl:attribute></xsl:if>
			<xsl:if test="$element-id and $field-name">
				<xsl:attribute name="umi:element-id"><xsl:value-of select="$element-id" /></xsl:attribute>
				<xsl:attribute name="umi:field-name"><xsl:value-of select="$field-name" /></xsl:attribute>
			</xsl:if>
		</img>
	</xsl:template>

	<xsl:template match="udata[@module = 'custom' and @method = 'makeThumb' and src]">
		<xsl:param name="alt" />
		<xsl:param name="element-id" />
		<xsl:param name="field-name" />
		<xsl:param name="class" />
		<img src="{src}" width="{width}" height="{height}" alt="{$alt}" title="{$alt}">
			<xsl:if test="$element-id and $field-name">
				<xsl:attribute name="umi:element-id"><xsl:value-of select="$element-id" /></xsl:attribute>
				<xsl:attribute name="umi:field-name"><xsl:value-of select="$field-name" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$alt">
				<xsl:attribute name="alt"><xsl:value-of select="$alt" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$class"><xsl:attribute name="class"><xsl:value-of select="$class" /></xsl:attribute></xsl:if>
		</img>
	</xsl:template>

	<xsl:template match="udata[@method = 'makeThumb'][src]" mode="src">
		<xsl:value-of select="src" />
	</xsl:template>	



<!--
 ________EXAMPLE_______
<xsl:variable name="photo" select="$element//group[@name = 'photos']/property[@type = 'img_file'][1]" />
<xsl:apply-templates select="$photo">
	<xsl:with-param name="element" select="$element" /><xsl:with-param name="width" select="string('130')" /><xsl:with-param name="height" select="string('130')" /><xsl:with-param name="mode" select="string('canvas')" />
</xsl:apply-templates>
-->

	<xsl:template match="property[@type = 'img_file']">
		<xsl:param name="element" select="/result/page" />
		<xsl:param name="width" select="string('auto')" />
		<xsl:param name="height" select="string('auto')" />
		<xsl:param name="mode" select="string('fit')" />
		<xsl:param name="color" select="string('transparent')" />
		<xsl:param name="watermark" />
		<xsl:variable name="photo" select="value/@path" />
		<xsl:apply-templates select="document(concat('udata://custom/makeThumb/(', $photo, ')/', $width, '/', $height, '/', $mode, '/', $color, '/(', $watermark, ')/'))/udata">
			<xsl:with-param name="alt" select="$element/name" />
			<xsl:with-param name="element-id" select="$element/@id" />
			<xsl:with-param name="field-name" select="@name" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="property[@type = 'img_file']" mode="link">
		<xsl:param name="element" select="/result/page" />
		<xsl:param name="width" select="string('auto')" />
		<xsl:param name="height" select="string('auto')" />
		<xsl:param name="mode" select="string('fit')" />
		<xsl:param name="color" select="string('transparent')" />
		<xsl:param name="watermark" />
		<xsl:variable name="photo" select="value/@path" />
		<xsl:value-of select="document(concat('udata://custom/makeThumb/(', $photo, ')/', $width, '/', $height, '/', $mode, '/', $color, '/(', $watermark, ')/'))/udata/src" />
	</xsl:template>




<!-- Old Method ___
 ________EXAMPLE_______

<xsl:apply-templates select="document(concat('udata://custom/makeThumb/(', $element//property[@name = 'photo']/value/@path, ')/130/130/canvas/'))/udata">
	<xsl:with-param name="alt" select="$element/name" />
	<xsl:with-param name="element-id" select="$element/@id" />
	<xsl:with-param name="field-name" select="string('photo')" />
</xsl:apply-templates>
-->


</xsl:stylesheet>