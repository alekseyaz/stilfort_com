<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="utf-8"
				method="html"
				indent="yes"
				doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

	<xsl:variable name="document-title" select="/result/@title" />
	<xsl:variable name="document-keywords" select="/result/meta/keywords" />
	<xsl:variable name="document-description" select="/result/meta/description" />

	<xsl:variable name="errors"	select="document('udata://system/listErrorMessages')/udata"/>
	<xsl:variable name="lang-prefix" select="/result/@pre-lang" />
	<xsl:variable name="pId" select="/result/@pageId" />
	<xsl:variable name="result" select="/result" />

	<xsl:variable name="user-type" select="/result/user/@type" />
	<xsl:variable name="user-id" select="/result/user/@id" />
	<xsl:variable name="user-info" select="document(concat('uobject://', $user-id))" />
	<xsl:variable name="user_is_authorised" select="boolean(not($user-type = 'guest'))" />
	<xsl:variable name="is-admin" select="$user-type = 'sv' or $user-type = 'admin'" />
	
	<xsl:variable name="domain" select="/result/@domain" />
	<xsl:variable name="module" select="/result/@module | /udata/@module" />
	<xsl:variable name="method" select="/result/@method | /udata/@method" />
	<xsl:variable name="is_default" select="/result/page/@is-default" />
	
	<xsl:variable name="homepage" select="document('upage://1')/udata" />
	<xsl:variable name="settings" select="$homepage" />
	<xsl:variable name="captcha" select="document('udata://system/captcha/')/udata" />
	
	<xsl:param name="template-resources" />
	<xsl:param name="template-name" />
	<xsl:variable name="template" select="$template-resources" />

	<xsl:param name="_http_referer" />
	<xsl:param name="_request_uri" />

	<xsl:param name="debug">0</xsl:param>
	<xsl:param name="p">0</xsl:param>
	<xsl:param name="limit">8</xsl:param>
	<xsl:param name="search_string" />

	<xsl:variable name="extPropsObject" select="'extProps=name,photo,is_new,is_hit,is_sale,common_quantity,sku'"/>
	<xsl:variable name="extPropsNews" select="'extProps=name,publish_pic,publish_time,anons'"/>


	<xsl:include href="layouts/default.xsl" />
	<xsl:include href="modules/common.xsl" />
	<xsl:include href="library/common.xsl" />




	<xsl:template match="property[@type = 'date']">
		<xsl:param name="pattern" select="'d.m.Y'" />
		<xsl:value-of select="document(concat('udata://system/convertDate/', value/@unix-timestamp, '/(', $pattern, ')'))/udata" />
	</xsl:template>
	<xsl:decimal-format  name = "df"  grouping-separator = " "/>


    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyzабвгдеёжзиклмнопрстуфхцчшщъыьэюя'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZАБВГДЕЁЖЗИКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'" />

	<xsl:template name="upper">
		<xsl:param name="text"/>
		<xsl:value-of select="translate($text, $smallcase, $uppercase)" disable-output-escaping="yes"/>
	</xsl:template>
		
	<xsl:template name="lower">
		<xsl:param name="text"/>
		<xsl:value-of select="translate($text, $uppercase, $smallcase)" disable-output-escaping="yes"/>
	</xsl:template>
</xsl:stylesheet>