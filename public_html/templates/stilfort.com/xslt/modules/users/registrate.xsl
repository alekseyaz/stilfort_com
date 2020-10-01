<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY idetntify_fields	"field[@name = 'login' or @name = 'e-mail' or @name = 'password']">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="result[@module = 'users' and @method = 'registrate']">
		<div id="users_registrate">
			<h1>&users_registrate_h1;</h1>
			<div>
				<xsl:apply-templates select="document('udata://users/registrate/')/udata[type_id]" />
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'users' and @method = 'registrate']" />
	
	<xsl:template match="udata[@module = 'users' and @method = 'registrate' and type_id]">
		<form id="registrate" enctype="multipart/form-data" method="post" action="{$lang-prefix}/users/registrate_do/">
		
			<xsl:apply-templates select="document('udata://system/listErrorMessages/')/udata" />
			
			<!-- Поля идентификации -->
			<xsl:apply-templates select="document(concat('utype://', type_id))/udata//group[@name = 'idetntify_data']" mode="users_registrate" />
			
			<!-- Данные пользователя -->
			<xsl:apply-templates select="document(concat('udata://data/getCreateForm/', type_id))/udata/group" />
			
			<div class="users_registrate_submit">
				<xsl:apply-templates select="$captcha" />
				<input type="submit" class="submit" value="&users_registrate_submit;" />
			</div>
		</form>
	</xsl:template>
	

<!-- Поля идентификации -->
	<xsl:template match="group[@name = 'idetntify_data']" mode="users_registrate">
		<div class="fields">
			<xsl:apply-templates select="&idetntify_fields;" mode="users_registrate" />
		</div>
	</xsl:template>
	
	<xsl:template match="field[type/@data-type = 'string']" mode="users_registrate">
		<div class="field">
			<label><xsl:if test="@required"><xsl:attribute name="class">required</xsl:attribute></xsl:if>
				<xsl:value-of select="@title" />:
			</label>
			<input type="text" name="{@name}" class="text" />
		</div>
	</xsl:template>
	<xsl:template match="field[@name = 'e-mail']" mode="users_registrate">
		<div class="field">
			<label><xsl:if test="@required"><xsl:attribute name="class">required</xsl:attribute></xsl:if>
				<xsl:value-of select="@title" />:
			</label>
			<input type="text" name="email" class="text" />
		</div>
	</xsl:template>
	<xsl:template match="field[type/@data-type = 'password']" mode="users_registrate">
		<div class="field">
			<label class="required"><xsl:if test="@required"><xsl:attribute name="class">required</xsl:attribute></xsl:if>
				<xsl:value-of select="@title" />:
			</label>
			<input type="password" name="{@name}" class="text" />
		</div>
		<div class="field">
			<label class="required">
				&users_registrate_password_confirm_title;:
			</label>
			<input type="password" name="{&users_registrate_password_confirm_name;}" class="text" />
		</div>
	</xsl:template>
<!-- //Поля идентификации -->

</xsl:stylesheet>