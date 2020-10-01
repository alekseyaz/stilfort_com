<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/system/captcha.xsl'">
]>

<!-- Need HTML Formating-->
<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="udata[@module = 'system' and @method = 'captcha']" />
	<xsl:template match="udata[@module = 'system' and @method = 'captcha' and url]">
		<div class="template_system_captcha">
			<label>
				<span class="title">&system-enter-captcha;:</span>
				<span class="input captcha"><input type="text" name="captcha" class="text captcha" /></span>
				<span class="image"><img src="{url}{url/@random-string}" /></span>
			</label>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'system' and @method = 'captcha' and count(recaptcha-url) > 0]">
		<div>
			<label>
				<!--<script src='{recaptcha-url}?hl=ru'></script>-->
				<div class="{recaptcha-class}" data-sitekey="{recaptcha-sitekey}"></div>
			</label>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'system' and @method = 'captcha']" mode="scripts"/>
	
	<xsl:template match="udata[@module = 'system' and @method = 'captcha' and count(recaptcha-url) > 0]" mode="scripts">
		<script>
		var onloadCallback = function() {
			$('.g-recaptcha').each(function (i, captcha) {
				grecaptcha.render(captcha, {
					'sitekey' : '{recaptcha-sitekey}'
				});
			});
		};
		</script>
		<script src="{recaptcha-url}?onload=onloadCallback&amp;render=explicit" async="async" defer="defer"></script>
	</xsl:template>
</xsl:stylesheet>