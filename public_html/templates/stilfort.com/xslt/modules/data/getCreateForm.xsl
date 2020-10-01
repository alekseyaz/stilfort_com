<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/data/getCreateForm.xsl'">
	<!ENTITY module_method	"@module = 'data' and @method = 'getCreateForm'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="udata[&module_method;]">
		<div class="FormsGroup">
			<xsl:apply-templates select="document('udata://system/listErrorMessages/')/udata" />
			<xsl:apply-templates select="group" />
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]/group">
		<div class="group">
			<div class="title"><xsl:value-of select="@title" /></div>
			<xsl:apply-templates select="field" />
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]/group/field[@type = 'string']">
		<div class="field">
			<input type="text" name="{@input_name}" class="text {@required} {@name}" placeholder="{@title}">
				<xsl:if test="@required"><xsl:attribute name="class">required</xsl:attribute></xsl:if>
			</input>
			<div class="field_error">Поле заполнено неправильно</div>
		</div>
	</xsl:template>

</xsl:stylesheet>