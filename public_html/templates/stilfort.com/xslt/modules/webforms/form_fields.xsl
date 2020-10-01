<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	
	<xsl:template match="field">
		<div class="form__input">
			<label for="field_{@id}"><xsl:value-of select="@title" /></label>
			<input type="text" name="{@input_name}" id="field_{@id}" class="">
				<xsl:apply-templates select="." mode="placeholder"/>
				<xsl:apply-templates select="." mode="required"/>
			</input>
		</div>
	</xsl:template>

	<xsl:template match="field[@required]">
		<div class="form__input">
			<label for="field_{@id}"><xsl:value-of select="@title" /></label>
			<input type="text" name="{@input_name}" id="field_{@id}" class="">
				<xsl:apply-templates select="." mode="placeholder"/>
				<xsl:apply-templates select="." mode="required"/>
			</input>
		</div>
	</xsl:template>

	<xsl:template match="field[@name = 'phone']">
		<div class="form__input">
			<label for="field_{@id}"><xsl:value-of select="@title" /></label>
			<input type="text" name="{@input_name}" id="field_{@id}" class="" placeholder="+7 (___) ___-__-__">
				<!--<xsl:apply-templates select="." mode="placeholder"/>-->
				<xsl:apply-templates select="." mode="required"/>
			</input>
		</div>
	</xsl:template>
	
	<xsl:template match="field[@name='email']">
		<div class="form__input">
			<label for="field_{@id}"><xsl:value-of select="@title" /></label>
			<input type="email" name="{@input_name}" id="field_{@id}" class="form-control email">
				<xsl:apply-templates select="." mode="placeholder"/>
				<xsl:apply-templates select="." mode="required"/>
			</input>
		</div>
	</xsl:template>
	
	<xsl:template match="field[@type = 'text']">
		<div class="form__textarea">
			<label for="field_{@id}"><xsl:value-of select="@title" /></label>
			<textarea name="{@input_name}" id="field_{@id}" class="" cols="30" rows="10">
				<xsl:apply-templates select="." mode="placeholder"/>
				<xsl:apply-templates select="." mode="required"/>
			</textarea>
		</div>
	</xsl:template>

	<xsl:template match="field[@type = 'text' and @required]">
		<div class="form__textarea">
			<label for="field_{@id}"><xsl:value-of select="@title" /></label>
			<textarea name="{@input_name}" id="field_{@id}" class="" cols="30" rows="10">
				<xsl:apply-templates select="." mode="placeholder"/>
				<xsl:apply-templates select="." mode="required"/>
			</textarea>
		</div>
	</xsl:template>
	
	
	
	<xsl:template match="field[@type='file' or @name='link']">
		<div class="title-group text-center">Прикрепите файлы</div>
		<div class="input-group none_file text-center">
			<label class="uploadbutton">
				<div class='input'></div>
				<input type="file" name="{@input_name}[]"/>
				<div class="add_file">+ Добавить файл</div>
			</label>
			<div class="removeline" title="Удалить файл">X</div>
		</div>
	</xsl:template>
	
	<xsl:template match="field[@type='relation']">
		<div class="form__input">
			<label for="field_{@id}"><xsl:value-of select="@title" /></label>
			<select name="{@input_name}" id="field_{@id}">
				<xsl:apply-templates select="." mode="required"/>
				<xsl:apply-templates select="values/item"/>
			</select>
		</div>
	</xsl:template>
	
	<xsl:template match="field[@type='relation']/values/item">
		<option value="{@id}">
			<xsl:value-of select="node()" disable-output-escaping="yes" />
		</option>
	</xsl:template>
</xsl:stylesheet>