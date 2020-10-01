<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="result[@module = 'users' and @method = 'registrate_done']">
		<div id="users_registrate">
			<h1>&users_registrate_do_h1;</h1>
			<div>
				<xsl:apply-templates select="document('udata://users/registrate_done')/udata"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="udata[@method = 'registrate_done']">
		<xsl:choose>
			<xsl:when test="result = 'without_activation'">
				<p>
					<xsl:text>&registration-done;</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="result = 'error'">
				<p>
					<xsl:text>&registration-error;</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="result = 'error_user_exists'">
				<p>
					<xsl:text>&registration-error-user-exists;</xsl:text>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p>
					<xsl:text>&registration-done;</xsl:text>
				</p>
				<p>
					<xsl:text>&registration-activation-note;</xsl:text>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>