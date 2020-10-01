<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="udata[@module = 'comments' and @method = 'insert']">
		<div class="comments">
			<xsl:apply-templates select="items" />
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'comments' and @method = 'insert']/items">
		<div class="items">
			<xsl:apply-templates select="item" />
		</div>
		<xsl:call-template name="numpages" />
	</xsl:template>

	<xsl:template match="udata[@module = 'comments' and @method = 'insert']/items/item">
		<xsl:variable name="author" select="document(concat('udata://users/viewAuthor/', @author_id))/udata" />
		<div class="item">
			<div class="name"><xsl:value-of select="$author/nickname" /></div>
			<div class="email"><xsl:value-of select="$author/email" /></div>
			<div class="date"><xsl:apply-templates select="$author//property[@name = 'publish_time']" /></div>
			<div class="anons"><xsl:value-of select="." /></div>
		</div>
	</xsl:template>


	<xsl:template name="comments_add_form">
		<xsl:param name="action" select="/udata/add_form" />
		<form method="post" action="{$action}">
			<label><input type="text" name="author_nick" value="Имя" /></label>
			<label><input type="text" name="author_email" value="Электронная почта" /></label>
			<label><textarea name="comment">Текст комментария</textarea></label>
			<label><input class="submit" type="submit" value="Добавить комментарий" /></label>
		</form>
	</xsl:template>


</xsl:stylesheet>