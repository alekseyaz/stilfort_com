<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/webforms/add.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:xlink="http://www.w3.org/TR/xlink">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="udata[@module = 'webforms' and @method = 'add']">
		<section class="contacts__feedback">
			<div class="wrapper">
				<div class="feedback__content">
					<div class="feedback__form">
						<form action="/webforms/send/" method="post" enctype="multipart/form-data" id="feedBackform" class="js-form form_{@form_id}">
							<xsl:value-of select="res_to" disable-output-escaping="yes" />
							<input type="hidden" name="system_form_id" value="{/udata/@form_id}" />
							<input type="hidden" name="ref_onsuccess" value="/webforms/posted/" />
							<xsl:apply-templates select="items" mode="address" />

							<div class="form__title">Форма обратной связи</div>
							<div class="form__top">
								<xsl:apply-templates select="//field[not(@type = 'text')]" />
							</div>
							<div class="form__bottom">
								<xsl:apply-templates select="//field[@type = 'text']" />
							</div>
							<div class="status"></div>
							<div class="form__options">
								<div class="contacts__button">
									<div class="button">
										<a href="#" class="js-submit">Отправить</a>
									</div>
								</div>
								<xsl:call-template name="agree"/>
							</div>
						</form>
					</div>
				</div>
			</div>
		</section>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'webforms' and @method = 'add']" mode="modalCallback">
		<section class="modal modal__callback mfp-hide" id="modalCallback">
			<div class="wrapper">
				<div class="modal__content">
					<div class="modal__title h2">Заказать звонок</div>
					<form action="" class="form js-modal-form">
							<xsl:value-of select="res_to" disable-output-escaping="yes" />
							<input type="hidden" name="system_form_id" value="{/udata/@form_id}" />
							<input type="hidden" name="ref_onsuccess" value="/webforms/posted/" />
							<xsl:apply-templates select="items" mode="address" />
						<div class="form__top">
							<xsl:apply-templates select="//field" />
						</div>
						<div class="status"></div>
						<div class="form__bottom">
							<input type="submit" placeholder="Отправить" value="Отправить" class="js-submit"/>
						</div>
					</form>
					<div class="modal__close popup-modal-dismiss">
						<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="25px" height="25px" viewBox="0 0 17 17" version="1.1">
							<defs/>
							<g id="Icons" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" stroke-linecap="round">
								<g id="24-px-Icons" transform="translate(-364.000000, -124.000000)" stroke="#000000">
									<g id="ic_cancel" transform="translate(360.000000, 120.000000)">
										<g id="cross">
											<g transform="translate(5.000000, 5.000000)" stroke-width="2">
												<path d="M0,0 L14.1421356,14.1421356" id="Line"/>
												<path d="M14,0 L1.77635684e-15,14" id="Line"/>
											</g>
										</g>
									</g>
								</g>
							</g>
						</svg>
					</div>
				</div>
			</div>
		</section>
	</xsl:template>
	

	<xsl:template match="items" mode="address">
		<xsl:apply-templates select="item" mode="address" />
	</xsl:template>

	<xsl:template match="item" mode="address">
		<input type="hidden" name="system_email_to" value="{@id}" />
	</xsl:template>

	<xsl:template match="items[count(item) &gt; 1]" mode="address">
		<xsl:choose>
			<xsl:when test="count(item[@selected='selected']) != 1">
				<div class="form_element">
					<label class="required">
						<span><xsl:text>Кому отправить:</xsl:text></span>
						<select name="system_email_to">
							<option value=""></option>
							<xsl:apply-templates select="item" mode="address_select" />
						</select>
					</label>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="item[@selected='selected']" mode="address" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>