<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<!-- Default menu -->
	<xsl:template match="udata[@module = 'content' and @method = 'menu']">
		<xsl:param name="menuId" select="0" />
		<xsl:param name="class" />
		<div class="template_menu {$class}">
			<xsl:apply-templates select="items"><xsl:with-param name="menuId" select="$menuId" /></xsl:apply-templates>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'content' and @method = 'menu']//items">
		<xsl:param name="menuId" select="0" />
		<ul>
			<xsl:apply-templates select="item"><xsl:with-param name="menuId" select="$menuId" /></xsl:apply-templates>
		</ul>
	</xsl:template>

	<xsl:template match="udata[@module = 'content' and @method = 'menu']//item">
		<xsl:param name="menuId" select="0" />
		<li>
			<a href="{@link}"><xsl:value-of select="@name" /></a>
			<xsl:apply-templates select="items"><xsl:with-param name="menuId" select="@id" /></xsl:apply-templates>
		</li>
	</xsl:template>

	<xsl:template match="udata[@module = 'content' and @method = 'menu']//item[@status = 'active']">
		<xsl:param name="menuId" select="0" />
		<li class="active">
			<a href="{@link}"><xsl:value-of select="@name" /></a>
			<xsl:apply-templates select="items"><xsl:with-param name="menuId" select="@id" /></xsl:apply-templates>
		</li>
	</xsl:template>

	<xsl:template match="udata[@module = 'content' and @method = 'menu']//item[last()]">
		<xsl:param name="menuId" select="0" />
		<li class="last">
			<a href="{@link}"><xsl:value-of select="@name" /></a>
			<xsl:apply-templates select="items"><xsl:with-param name="menuId" select="@id" /></xsl:apply-templates>
		</li>
	</xsl:template>

	<xsl:template match="udata[@module = 'content' and @method = 'menu']//item[@status = 'active' and position() = last()]">
		<xsl:param name="menuId" select="0" />
		<li class="active last">
			<a href="{@link}"><xsl:value-of select="@name" /></a>
			<xsl:apply-templates select="items"><xsl:with-param name="menuId" select="@id" /></xsl:apply-templates>
		</li>
	</xsl:template>
	<!-- //Default menu -->	




</xsl:stylesheet>