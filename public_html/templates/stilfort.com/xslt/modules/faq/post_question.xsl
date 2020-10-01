<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/faq/category.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:xlink="http://www.w3.org/TR/xlink">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="result[@module = 'faq' and @method = 'post_question']">
		<div class="content center_div">
			<div class="left_col"> 
				<div class="v_card">
					<div class="title">Сделать заказ</div>
					<div class="code">8 (495)</div>
					<div class="phone">961-2101</div>
				</div>
				<xsl:call-template name="faq_form">
					<xsl:with-param name="id" select="$pId" />
				</xsl:call-template>
			</div> 
			<div class="right_col">
				<h1>Спасибо за Ваш вопрос</h1>
				<div>
					<div style="text-align:right">Мы ответим Вам в ближайшее время.<br /><br/><hr/>С уважением,<br/>Администрация сайта <b>mf-catering.ru</b></div>
				</div>
			</div>
			<div class="cl"></div>
		</div>
	</xsl:template>
	

</xsl:stylesheet>