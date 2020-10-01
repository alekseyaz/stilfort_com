<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="result[@module = 'photoalbum'][@method = 'photo']">
		<div id="photo" class="gray_block">
			<!--<xsl:call-template name="catalog-thumbnail">
				<xsl:with-param name="element-id" select="$document-page-id" />
				<xsl:with-param name="field-name">photo</xsl:with-param>
				<xsl:with-param name="empty">&empty-photo;</xsl:with-param>
				<xsl:with-param name="width">495</xsl:with-param>
			</xsl:call-template>-->
						<!--<xsl:choose>
							<xsl:when test="value/@width &lt; value/@height">
								<img src="{document(concat('udata://system/makeThumbnailFull/(.',$page//property[@name='photo']/value,')/auto/',$photoCatalogH,'/notemplate/0/1/100'))/udata/src}" alt="{$page/name}" class="{concat('catalog-img-', generate-id())}" />
							</xsl:when>
							<xsl:otherwise>
								<img src="{document(concat('udata://system/makeThumbnailFull/(.',$page//property[@name='photo']/value,')/',$photoCatalogW,'/auto/notemplate/0/1/100'))/udata/src}" alt="{$page/name}" class="{concat('catalog-img-', generate-id())}" />
							</xsl:otherwise>
						</xsl:choose>-->
			<xsl:apply-templates select="document(concat('udata://photoalbum/album/',page/@parentId,'//1000'))/udata/items/item[@id = $document-page-id]" mode="slider" />
		</div>
		<div>
			<xsl:value-of select="//property[@name = 'descr']/value" disable-output-escaping="yes" />
		</div>
		<div>
			<a href="{parents/page[last()]/@link}">&show-photo;</a>
		</div>
<!--		<div class="social">
			<div class="plusone">
				<div class="g-plusone" data-size="small" data-count="true"></div>
			</div>
			<script type="text/javascript">
				jQuery(document).ready(function(){ jQuery.getScript('//yandex.st/share/share.js', function() {
			new Ya.share({
				'element': 'ya_share1',
				'elementStyle': {
					'type': 'button',
					'linkIcon': true,
					'border': false,
					'quickServices': ['yaru', 'vkontakte', 'facebook', 'twitter', 'odnoklassniki', 'moimir', 'lj']
				},
				'popupStyle': {
					'copyPasteField': true
				}
			 });
					});
				});
			</script>
			<span id="ya_share1"></span>
		</div>-->
	</xsl:template>

</xsl:stylesheet>