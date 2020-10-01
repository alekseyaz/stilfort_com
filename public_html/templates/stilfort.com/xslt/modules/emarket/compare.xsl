<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:umi="http://www.umi-cms.ru/TR/umi">
	
	
	
	
	

	<xsl:template match="result[@module = 'content' and @method = 'content' and page/@alt-name = 'compare']">
		<div class="scrumbs">
			<div class="wrapper">
				<xsl:call-template name="navibar" />
			</div>
		</div>
		<section class="compare">
			<div class="wrapper">
				<div class="compare__content">
					<div class="compare__panel">
						<div class="compare__title h2">
							<xsl:value-of select=".//property[@name='h1']/value" />
						</div>
						<!--<div class="compare__links">
							<ul class="radio__buttons">
								<li class="radio__button active">
									<a href="#">Люстры</a>
								</li>
								<li class="radio__button">
									<a href="#">БРА</a>
								</li>
								<li class="radio__button">
									<a href="#">Торшеры</a>
								</li>
							</ul>
						</div>-->
					</div>
					<!--<div class="compare__buttons">
						<ul class="radio__buttons">
							<li class="radio__button active">
								<a href="#">Только отличия</a>
							</li>
							<li class="radio__button">
								<a href="#">Все характеристики</a>
							</li>
						</ul>
					</div>-->
					
					<xsl:apply-templates select="document('udata://emarket/compare')/udata" />
					
				</div>
			</div>
		</section>
	</xsl:template>

	<xsl:template match="udata[@method = 'compare']">
		<!--<textarea><xsl:copy-of select="."/></textarea>-->
		<div class="compare__cells">
			<div class="compare__add compare__cell">
				<a href="/katalog/">
					<div class="compare__plus">
						<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" height="128px" id="Layer_1" style="enable-background:new 0 0 128 128;" version="1.1" viewBox="0 0 128 128" width="128px" xml:space="preserve"><g><line style="fill:none;stroke-width:12;stroke-miterlimit:10;" x1="13.787" x2="114.213" y1="64.001" y2="64.001"/><line style="fill:none;stroke-width:12;stroke-miterlimit:10;" x1="64" x2="64" y1="13.787" y2="114.213"/></g></svg>
					</div>
					<div class="compare__name">Добавить еще</div>
				</a>
			</div>
			<xsl:apply-templates select="headers/items/item" mode="compare-header" />
		</div>
		
		<div class="compare__lists">
			<ul class="compare__list-1 compare__list compare__list-properties">
				<xsl:apply-templates select="fields/field[@name='stoimost']" mode="compare_title_price" />
				<xsl:apply-templates select="fields/field" mode="compare_title" />
			</ul>
			<xsl:apply-templates select="headers/items/item" mode="compare_col" />
		</div>
	</xsl:template>
	
	<xsl:template match="headers/items/item" mode="compare-header">
		<xsl:variable name="id" select="@id"/>
		<div class="compare__cell compare_{@id}">
			<a href="{@link}">
				<span class="compare__remove tooltip" data-id="{@id}" title="Удалить из сравнения"></span>
				<div class="compare__image">
					<img src="{document(concat('udata://system/makeThumbnailFull/(', ../../..//field[@name='photo']//item[@id=$id]/value/value[1]/@path,')/440/auto///'))/udata/src}" alt=""/>
				</div>
				<div class="compare__info">
					<div class="compare__name">
						<xsl:value-of select="." disable-output-escaping="yes"/>
					</div>
					<div class="compare__article">
						<xsl:apply-templates select="../../..//field[@name='artikul']//item[@id=$id]/value" mode="compare_value"/>
					</div>
				</div>
			</a>
		</div>
	</xsl:template>
	
	<xsl:template match="headers/items/item" mode="compare_col">
		<xsl:variable name="id" select="@id"/>
		<xsl:variable name="pos" select="position() + 1"/>
		<ul class="compare__list-{$pos} compare__list compare_{@id}">
			<xsl:apply-templates select="../../..//field[@name='stoimost_new' or @name = 'stoimost'][1]//item[@id=$id]" mode="compare_price"/>
			<xsl:apply-templates select="../../..//field//item[@id=$id]" mode="compare"/>
		</ul>
	</xsl:template>
	
	<xsl:template match="field" mode="compare_title">
		<li>
			<span>
				<xsl:value-of select="@title" disable-output-escaping="yes"/>
				<xsl:text>:</xsl:text>
			</span>
		</li>
	</xsl:template>
	
	<xsl:template match="field" mode="compare_title_price">
		<li>
			<span>
				<xsl:value-of select="@title" disable-output-escaping="yes"/>
				<xsl:text>:</xsl:text>
			</span>
		</li>
	</xsl:template>
	
	<xsl:template match="item" mode="compare">
		<li>
			<span>
				<xsl:apply-templates select="value" mode="compare_value"/>
			</span>
		</li>
	</xsl:template>
	
	<xsl:template match="field[@type = 'wysiwyg' or @type = 'img_file' or @type = 'symlink' or @type = 'multiple_image' or @name='stoimost' or @name = 'stoimost_new' or @name = 'ssylka_na_video' or @type = 'file' or @type='boolean' or @name='product_descr' or @name='artikul' or @name='polnoe_naimenovanie' or @name='tipnomenklatury' or @name='vidnomenklatury' or @name='1c_product_id' or @name='1c_catalog_id']" mode="compare_title" />
	<xsl:template match="field[@type = 'wysiwyg' or @type = 'img_file' or @type = 'symlink' or @type = 'multiple_image' or @name='stoimost' or @name = 'stoimost_new' or @name = 'ssylka_na_video' or @type = 'file' or @type='boolean' or @name='product_descr' or @name='artikul' or @name='polnoe_naimenovanie' or @name='tipnomenklatury' or @name='vidnomenklatury' or @name='1c_product_id' or @name='1c_catalog_id']//item" mode="compare" />
	
	
	
	<xsl:template match="item" mode="compare_price">
		<li>
			<span>
				<xsl:apply-templates select="value/value" mode="cena"/>
			</span>
		</li>
	</xsl:template>

	
	<xsl:template match="value" mode="compare_value">
		<xsl:value-of select="value" disable-output-escaping="yes"/>
	</xsl:template>
	 
	<xsl:template match="value[@type = 'relation']" mode="compare_value">
		<xsl:apply-templates select="value/item" mode="compare_value"/>
	</xsl:template>
	
	<xsl:template match="value[@type = 'relation']/value/item" mode="compare_value">
		<xsl:value-of select="@name" disable-output-escaping="yes"/>
		<xsl:text>, </xsl:text>
	</xsl:template>
	<xsl:template match="value[@type = 'relation']/value/item[last()]" mode="compare_value">
		<xsl:value-of select="@name" disable-output-escaping="yes"/>
	</xsl:template>	
	
	
	
	
	
	
	
	
	
	<xsl:template match="udata[@method = 'getCompareList']" />

	<xsl:template match="udata[@method = 'getCompareList'][count(items/item) &gt; 0]">
		<div id="catalog_category">
			<div class="category_title">
				<h1>
					<xsl:text>&compare-title;</xsl:text>
				</h1>
			</div>
			
			<div class="body">
				<div class="in">
					<ul class="compare">
						<xsl:apply-templates select="items/item" />
					</ul>

					<xsl:if test="count(items/item) &gt; 1">
						<a href="{$lang-prefix}/emarket/compare/" class="button">
							<xsl:text>&compare-submit;</xsl:text>
						</a>
					</xsl:if>
				</div>
			</div>
			
			
		</div>
		<div class="clean"></div>
	</xsl:template>


	<xsl:template match="udata[@method = 'getCompareList']/items/item">
		<li>
			<a href="{$lang-prefix}/emarket/removeFromCompare/{@id}/" class="first">
				<xsl:attribute name="title">&delete;</xsl:attribute>
				<xsl:text>&#215;</xsl:text>
			</a>
			<a href="{$lang-prefix}{@link}" class="title" title="{.}" umi:element-id="{@id}" umi:field-name="name">
				<xsl:value-of select="." />
			</a>
		</li>
	</xsl:template>


	<xsl:template match="udata[@method = 'getCompareLink']/add-link">
		<a href="{.}" class="compare">
			<xsl:text>&compare-add;</xsl:text>
		</a>
	</xsl:template>

	<xsl:template match="udata[@method = 'getCompareLink']/del-link">
		<a href="{.}" class="compare">
			<xsl:text>&compare-del;</xsl:text>
		</a>
	</xsl:template>



</xsl:stylesheet>