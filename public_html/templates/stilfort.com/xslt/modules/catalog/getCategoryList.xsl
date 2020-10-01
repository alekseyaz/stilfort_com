<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[

]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

          <!-- catalog_glavnaya -->
	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']" mode="catalog_glavnaya">
		<xsl:apply-templates select="items" mode="catalog_glavnaya"/>
	</xsl:template>

	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']/items" mode="catalog_glavnaya">
		<section class="catalogHome">
			<div class="wrapper">
				<div class="catalogHome__content">
					<div class="catalogHome__title h2">Каталог продукции</div>
					<div class="catalogHome__grid">
						<xsl:apply-templates select="item" mode="catalog_glavnaya"/>
						<xsl:apply-templates select="$homepage//group[@name='pdf_download']" mode="pdf_download" />
					</div>
				</div>
			</div>
		</section>
	</xsl:template>
	
	
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']/items/item" mode="catalog_glavnaya">
		 <xsl:variable name="page" select="document(concat('upage://', @id))/udata/page" />
		 
		 <div class="catalogHome__cell catalogHome__cell-{position()-1}">
		     <xsl:attribute name="style">
			      background-image: url('<xsl:value-of select="$page//property[@name='menu_pic_a']/value" />');
			 </xsl:attribute>
		 
		 
              <a href="{@link}">
                <div class="catalog__title">
                  <xsl:value-of select="$page/name" />
                </div>
                <div class="catalog__arrow">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" id="right-arrow-foward-sign" style="enable-background:new 0 0 15.698 8.706;" version="1.1" viewBox="0 0 15.698 8.706" xml:space="preserve"><polygon points="11.354,0 10.646,0.706 13.786,3.853 0,3.853 0,4.853 13.786,4.853 10.646,8 11.354,8.706 15.698,4.353 "/></svg>
                </div>
              </a>
			  
			    
            </div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']/items/item[1]" mode="catalog_glavnaya"/>
	
	<xsl:template match="group[@name='pdf_download']" mode="pdf_download"/>
	<xsl:template match="group[@name='pdf_download' and .//property[@name='img_download'] and .//property[@name='file_download']/value and .//property[@name='zagolovok_download']/value]" mode="pdf_download">
		 <div class="catalogHome__cell catalogHome__cell-{position()-1}">
			<xsl:apply-templates select=".//property[@name='img_download']" mode="bg_img"/>
			<a href="{.//property[@name='file_download']/value}" target="_blank">
				<div class="catalog__title">
					<xsl:value-of select=".//property[@name='zagolovok_download']/value" />
				</div>
				<div class="catalog__arrow">
					<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" id="right-arrow-foward-sign" style="enable-background:new 0 0 15.698 8.706;" version="1.1" viewBox="0 0 15.698 8.706" xml:space="preserve"><polygon points="11.354,0 10.646,0.706 13.786,3.853 0,3.853 0,4.853 13.786,4.853 10.646,8 11.354,8.706 15.698,4.353 "/></svg>
				</div>
			</a>
		</div>
	</xsl:template>

	
	
	 
	  <!-- razdeli_v_razdele -->
	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']" mode="razdeli_v_razdele">
		<xsl:apply-templates select="items" mode="razdeli_v_razdele"/>
	</xsl:template>

	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']/items" mode="razdeli_v_razdele">
	    <div class="product__tags result__tags">   
		   <xsl:apply-templates select="item" mode="razdeli_v_razdele"/>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']/items/item" mode="razdeli_v_razdele">
		 <xsl:variable name="page" select="document(concat('upage://', @id))/udata/page" />
		     <div class="product__tag">
                   <a href="{@link}"><xsl:value-of select="$page/name" /></a>
               </div>
	</xsl:template>
	

	
	
	
    <!-- razdeli_v_cataloge -->
	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']" mode="razdeli_v_cataloge">
		<xsl:apply-templates select="items" mode="razdeli_v_cataloge"/>
	</xsl:template>

	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']/items" mode="razdeli_v_cataloge">
	    <div class="catalog__list"> 
		   <xsl:apply-templates select="item[@parent='0']" mode="razdeli_v_cataloge"/>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']/items/item" mode="razdeli_v_cataloge">
		 <xsl:variable name="page" select="document(concat('upage://', @id))/udata/page" />
		
	                  <div class="catalog__product catalog__product-{position()-1}">
                        <div class="product__title">
                            <a href="{@link}">
                                <xsl:value-of select="." />
                            </a> 
                        </div>
						<xsl:apply-templates select="document(concat('udata://catalog/getCategoryList//',@id,'///100/'))/udata" 
						mode="podrazdeli_v_cataloge"/>
						
         
                        <div class="showmore__button showmore__catalog">
                            <span>Показать еще</span>
                        </div>
                        <div class="product__image">
                            <img src="{$page//property[@name='header_pic']/value}" alt="{$page//property[@name='header_pic']/value/@alt}"/>
                        </div>
                    </div>
	</xsl:template>

    <xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']/items/item[@id = '15']" mode="razdeli_v_cataloge"/>

    <!-- podrazdeli_v_cataloge -->
	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']" mode="podrazdeli_v_cataloge">
		<xsl:apply-templates select="items" mode="podrazdeli_v_cataloge"/>
	</xsl:template>

	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']/items" mode="podrazdeli_v_cataloge">
	    <div class="product__tags">
		   <xsl:apply-templates select="item" mode="podrazdeli_v_cataloge"/>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getCategoryList']/items/item" mode="podrazdeli_v_cataloge">
		 <xsl:variable name="page" select="document(concat('upage://', @id))/udata/page" />
		   <div class="product__tag">
               <a href="{@link}"><xsl:value-of select="$page/name" /></a>
           </div>
    </xsl:template>


</xsl:stylesheet>