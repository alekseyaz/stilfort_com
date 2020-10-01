<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/webforms/add.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="udata[@module = 'webforms' and @method = 'add']">
	<div id="form_{/udata/@form_id}" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Заголовок модального окна -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<xsl:choose>
						<xsl:when test="/udata/@form_id = 125">
							<h4 class="modal-title">Заказ товара</h4>
						</xsl:when>
						<xsl:otherwise>
							<h4 class="modal-title">Обратный звонок</h4>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<!-- Основное содержимое модального окна -->
				<div class="modal-body">

					<form class="contact-form" method="post" action="/webforms/sendmsg/"  enctype="multipart/form-data">
						<div id="contactFormWrapper">
							<xsl:apply-templates select="items/item[@selected]" mode="address" />
							<xsl:apply-templates select="groups/group" mode="webforms" />
							<input type="hidden" name="system_form_id" value="{/udata/@form_id}" />
							<input type="hidden" name="ref_onsuccess" value="/webforms/posted/" />
							<!--<div class="form_element">
								<xsl:apply-templates select="document('udata://system/captcha/')/udata" />
							</div>-->
							<div class="form_element hidden">
								<input name="telefon" type="text" class="full forma" maxlength="255" value="2" />
								<input name="captcha" type="text" value=""/>
							</div>
							<div class="status"></div>
							<div class="btn-toolbar form-group">
								<input type="submit" id="contactFormSubmit" value="Отправить" class="btn btn-primary"/>
							</div>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>

	</xsl:template>
	
	<xsl:template match="group" mode="webforms">
		<div class="row">
			<xsl:apply-templates select="field[@type!='text']"/>
		</div>
		<div class="row">
			<xsl:apply-templates select="field[@type='text']"/>
		</div>
	</xsl:template>

	

	
	<xsl:template match="field">
		<div class="col-sm-6 form-group">
			<label class="sr-only"><xsl:value-of select="@title" /></label>
			<input type="text" name="{@input_name}" id="field_{@id}" class="form-control" placeholder="{@title}"/>
		</div>
	</xsl:template>
                
	<xsl:template match="field[@required]">
		<div class="col-sm-6 form-group">
			<label class="sr-only"><xsl:value-of select="@title" /></label>
			<input type="text" name="{@input_name}" id="field_{@id}" class="form-control {@required}" data-validate="notEmpty" placeholder="{@title}"/>
		</div>
	</xsl:template>

	<xsl:template match="field[@name='email']">
		<div class="col-sm-6 form-group">
			<label class="sr-only"><xsl:value-of select="@title" /></label>
			<input type="text" name="{@input_name}" id="field_{@id}" class="form-control {@required}" data-validate="email" placeholder="{@title}"/>
		</div>
	</xsl:template>
	
	<xsl:template match="field[@type = 'text']">
		<div class="col-xs-12 form-group">
			<label class="sr-only"><xsl:value-of select="@title" /></label>
			<textarea name="{@input_name}" id="field_{@id}" class="form-control" placeholder="{@title}"></textarea>
		</div>
	</xsl:template>

	<xsl:template match="field[@type = 'text' and @required]">
		<div class="col-xs-12 form-group">
			<label class="sr-only"><xsl:value-of select="@title" /></label>
			<textarea name="{@input_name}" id="field_{@id}" class="form-control {@required}" data-validate="notEmpty" placeholder="{@title}"></textarea>
		</div>
	</xsl:template>
	
	<xsl:template match="field[@name='tovar' or @name='link']">
		<div class="col-sm-6 form-group">
			<input type="text" name="{@input_name}" id="field_{@id}" class="form-control" placeholder="{@title}"/>
		</div>
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

	<xsl:template match="item" mode="address_select">
		<option value="{@id}"><xsl:apply-templates /></option>
	</xsl:template>
	
</xsl:stylesheet>