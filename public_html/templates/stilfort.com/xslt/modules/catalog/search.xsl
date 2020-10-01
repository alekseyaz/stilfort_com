<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY module_method	"@module = 'catalog' and @method = 'search'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="udata[&module_method;]" />
	<xsl:template match="udata[&module_method; and group]">
		<div id="catalog_search">
			<form action="" method="get">
				<xsl:apply-templates select="group" />
				<input type="submit" value="Отобрать" />
			</form>
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]/group">
		<div class="catalog_search_group">
			<xsl:apply-templates select="field" />
		</div>
	</xsl:template>


<!-- Need Refacoring-->
	<xsl:template match="udata[&module_method;]//field">
		<div>
			<label>
				<span><xsl:value-of select="@title" /></span>
				<span><input type="text" name="fields_filter[{@name}]" value="{value}" class="textinputs" /></span>
			</label>
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]//field[@data-type = 'relation' or @data-type = 'symlink']">
		<div>
			<label>
				<span><xsl:value-of select="@title" /></span>
				<select name="fields_filter[{@name}]">
					<option />
					<xsl:apply-templates select="values/item" />
				</select>
			</label>
		</div>
	</xsl:template>

	<xsl:template match="udata[&module_method;]//field/values/item">
		<option value="{@id}"><xsl:value-of select="." /></option>
	</xsl:template>

	<xsl:template match="udata[&module_method;]//field[@data-type = 'boolean']">
		<div>
			<label>
				<input type="checkbox" name="fields_filter[{@name}]" value="1">
					<xsl:if test="checked">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>
				</input>
				<xsl:value-of select="@title" />
			</label>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[&module_method;]//field[@data-type = 'price' or @data-type = 'int' or @data-type = 'float']">
		<div>
			<label class="value_from">
				<span><xsl:value-of select="@title" /></span>
				<span> от:</span>
				<span><input type="text" name="fields_filter[{@name}][0]" value="{value_from}" class="textinputs" /></span>
			</label>
			<label class="value_to">
				<span>до:</span>
				<span><input type="text" name="fields_filter[{@name}][1]" value="{value_to}" class="textinputs" /></span>
			</label>
		</div>
	</xsl:template>



</xsl:stylesheet>