<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'content' and page/@id = '51']">
		<xsl:variable name="dealers" select="document('udata://custom/getDealers/?extProps=country,city,type,address,tel,hours,site,latitude,longitude')/udata"/>
		<div class="scrumbs">
			<div class="wrapper">
				<xsl:call-template name="navibar" />
			</div>
		</div>

		<section class="dealer dealer__single">
			<div class="wrapper">
				<div class="dealer__content">
					<div class="dealer__options">
						<div class="dealer__title h2">
							<xsl:value-of select=".//property[@name='h1']/value" />
						</div>
						<xsl:apply-templates select="$dealers" mode="dealer__selects"/>
					</div>
					<!--<div class="map__tips">
						<div class="map__tip map__tip-yellow">1</div>
						<div class="map__tip map__tip-white">1</div>
					</div>-->
					
					<!--<xsl:apply-templates select="$dealers" mode="dealer__popup"/>-->

				</div>
			</div>
			<div class="dealer__map" id="dealer__map" style="height:450px;">
				<!--<img src="/images/map__bg.jpg" alt=""/>-->
			</div>
		</section>
	</xsl:template>
	
	<xsl:template match="udata" mode="dealer__popup">
		<xsl:apply-templates select="items" mode="dealer__popup"/>
	</xsl:template>

	<xsl:template match="items" mode="dealer__popup">
		<xsl:apply-templates select="item" mode="dealer__popup"/>
	</xsl:template>

	<xsl:template match="item" mode="dealer__popup">
		<div class="dealer__popup">
			<div class="dealer__name">
				<xsl:value-of select="@name" disable-output-escaping="yes" />
			</div>
			<div class="dealer__info">
				<xsl:apply-templates select=".//property[@name = 'address']" mode="dealer__address"/>
				<xsl:apply-templates select=".//property[@name = 'tel']" mode="dealer__tel"/>
				<xsl:apply-templates select=".//property[@name = 'hours']" mode="dealer__hours"/>
			</div>
			<xsl:apply-templates select=".//property[@name = 'site']" mode="dealer__site"/>
		</div>
	</xsl:template>
	
	<xsl:template match="property" mode="dealer__address">
		<div class="dealer__address">
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>
	</xsl:template>
	
	<xsl:template match="property" mode="dealer__tel">
		<div class="dealer__tel">
			<xsl:text>Тел.: </xsl:text>
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>
	</xsl:template>
	
	<xsl:template match="property" mode="dealer__hours">
		<div class="dealer__hours">
			<xsl:text>Часы работы: </xsl:text>
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>
	</xsl:template>
	
	<xsl:template match="property" mode="dealer__site">
		<div class="dealer__site">
			<a href="https://{value}">
				<xsl:value-of select="value" disable-output-escaping="yes" />
			</a>
		</div>
	</xsl:template>
	
	
	
	<xsl:template match="udata" mode="dealer__selects">
		<xsl:apply-templates select="filter" mode="dealer__selects"/>
	</xsl:template>
	
	<xsl:template match="filter" mode="dealer__selects">
		<div class="dealer__selects">
			<xsl:apply-templates select="field" mode="dealer__selects"/>
		</div>
	</xsl:template>
	
	<xsl:template match="field" mode="dealer__selects">
		<div class="dealer__select">
			<select name="{@name}">
				<option value=""><xsl:value-of select="@title" disable-output-escaping="yes" /></option>
				<xsl:apply-templates select="value/item" mode="dealer__selects"/>
			</select>
		</div>
	</xsl:template>
	
	<xsl:template match="item" mode="dealer__selects">
		<option value="{@id}">
			<xsl:if test="@is-selected"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			<xsl:value-of select="@value" disable-output-escaping="yes" />
		</option>
	</xsl:template>
	
	<xsl:template match="udata" mode="points_data">
		<xsl:apply-templates select="items" mode="points_data"/>
	</xsl:template>

	<xsl:template match="items" mode="points_data">
		<script>var points={<xsl:apply-templates select="item" mode="points_data"/>};</script>
	</xsl:template>
<!--country,city,type,address,tel,hours,site,latitude,longitude-->
	<xsl:template match="item" mode="points_data">
		<!--<textarea><xsl:copy-of select="."/></textarea>-->
		<xsl:text>point_</xsl:text><xsl:value-of select="position()"/>:{location:[<xsl:value-of select=".//property[@name='latitude']/value"/><xsl:text>,</xsl:text><xsl:value-of select=".//property[@name='longitude']/value"/>
		<xsl:text>],name:'</xsl:text><xsl:value-of select="@name"/>
		<xsl:text>',country:'</xsl:text>
		<xsl:value-of select=".//property[@name='country']/value/item/@id"/>
		<xsl:text>',city:'</xsl:text>
		<xsl:value-of select=".//property[@name='city']/value/item/@id"/>
		<xsl:text>',type:'</xsl:text>
		<xsl:value-of select=".//property[@name='type']/value/item/@id"/>
		<xsl:text>',address:'</xsl:text>
		<xsl:value-of select=".//property[@name='address']/value"/>
		<xsl:text>',tel:'</xsl:text>
		<xsl:value-of select=".//property[@name='tel']/value"/>
		<xsl:text>',hours:'</xsl:text>
		<xsl:value-of select=".//property[@name='hours']/value"/>
		<xsl:text>',site:'</xsl:text>
		<xsl:value-of select=".//property[@name='site']/value"/>
		<xsl:text>'}</xsl:text>
		<xsl:if test="not(position() = last())"><xsl:text>,</xsl:text></xsl:if>
	</xsl:template>
</xsl:stylesheet>