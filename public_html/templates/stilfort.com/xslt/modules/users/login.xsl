<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY user_is_authorised	"boolean(document('udata://users/auth/')/udata[user_id])">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="result[@module = 'users' and @method = 'login']">
		<div id="users_activate">
			<h1>&users_login_h1;</h1>
			<div>
				<xsl:apply-templates select="document('udata://users/login/')/udata" />
			</div>
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'users' and @method = 'login']">
		<form action="/users/login_do/" method="post">
			<label for="login"><b>Логин:</b></label><br />
			<input type="text" id="login" name="login" class="textinputs" value=""/><br />
			<label for="password"><b>Пароль:</b></label><br />
			<input type="password" id="password" name="password" class="textinputs" value=""/><br />
			<p>
				<input type="submit" value="Вход"/>
			</p>
			<input style="display:none;" type="hidden" name="from_page" value="{$_http_referer}" />
		</form>
		<p>Если Вы еще не зарегистрированы на сайте, Вы можете <a href="/users/registrate/" class="sub">зарегистрироваться</a>.</p>
		<p>Если Вы забыли пароль, Вы можете <a href="/users/forget/" class="sub">воспользоваться сервисом восстановления пароля</a>.</p>
	</xsl:template>

	<xsl:template match="udata[@module = 'users' and @method = 'login' and &user_is_authorised;]">
		<xsl:value-of select="document('udata://content/redirect/(/users/settings/)')" />
	</xsl:template>

	
	<xsl:template match="result[@method = 'login' or @method = 'login_do' or @method = 'loginza' or @method = 'auth']">
			<div id="template_users_activate">
			<h1>&users_login_h1;</h1>
			<div>
		<xsl:if test="@not-permitted = 1">
			<p><xsl:text>&user-not-permitted;</xsl:text></p>
		</xsl:if>
		<xsl:if test="user[@type = 'guest'] and (@method = 'login_do' or @method = 'loginza')">
			<p><xsl:text>&user-reauth;</xsl:text></p>
		</xsl:if>
		<xsl:apply-templates select="document('udata://users/login/')/udata" />
					</div>
		</div>
	</xsl:template>
</xsl:stylesheet>