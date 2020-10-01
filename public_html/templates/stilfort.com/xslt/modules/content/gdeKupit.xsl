<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'content' and page/@type-id = '169']">
		<xsl:call-template name="navibar" />
		<section class="flagmans">
			<div class="wrapper">
				<div class="flagmans__content">
					<div class="flagmans__title h2"><xsl:value-of select=".//property[@name = 'h1']/value" /></div>
					
					<xsl:apply-templates select=".//property[@name = 'content']"/>
					
					<xsl:apply-templates select="document('udata://content/getMarkets?extProps=nazvanie,adres,telefon,ssylka,gorod,logotip,to_top')/udata"/>
				</div>
			</div>
		</section>
	</xsl:template>

	<xsl:template match="udata[@method = 'getMarkets']">
		<div class="retail">
		<div class="mb30 retail-container">
			<xsl:apply-templates select="." mode="switcher"/>
			<xsl:apply-templates select="." mode="tab_content"/>
		</div>
		</div>
	</xsl:template>

	<xsl:template match="udata[@method = 'getMarkets']" mode="switcher">
		<div class="shops-switcher">
			<ul class="list-unstyled clearfix mt0 mb0">
				<xsl:apply-templates select="online" mode="switcher"/>
				<xsl:apply-templates select="retail" mode="switcher"/>
			</ul>
		</div>
	</xsl:template>
	
	<xsl:template match="online|retail" mode="switcher">
		<li class="pull-left">
			<xsl:if test="name() = 'online'">
				<xsl:attribute name="class">active pull-left</xsl:attribute>
			</xsl:if>
			<a class="padding" href="#{name()}" aria-controls="online" role="tab" data-toggle="tab">
				<xsl:value-of select="@name" />
			</a>
		</li>
	</xsl:template>
	<xsl:template match="udata[@method = 'getMarkets']" mode="tab_content">
		<div class="tab-content">
				<xsl:apply-templates select="online" mode="tab_content"/>
				<xsl:apply-templates select="retail" mode="tab_content"/>
		</div>
	</xsl:template>
	
	<xsl:template match="online|retail" mode="tab_content">
		<div class="tab-pane" id="{name()}">
			<xsl:if test="name() = 'online'">
				<xsl:attribute name="class">tab-pane active</xsl:attribute>
			</xsl:if>
			
				<xsl:apply-templates select="." mode="tab_content_in"/>
		</div>
	</xsl:template>
	
	<xsl:template match="online" mode="tab_content_in">
		<xsl:apply-templates select="item[(.//property[@name='to_top']/value = 1)]" mode="tab_content_to_top"/>
		<div class="row row-center no-gutters onhover">
			<xsl:apply-templates select="item[not(.//property[@name='to_top']/value = 1)]" mode="tab_content"/>
			<div class="col-xs-6 col-md-4 col-lg-3 retail-item mb30"/>
			<div class="col-xs-6 col-md-4 col-lg-3 retail-item mb30"/>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'getMarkets']/online/item" mode="tab_content_to_top">
		<div class="mt20 mb10">
			<div class="row row-center banner-on-store pt10 pb10 w100" onclick="location.href='{.//property[@name='ssylka']/value}';">
				<div class="col-sm-3 text-center">
					<img class="banner-link-logo img-fluid" src="{.//property[@name='logotip']/value}" alt="{.//property[@name='nazvanie']/value}"/>
				</div>

				<div class="col-md-9 banner-on-store__text">
					<small>
						<h2 class="mb5 mt15 text-center text-white"><xsl:value-of select=".//property[@name='nazvanie']/value"/></h2>
					</small>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'getMarkets']/online/item" mode="tab_content">
		<div class="col-xs-6 col-md-4 col-lg-3 retail-item mb30">
			<div class="retail-item-thumbnail text-center">
				<a href="{.//property[@name='ssylka']/value}" target="_blank">
					<img src="{.//property[@name='logotip']/value}" alt="{.//property[@name='nazvanie']/value}" class="maxw" />
				</a>
			</div>
		</div>
	</xsl:template>
	
	
	<xsl:template match="retail" mode="tab_content_in">
		<div class="single-shops">
			<xsl:apply-templates select="letters" mode="abc"/>
			<xsl:apply-templates select="letters" mode="cities"/>
		</div>
	</xsl:template>
	
	<xsl:template match="letters" mode="abc">
		<div class="abc clearfix">
			<span class="pull-left abc-title">Выбор по алфавиту:</span>
			<xsl:apply-templates select="letter" mode="abc">
				<xsl:sort select="@name"/>
			</xsl:apply-templates>
		</div>
	</xsl:template>
	
	<xsl:template match="letter" mode="abc">
		<!--<a class="pull-left text-center" href="#{@name}">
			<xsl:attribute name="href">
				<xsl:value-of select="concat('#', @name)" disable-output-escaping="yes" />
			</xsl:attribute>-->
		<xsl:text disable-output-escaping="yes" >&lt;a class="pull-left text-center" href="#</xsl:text><xsl:value-of select="@name" disable-output-escaping="yes" /><xsl:text disable-output-escaping="yes" >"&gt;</xsl:text>
			<xsl:value-of select="@name"/>
		<xsl:text disable-output-escaping="yes" >&lt;/a&gt;</xsl:text>
	</xsl:template>
	
	<xsl:template match="letters" mode="cities">
		<div class="cities">
			<xsl:apply-templates select="letter" mode="cities">
				<xsl:sort select="@name"/>
			</xsl:apply-templates>
		</div>
	</xsl:template>
	
	<xsl:template match="letter" mode="cities">
		<xsl:variable name="name" select="@name"/>
		<div class="city">
			<!--<a name="{php:function('urldecode', string(@name))}" id="{@name}-target">-->
			<!--<a name="{$name}" id="{@name}-target">
			
			<xsl:attribute name="name">
				<xsl:value-of select="concat('#', @name)" disable-output-escaping="yes" />
			</xsl:attribute>-->
			<xsl:text disable-output-escaping="yes" >&lt;a name="</xsl:text><xsl:value-of select="@name" disable-output-escaping="yes" /><xsl:text disable-output-escaping="yes" >" id="</xsl:text><xsl:value-of select="@name" disable-output-escaping="yes" /><xsl:text disable-output-escaping="yes" >-target"&gt;</xsl:text>
			<xsl:text disable-output-escaping="yes" >&lt;/a&gt;</xsl:text>
			<div class="row">
				<div class="col-sm-1">
					<div class="letter text-center pt15 pb15">
						<xsl:value-of select="@name"/>
					</div>
				</div>
				<div class="col-sm-11">
					<div class="city-names clearfix">
						<xsl:apply-templates select="gorod" mode="cities"/>
					</div>
					<xsl:apply-templates select="gorod" mode="cities_points"/>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="gorod" mode="cities">
		<a href="#" class="city-name padding pull-left mb5" data-city-id="#{@name}">
			<xsl:value-of select="@name"/>
		</a>
	</xsl:template>
	
	<xsl:template match="gorod" mode="cities_points">
		<xsl:variable name="gorod" select="@name"/>
		<div class="city-shops" id="{@name}">
			<xsl:apply-templates select="ancestor::retail/item[.//property[@name='gorod']/value = $gorod]" mode="tab_content"/>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'getMarkets']/retail/item" mode="tab_content">
		<div class="padding">
			
			<h4 class="mt0 mb10"><xsl:value-of select=".//property[@name='nazvanie']/value"/></h4>
			<xsl:if test=".//property[@name='adres']/value">
			<p class="mb0"><xsl:value-of select=".//property[@name='adres']/value"/></p>
			</xsl:if>
			<xsl:if test=".//property[@name='telefon']/value">
			<p class="mb0"><xsl:value-of select=".//property[@name='telefon']/value"/></p>
			</xsl:if>
			<xsl:if test=".//property[@name='ssylka']/value">
				<p class="mt5 mb0">
					<a class="brand-color" href="{.//property[@name='ssylka']/value}" target="_blank">Перейти на сайт</a>
				</p>
			</xsl:if>
		</div>
	</xsl:template>
	
	
</xsl:stylesheet>