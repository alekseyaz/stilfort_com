<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umi="http://www.umi-cms.ru/TR/umi" xmlns:php="http://php.net/xsl" xmlns:xlink="http://www.w3.org/TR/xlink">
	
	
	
	<!-- tovari_v_razdele -->
	<xsl:template match="udata[@method = 'getSmartCatalog']">
	</xsl:template>
	<xsl:template match="udata[@method = 'getSmartCatalog'][lines/item]">
	    <xsl:apply-templates select="lines"/>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'getSmartCatalog']/lines">
		<div class="results__list">
			<xsl:apply-templates select="item" mode="short_view"/>
		</div>
		<xsl:apply-templates select="../total" mode="show_more"/>
	</xsl:template>
	
	
	<xsl:template match="udata[@method = 'getSmartCatalog']/lines/item">
		<xsl:apply-templates select="." mode="short_view"/>
	</xsl:template>
	
	<!-- Drugie tovari -->
	
	<xsl:template match="udata[@method = 'getSmartCatalog'][lines/item]" mode="drugie_tovari">
		<div class="products__more">
			<div class="more__title h2">Другие товары</div>
			<div class="slider__navigation slider__navigation-more">
				<div class="slider__button slider__prev slick-arrow more__slider-prev">
					<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px" width="23px" height="23px" viewBox="0 0 306 306" style="enable-background:new 0 0 306 306;" xml:space="preserve">
						<g>
							<g id="keyboard-arrow-right">
								<polygon points="58.65,267.75 175.95,153 58.65,35.7 94.35,0 247.35,153 94.35,306   "/>
							</g>
						</g>
					</svg>
				</div>
				<div class="slider__button slider__next slick-arrow more__slider-next">
					<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px" width="23px" height="23px" viewBox="0 0 306 306" style="enable-background:new 0 0 306 306;" xml:space="preserve">
						<g>
							<g id="keyboard-arrow-right">
								<polygon points="58.65,267.75 175.95,153 58.65,35.7 94.35,0 247.35,153 94.35,306   "/>
							</g>
						</g>
					</svg>
				</div>
			</div>
			<xsl:apply-templates select="lines" mode="drugie_tovari"/>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'getSmartCatalog']/lines" mode="drugie_tovari">
<!-- 		 <div class="results__list more__slider more__slider-desktop">
			<xsl:apply-templates select="item[not(@id=$result/page/@id)]" mode="short_view"/>
		</div> -->
		<div class="results__list more__slider more__slider-mobile">
		   <xsl:apply-templates select="item[not(@id=$result/page/@id)]" mode="short_view"/>
		</div>
	</xsl:template>


	<xsl:template match="udata[@method = 'getOtherPage']" mode="drugie_tovari"/>
	<xsl:template match="udata[@method = 'getOtherPage'][items/item]" mode="drugie_tovari">
		<div class="products__more">
			<div class="more__title h2">Другие товары</div>
			<div class="slider__navigation slider__navigation-more">
				<div class="slider__button slider__prev slick-arrow more__slider-prev">
					<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px" width="23px" height="23px" viewBox="0 0 306 306" style="enable-background:new 0 0 306 306;" xml:space="preserve">
						<g>
							<g id="keyboard-arrow-right">
								<polygon points="58.65,267.75 175.95,153 58.65,35.7 94.35,0 247.35,153 94.35,306   "/>
							</g>
						</g>
					</svg>
				</div>
				<div class="slider__button slider__next slick-arrow more__slider-next">
					<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px" width="23px" height="23px" viewBox="0 0 306 306" style="enable-background:new 0 0 306 306;" xml:space="preserve">
						<g>
							<g id="keyboard-arrow-right">
								<polygon points="58.65,267.75 175.95,153 58.65,35.7 94.35,0 247.35,153 94.35,306   "/>
							</g>
						</g>
					</svg>
				</div>
			</div>
			<xsl:apply-templates select="items" mode="drugie_tovari"/>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'getOtherPage']/items" mode="drugie_tovari">
		 <!-- <div class="results__list more__slider more__slider-desktop">
			<xsl:apply-templates select="item[not(@id=$result/page/@id)]" mode="short_view"/>
		</div> -->
		<div class="results__list more__slider more__slider-mobile">
		   <xsl:apply-templates select="item[not(@id=$result/page/@id)]" mode="short_view"/>
		</div>
	</xsl:template>
	
	
	
	

	<xsl:template match="udata[@method = 'getPageByCollection']" mode="drugie_tovari"/>
	<xsl:template match="udata[@method = 'getPageByCollection'][items/item]" mode="drugie_tovari">
		<div class="products__more">
			<div class="more__title h2">Товары этой коллекции</div>
			<div class="slider__navigation slider__navigation-more">
				<div class="slider__button slider__prev slick-arrow more__slider-prev">
					<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px" width="23px" height="23px" viewBox="0 0 306 306" style="enable-background:new 0 0 306 306;" xml:space="preserve">
						<g>
							<g id="keyboard-arrow-right">
								<polygon points="58.65,267.75 175.95,153 58.65,35.7 94.35,0 247.35,153 94.35,306   "/>
							</g>
						</g>
					</svg>
				</div>
				<div class="slider__button slider__next slick-arrow more__slider-next">
					<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px" width="23px" height="23px" viewBox="0 0 306 306" style="enable-background:new 0 0 306 306;" xml:space="preserve">
						<g>
							<g id="keyboard-arrow-right">
								<polygon points="58.65,267.75 175.95,153 58.65,35.7 94.35,0 247.35,153 94.35,306   "/>
							</g>
						</g>
					</svg>
				</div>
			</div>
			<xsl:apply-templates select="items" mode="drugie_tovari"/>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'getPageByCollection']/items" mode="drugie_tovari">
		<div class="results__list more__slider more__slider-mobile">
		   <xsl:apply-templates select="item[not(@id=$result/page/@id)]" mode="short_view"/>
		</div>
	</xsl:template>
</xsl:stylesheet>