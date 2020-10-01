<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY idetntify_fields	"field[@name = 'login' or @name = 'e-mail' or @name = 'password']">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="result[@module = 'users' and @method = 'settings']">
		<div id="users_settings">
			<h1>&users_settings_h1;</h1>
			<div>
				<xsl:apply-templates select="document('udata://users/settings/')/udata[user_id]" />
			</div>
		</div>
		
	</xsl:template>
	
	<xsl:template match="udata[@module = 'users' and @method = 'settings']" />

	<xsl:template match="udata[@module = 'users' and @method = 'settings' and user_id]">
		<form id="registrate" enctype="multipart/form-data" method="post" action="{$lang-prefix}/users/settings_do/">
			<xsl:apply-templates select="document(concat('udata://data/getEditForm/', $user-id))"  mode="settings"/>
			<div class="fields">
				<div class="field">
					<label for="login"><em>*</em>Логин: </label>
					<input class="required" name="login" value="{$user-info//property[@name = 'login']/value}" type="text" disabled="disabled"/>
				</div>
				<div class="field">
					<label for="login"><em>*</em>Пароль: </label>
					<input class="required" name="password" value="" type="password"/>
				</div>
				<div class="field">
					<label for="login"><em>*</em>Подтверждение пароля: </label>
					<input class="required" name="password_confirm" value="" type="password"/>
				</div>
				<div class="field">
					<label for="login"><em>*</em>E-mail: </label>
					<input class="required" name="email" value="{$user-info//property[@name = 'e-mail']/value}" type="text" disabled="disabled"/>
				</div>
			</div>

			<xsl:apply-templates select="$captcha" />
				<div class="buttons-set">
					<p class="required"><em>*</em> Обязательные поля</p>
					<button type="submit" title="Отправить" class="button"><span><span>Отправить</span></span></button>
				</div>
		</form>
	</xsl:template>
	



</xsl:stylesheet>