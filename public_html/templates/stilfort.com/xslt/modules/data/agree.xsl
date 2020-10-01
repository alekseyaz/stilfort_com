<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:xlink="http://www.w3.org/TR/xlink">
	<xsl:output method="html" indent="yes"/>
	
	<xsl:template name="agree">
		<div class="form__privacy">
			<span>* Нажимая кнопку, вы соглашаетесь на <a href="{document(concat('upage://', $settings//property[@name='policy_page']/value/page/@id))}" class="yellow">обработку персональных данных</a></span>
		</div>
	</xsl:template>
	
</xsl:stylesheet>
