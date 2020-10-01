<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[

]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/TR/xlink">

	<xsl:output method="html" indent="yes"/>

	
	<xsl:template match="item|page" mode="short_view">
		<xsl:variable name="page" select="document(concat('upage://', @id))/udata/page" />
		<div class="result__cell result__cell-{position()}" data-id="{@id}">
			<xsl:if test="$result/page/@id = '53'">
				<span class="favorite__remove tooltip" data-id="{@id}" title="Удалить из избанного"></span>
			</xsl:if>
			<div class="result__top">
				<div class="result__icons">
					<div class="result__like">
						<a href="#" data-id="{@id}" class="tooltip" title="В избранное">
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"><defs><style>.cls-1{fill:#101820;}</style></defs><title/><g data-name="Layer 54" id="Layer_54"><path class="cls-1" d="M16,28.72a3,3,0,0,1-2.13-.88L3.57,17.54a8.72,8.72,0,0,1-2.52-6.25,8.06,8.06,0,0,1,8.14-8A8.06,8.06,0,0,1,15,5.68l1,1,.82-.82h0a8.39,8.39,0,0,1,11-.89,8.25,8.25,0,0,1,.81,12.36L18.13,27.84A3,3,0,0,1,16,28.72ZM9.15,5.28A6.12,6.12,0,0,0,4.89,7a6,6,0,0,0-1.84,4.33A6.72,6.72,0,0,0,5,16.13l10.3,10.3a1,1,0,0,0,1.42,0L27.23,15.91A6.25,6.25,0,0,0,29,11.11a6.18,6.18,0,0,0-2.43-4.55,6.37,6.37,0,0,0-8.37.71L16.71,8.8a1,1,0,0,1-1.42,0l-1.7-1.7a6.28,6.28,0,0,0-4.4-1.82Z"/></g></svg>
						</a>
					</div>
					<div class="result__compare">
						<a href="#" data-id="{@id}" class="tooltip" title="В сравнение">
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M1 4h2v2H1V4zm4 0h14v2H5V4zM1 9h2v2H1V9zm4 0h14v2H5V9zm-4 5h2v2H1v-2zm4 0h14v2H5v-2z"/></svg>
						</a>
					</div>
				</div>
				<xsl:choose>
					<xsl:when test="not($page//property[@name='common_quantity']/value[1]&gt;0)">
						<div class="result__tip result__notinstock">
							<span>Ожидается</span>
						</div>
					</xsl:when>
					<xsl:when test="$page//property[@name='novinka']/value/item/@name = 'Да'">
						<div class="result__tip result__new">
							<span>Новинка</span>
						</div>
					</xsl:when>
					<!--<xsl:when test="$page//property[@name='novinka']">
						<div class="result__tip result__new">
							<span>Новинка</span>
						</div>
					</xsl:when>-->
					<xsl:when test="$page//property[@name='hit']">
						<div class="result__tip result__hit">
							<span>Хит</span>
						</div>
					</xsl:when>
					<!--<xsl:when test="$page//property[@name='skidka']">
						<div class="result__tip result__sale">
							<span>Акция</span>
						</div>
					</xsl:when>-->
					<xsl:when test="$page//property[@name='cena_so_skidkoj']/value&gt;0">
						<div class="result__tip result__sale">
							<span>Акция</span>
						</div>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
				
				<!--<xsl:choose>
					<xsl:when test="$page//property[@name='stoimost_new']">
						<div class="result__price">
							<xsl:apply-templates select="$page//property[@name='stoimost_new']/value" mode="cena"/>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<div class="result__price">
							<xsl:apply-templates select="$page//property[@name='stoimost']/value" mode="cena"/>
						</div>
					</xsl:otherwise>
				</xsl:choose>-->
			</div>
			<a href="{@link}">
				<div class="result__image">
					<img src="{document(concat('udata://system/makeThumbnailFull/(', $page//property[@name='photo']/value[1]/@path,')/210/auto///'))/udata/src}" alt="{$page//property[@name='photo']/value[1]/@alt}"/>
				</div>
			</a>
			<div class="result__bottom">
				<div class="result__name">
					<a href="{@link}">
						<xsl:value-of select="$page/name" />
					</a>
				</div>
				<div class="result__article">
					<xsl:value-of select="$page//property[@name='artikul']/value" />
				</div>
				<xsl:choose>
					<xsl:when test="$page//property[@name='price']">
						<xsl:apply-templates select="$page//property[@name='price']" mode="stoimost" />
					</xsl:when>
					<!--<xsl:when test="$page//property[@name='stoimost_new']">
						<xsl:apply-templates select="$page//property[@name='stoimost_new']" mode="stoimost" />
					</xsl:when>-->
					<xsl:otherwise>
						<xsl:apply-templates select="$page//property[@name='stoimost']" mode="stoimost" />
					</xsl:otherwise>
				</xsl:choose>
				<!-- <div class="result__button">
					<a href="{@link}">
						<span>Где купить</span>
						<div class="pin__icon">
							<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" id="pin-destination-map-location" style="enable-background:new 0 0 10.134 15.626;" version="1.1" viewBox="0 0 10.134 15.626" xml:space="preserve"><path d="M7.873,0.853c-1.705-1.137-3.908-1.137-5.612,0C0.065,2.316-0.638,5.167,0.626,7.484l4.441,8.142l4.441-8.142  C10.772,5.167,10.07,2.316,7.873,0.853z M8.631,7.006l-3.563,6.533L1.504,7.006C0.49,5.146,1.053,2.859,2.816,1.685  C3.5,1.229,4.283,1,5.067,1s1.567,0.228,2.251,0.684C9.081,2.859,9.645,5.146,8.631,7.006z"/><path d="M5.067,2.083c-1.378,0-2.5,1.122-2.5,2.5s1.122,2.5,2.5,2.5s2.5-1.122,2.5-2.5S6.446,2.083,5.067,2.083z M5.067,6.083  c-0.827,0-1.5-0.673-1.5-1.5s0.673-1.5,1.5-1.5s1.5,0.673,1.5,1.5S5.894,6.083,5.067,6.083z"/></svg>
						</div>
					</a>
				</div> -->
			</div>
		</div>
	</xsl:template>



	
</xsl:stylesheet>