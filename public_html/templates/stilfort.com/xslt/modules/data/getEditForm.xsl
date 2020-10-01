<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/data/getEditForm.xsl'">
	<!ENTITY module_method	"@module = 'data' and @method = 'getEditForm'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="udata[&module_method;]">
		<div class="FormsGroup">
			<xsl:apply-templates select="document('udata://system/listErrorMessages/')/udata" />
			<xsl:apply-templates select="group[not(field/@type = 'relation') or (field[@type = 'relation']//item)]" />
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]/group">
		<div class="group">
			<div class="title"><xsl:value-of select="@title" /></div>
			<xsl:apply-templates select="field" />
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]//field[@type = 'string']">
		<div class="field">
			<input type="text" name="{@input_name}" class="text {@required} {@name}" placeholder="{@title}">
				<xsl:if test="@required"><xsl:attribute name="class">required</xsl:attribute></xsl:if>
			</input>
			<div class="field_error">Поле заполнено неправильно</div>
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]//field[@type = 'text']">
		<div class="field">
			<textarea type="text" name="{@input_name}" class="text {@required} {@name}" placeholder="{@title}">
				<xsl:if test="@required"><xsl:attribute name="class">required</xsl:attribute></xsl:if>
			</textarea>
			<div class="field_error">Поле заполнено неправильно</div>
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]//field[@type = 'relation']">
		<div class="field">
			<label title="{@tip}"><xsl:if test="@required"><xsl:attribute name="class">required</xsl:attribute></xsl:if>
				<span class="title"><xsl:value-of select="@title" />:</span>
				<select name="{@input_name}">
					<xsl:apply-templates select="values/item" />
				</select>
			</label>
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]//field[@type = 'relation']//item">
		<option value="{@id}"><xsl:value-of select="." /></option>
	</xsl:template>


	
	
	
	
	<xsl:template match="udata[&module_method;]" mode="settings">
			<xsl:apply-templates select="document('udata://system/listErrorMessages/')/udata" />
			<xsl:apply-templates select="group[not(field/@type = 'relation') or (field[@type = 'relation']//item)]" mode="settings"/>
	</xsl:template>

	<xsl:template match="udata[&module_method;]/group" mode="settings">
			<xsl:apply-templates select="field" mode="settings"/>
	</xsl:template>
	
	<xsl:template match="udata[&module_method;]/group[@title='specify_delivery_address']" mode="settings">
		<dl>
			<xsl:apply-templates select="field[position() mod 2 = 1]" mode="settings"/>
			<xsl:apply-templates select="field[position() mod 2 = 0]" mode="settings"/>
		</dl>
	</xsl:template>
	
	<xsl:template match="udata[&module_method;]//field[@type = 'string']" mode="settings">
		<div class="{@required} form-group">
			<label for="{@name}"><xsl:value-of select="@title" /> <xsl:if test="@required"><sup>*</sup></xsl:if></label>
			<input class="is_required validate form-control {@required}" data-validate="isName" id="{@name}" name="{@input_name}" value="{.}" type="text"/>
		</div>
	</xsl:template>

	
	<xsl:template match="udata[&module_method;]//field[@type = 'string' and (@name='telefon' or @name='fname')]" mode="settings">
		<div class="{@required} form-group">
			<label for="{@name}"><xsl:value-of select="@title" /> <xsl:if test="@required"><sup>*</sup></xsl:if></label>
			<input class="is_required validate form-control {@required}" data-validate="isName" id="{@name}" name="{name}" value="{.}" type="text" disabled="disabled"/>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[&module_method;]//field[@type = 'string' and @name='father_name']" mode="settings"/>
	<xsl:template match="udata[&module_method;]//field[@type = 'text']" mode="settings">
		4<div class="template_data_getEditForm_field">
			<label title="{@tip}"><xsl:if test="@required"><xsl:attribute name="class">required</xsl:attribute></xsl:if>
				<span class="title"><xsl:value-of select="@title" />:</span>
				<span class="input"><textarea name="{@input_name}"></textarea></span>
			</label>
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]//field[@type = 'relation']" mode="settings">
		5<div class="template_data_getEditForm_field">
			<label title="{@tip}"><xsl:if test="@required"><xsl:attribute name="class">required</xsl:attribute></xsl:if>
				<span class="title"><xsl:value-of select="@title" />:</span>
				<select name="{@input_name}">
					<xsl:apply-templates select="values/item" mode="settings"/>
				</select>
			</label>
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]//field[@type = 'relation']//item" mode="settings">
		6<option value="{@id}"><xsl:value-of select="." /></option>
	</xsl:template>
</xsl:stylesheet>