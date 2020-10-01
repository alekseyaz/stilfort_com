<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="result[@module = 'users' and @method = 'activate']">
		<div id="users_activate">
			<h1>&users_activate_h1;</h1>
			<div>
				<xsl:apply-templates select="document('udata://users/activate')/udata" />
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'users' and @method = 'activate']">
		<xsl:text>&users_activate_content;</xsl:text>
	</xsl:template>

	<xsl:template match="udata[@module = 'users' and @method = 'activate' and error]">
		<xsl:apply-templates select="error" />
	</xsl:template>
	
	<xsl:template match="udata[@module = 'users' and @method = 'activate']/error">
		<div class="template_users_activate_error"><xsl:value-of select="." /></div>
	</xsl:template>


</xsl:stylesheet>