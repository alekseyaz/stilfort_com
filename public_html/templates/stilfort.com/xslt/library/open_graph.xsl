<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	
    <xsl:template match="result" mode="open_graph">
		<xsl:apply-templates select="." mode="open_graph_locale"/>
		<meta property="og:type" content="website" />
		<meta property="og:site_name" content="{@site-name}"/>
		<meta property="og:url" content="https://{@domain}{@request-uri}" />
		<meta property="og:title" content="{@title}"/>
		<xsl:apply-templates select="." mode="open_graph_image"/>
		<xsl:apply-templates select="." mode="open_graph_description"/>
		<xsl:apply-templates select=".//group[@name='open_graph']/property" mode="open_graph"/>
    </xsl:template>

	<xsl:template match="result" mode="open_graph_locale">
		<meta property="og:locale" content="ru_RU"/>
	</xsl:template>
	
	<xsl:template match="result[@lang = 'hy']" mode="open_graph_locale">
		<meta property="og:locale" content="hy_AM"/>
	</xsl:template>
	
	<xsl:template match="result[@lang = 'ru']" mode="open_graph_locale">
		<meta property="og:locale" content="ru_RU"/>
	</xsl:template>
	
	<xsl:template match="result[@lang = 'en']" mode="open_graph_locale">
		<meta property="og:locale" content="en_US"/>
	</xsl:template>
	
	
	
	<xsl:template match="group[@name='open_graph']/property" mode="open_graph">
		<meta property="{title}" content="{value}"/>
	</xsl:template>
	
	<xsl:template match="group[@name='open_graph']/property[@title = 'og:image']" mode="open_graph">
		<meta property="og:image" content="https://{$result/@domain}{value}"/>
		<meta property="og:image:width" content="{value/@width}" />
		<meta property="og:image:height" content="{value/@height}" />
	</xsl:template>
	
	<xsl:template match="result" mode="open_graph_description"/>
	
	<xsl:template match="result[not(.//property[@title = 'og:desciption'])]" mode="open_graph_description">
		<meta property="og:desciption">
			<xsl:attribute name="content">
				<xsl:value-of select="meta/description"/>
			</xsl:attribute>
		</meta>
	</xsl:template>
	
	<xsl:template match="result[not(.//property[@title = 'og:desciption'])][@module='board' and @method='offer']" mode="open_graph_description">
		<meta property="og:desciption">
			<xsl:attribute name="content">
			<xsl:choose>
				<xsl:when test=".//property[substring-after(@name, 'descr')]">
					<xsl:value-of select=".//property[substring-after(@name, 'descr')][1]/value" disable-output-escaping="yes"/>
				</xsl:when>
				<xsl:when test=".//property[@name = 'anons']">
					<xsl:value-of select=".//property[@name = 'anons']/value" disable-output-escaping="yes"/>
				</xsl:when>
				<xsl:when test=".//property[@name = 'content']">
					<xsl:value-of select=".//property[@name = 'content']/value" disable-output-escaping="yes"/>
				</xsl:when>
				<xsl:when test=".//property[@name = 'h1']">
					<xsl:value-of select=".//property[@name = 'h1']/value" disable-output-escaping="yes"/>
				</xsl:when>
			</xsl:choose>
			</xsl:attribute>
		</meta>
	</xsl:template>
	
	<xsl:template match="result" mode="open_graph_image"/>
	<xsl:template match="result[not(.//property[@title = 'og:image'])][.//property[@name = 'photo']/value]" mode="open_graph_image">
		<meta property="og:image" content="https://{$result/@domain}{.//property[@name = 'photo']/value}"/>
		<meta property="og:image:width" content="{.//property[@name = 'photo']/value/@width}" />
		<meta property="og:image:height" content="{.//property[@name = 'photo']/value/@height}" />
	</xsl:template>
	
	
</xsl:stylesheet>
