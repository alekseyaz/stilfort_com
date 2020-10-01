<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'notfound']">
		<xsl:call-template name="navibar" />
		<section class="flagmans">
			<div class="wrapper">
				<div class="flagmans__content">
					<div class="flagmans__title h2"><xsl:value-of select="/result/@header"/></div>
					
					<div class="field-text field_content">
						<p>Здравствуйте, уважаемый посетитель.</p>
						<p>К сожалению, запрашиваемой Вами страницы не существует на нашем сайте.</p>
						<p>Возможно, это случилось по одной из этих причин:</p>
						<ul>
							<li>Вы ошиблись при наборе адреса страницы (URL)</li>
							<li>Перешли по &quot;битой&quot; (неработающей) ссылке</li>
							<li>Запрашиваемой страницы никогда не было на сайте или она была удалена</li>
						</ul>
						<p>Мы просим прощения за доставленные неудобства и предлагаем следующие пути:</p>
						<ul>
							<li>Вернуться назад при помощи кнопки браузера &quot;back&quot;</li>
							<li>Проверить правильность написания адреса страницы (URL)</li>
							<li>Перейти на <a href="/">главную страницу сайта</a></li>
							<li>Воспользоваться <a href="/content/sitemap/">картой сайта</a></li>
						</ul>
					</div>
				</div>
			</div>
		</section>
	</xsl:template>
	
</xsl:stylesheet>