<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/custom/getInstagramInfo.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="udata[@module = 'custom' and @method = 'getInstagramInfo']">
		<xsl:apply-templates select="items"/>
	</xsl:template>
	<xsl:template match="udata[@module = 'custom' and @method = 'getInstagramInfo']/items">
		<div class="insta__slider carousel__slider">
			<xsl:apply-templates select="item"/>
		</div>
	</xsl:template>
	<xsl:template match="udata[@module = 'custom' and @method = 'getInstagramInfo']/items/item">
	    <div class="carousel__slide">
            <div class="carousel__image">
              <img src="{@img}" alt=""/>
            </div>
        </div>
		<!--<div class="col-xs-12 col-sm-12 col-lg-6">
			<a href="https://www.instagram.com/p/{@shortcode}/" target="_blank">
				<div class="insta__imgwrapper t-animate t-animate_started">
					<div class="insta__hover-wrapper">
						<div class="insta__hover-filter"></div>
						<div class="insta__text t-text t-descr_xxs">
							<xsl:value-of select="@text" disable-output-escaping="yes" />
						</div>
					</div>
					<div class="insta__bgimg" style="background-image:url('{@img}')"></div>
				</div>
			</a>
		</div>-->
	</xsl:template>

	
</xsl:stylesheet>