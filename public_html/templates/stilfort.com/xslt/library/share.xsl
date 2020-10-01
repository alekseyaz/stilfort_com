<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	
	<xsl:template match="property[@name = 'share']">
		<div class="pr15">
			<hr/>
			<div class="share mt15">
				<div style="display: inline-block;">Поделиться: </div>
				<xsl:value-of select="value" disable-output-escaping="yes" />
			</div>
			<hr/>
		</div>
		
	</xsl:template>
	
	<xsl:template match="property[@name = 'share']" mode="script">
		<script src="{$template}js/es5-shims.min.js"></script>
		<script src="{$template}js/share.js"></script>
	</xsl:template>
	
	
</xsl:stylesheet>
