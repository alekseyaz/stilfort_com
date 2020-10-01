<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="result[@module = 'dispatches'][@method = 'subscribe_do']">
		<xsl:apply-templates select="document('udata://dispatches/subscribe_do/')/udata" />
	</xsl:template>

	<xsl:template match="udata[@module = 'dispatches'][@method = 'subscribe_do']">
		<xsl:apply-templates select="result" mode="subscribe_do" />
	</xsl:template>

	<xsl:template match="udata[@module = 'dispatches'][@method = 'subscribe_do'][unsubscribe_link]">
		<xsl:if test="$user-type = 'guest'">
			<p>&dispatch-you-to;.</p>
			<p>&dispatch-unsubscribe; <a href="{unsubscribe_link}">&dispatch-unsubscribe-part;</a>.</p>
		</xsl:if>
	</xsl:template>

	<xsl:template match="result" mode="subscribe_do">
		<xsl:choose>
			<xsl:when test="$user-type != 'guest'">
				<p>&dispatch-you-from;.</p>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="result[@class = 'error']" mode="subscribe_do">
		<p><xsl:value-of select="."/></p>
	</xsl:template>

	<xsl:template match="result[items]" mode="subscribe_do">
		<p>&dispatch-you-to;:</p>
		<ul><xsl:apply-templates select="items" mode="subscribe_do" /></ul>
	</xsl:template>

	<xsl:template match="items" mode="subscribe_do">
		<li><xsl:value-of select="." disable-output-escaping="yes" /></li>
	</xsl:template>

</xsl:stylesheet>