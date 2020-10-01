<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="/">
		<xsl:apply-templates select="udata"/>
	</xsl:template>
	<xsl:template match="udata">
		<xsl:apply-templates select="items"/>
	</xsl:template>
	<xsl:template match="items">
		<xsl:apply-templates select="item"/>
	</xsl:template>
	
	<xsl:template match="item">
		<div class="dealer__popup">
			<div class="dealer__name">
				<xsl:value-of select="@name" disable-output-escaping="yes" />
			</div>
			<div class="dealer__info">
				<xsl:apply-templates select=".//property[@name = 'address']" mode="dealer__address"/>
				<xsl:apply-templates select=".//property[@name = 'tel']" mode="dealer__tel"/>
				<xsl:apply-templates select=".//property[@name = 'hours']" mode="dealer__hours"/>
			</div>
			<xsl:apply-templates select=".//property[@name = 'site']" mode="dealer__site"/>
		</div>
	</xsl:template>

	
	<xsl:template match="property" mode="dealer__address">
		<div class="dealer__address">
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>
	</xsl:template>
	
	<xsl:template match="property" mode="dealer__tel">
		<div class="dealer__tel">
			<xsl:text>Тел.: </xsl:text>
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>
	</xsl:template>
	
	<xsl:template match="property" mode="dealer__hours">
		<div class="dealer__hours">
			<xsl:text>Часы работы: </xsl:text>
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>
	</xsl:template>
	
	<xsl:template match="property" mode="dealer__site">
		<div class="dealer__site">
			<a href="https://{value}">
				<xsl:value-of select="value" disable-output-escaping="yes" />
			</a>
		</div>
	</xsl:template>
</xsl:stylesheet>