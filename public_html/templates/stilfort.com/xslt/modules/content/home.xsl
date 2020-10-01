<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/TR/xlink">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'content' and /result/page/@is-default = '1']">
		<xsl:apply-templates select="$homepage//group[@name='header_banner']" mode="header_banner" />

		<!-- <xsl:apply-templates select="document('udata://system/getFilteredPages/87/(novinka)/1//////')/udata" />-->
		
		<xsl:apply-templates select="document('udata://catalog/getObjectsByFlag//8///novinka/')/udata" mode="novinki_glavnaya"/>

		<xsl:apply-templates select="document('udata://custom/getlastvideos/87/8//')/udata" mode="video_obzori" />

	  <!--  <xsl:apply-templates select="document('udata://catalog/getCategoryList//0////')/udata" mode="catalog_glavnaya"/>-->

		<xsl:variable name="dealers" select="document('udata://custom/getDealers/?extProps=country,city,type,address,tel,hours,site,latitude,longitude')/udata"/>
		
		<xsl:if test="document('upage://51')/udata/page/@is-active = '1'">
		<section class="dealer">
			<div class="wrapper">
				<div class="dealer__content">
					<div class="dealer__title h2">Карта дилеров</div>
					<!--<div class="map__tips">
						<div class="map__tip map__tip-yellow">1</div>
						<div class="map__tip map__tip-white">1</div>
					</div>
					<xsl:apply-templates select="$dealers" mode="dealer__popup"/>-->
				</div>
			</div>
			<div class="dealer__map" id="dealer__map" style="height:450px;">
				<!--<img src="/images/map__bg.jpg" alt=""/>-->
			</div>
		</section>
		</xsl:if>
	
	
		<xsl:apply-templates select="$homepage//group[@name='stilfort']" mode="stilfort" />
	
	    <xsl:apply-templates select="$homepage//group[@name='publikacii_instagram']" mode="publikacii_instagram" />
	
	    <xsl:apply-templates select="$homepage//group[@name='kontakty']" mode="kontakty" />

        <xsl:apply-templates select="$homepage//group[@name='publikacii_instagram']" mode="publikacii_instagram_mob" />
	</xsl:template>
	
	
	
	
	 <!--header_banner-->
	
	<xsl:template match="group" mode="header_banner">
		<section class="banner">
		<div class="wrapper">
			<div class="banner__content">
				<div class="banner__left">
					<div class="banner__title h1"><xsl:value-of select=".//property[@name='header_banner_title']/value" /></div>
					<div class="banner__description">
						<xsl:value-of select=".//property[@name='header_banner_descr']/value"  disable-output-escaping="yes"/>
					</div>
					<div class="button banner__button">
						<a href="{.//property[@name='header_banner_link']/value/page/@link}">
							<xsl:value-of select=".//property[@name='header_banner_link']/title" />
						</a>
					</div>
				</div>
				<xsl:apply-templates select=".//property[@name = 'foto_slajdera_glavnoj']" mode="foto_slajdera_glavnoj"/>
						</div>
				<xsl:apply-templates select=".//property[@name = 'header_banner_foto']" mode="header_banner_foto"/>
			</div>
		</section>
	</xsl:template>
	 
	<xsl:template match="property" mode="foto_slajdera_glavnoj">
		<div class="banner__right right-banner">
			<div class="right-banner__slider">
				<xsl:apply-templates select="value" mode="foto_slajdera_glavnoj"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="value" mode="foto_slajdera_glavnoj">
		<div class="right-banner__slide">
			<div class="right-banner__image" style="background-image: url('{.}');"></div>
		</div>
	</xsl:template>
	
	 <xsl:template match="property" mode="header_banner_foto">
			<style>.banner__content:after{background-image: url('<xsl:value-of select="value" />');}</style>
	</xsl:template>
	
	
	
	<!--novinki_glavnaya-->
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']" mode="novinki_glavnaya"/>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag' and lines/item]" mode="novinki_glavnaya">
	 <section class="newItems">
	 <div>
      <div class="wrapper">
        <div class="newItems__content1">
          <div class="newItems__title h2">Новинки каталога</div>
		        <xsl:apply-templates select="lines" mode="novinki_glavnaya"/>
		      <!-- <xsl:apply-templates select="lines" mode="novinki_glavnaya_mob"/>-->
        </div>
        </div>
      </div>
    </section>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines" mode="novinki_glavnaya">
		<div class="results__content">
			<div class="results__list">
				<xsl:apply-templates select="item" mode="novinki_glavnaya"/>
			</div>
			<xsl:apply-templates select="../total" mode="show_more"/>
          </div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines/item" mode="novinki_glavnaya">
	   <xsl:apply-templates select="." mode="short_view"/>
	</xsl:template>
	
	<!--
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines" mode="novinki_glavnaya">
	     <div class="newsItem__slider newsItem__slider-desktop">
			  <xsl:apply-templates select="item[position() mod 5 = 1]" mode="novinki_glavnaya"/>
          </div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines/item" mode="novinki_glavnaya">
	  <div class="newsItem__slide-wrapper newsItem__slide-{position()}">
              <div class="newsItem__slide">
			  <xsl:apply-templates select="." mode="novinki_glavnaya_1"/>
			    <xsl:apply-templates select="following-sibling::item[1]" mode="novinki_glavnaya_2">
				   <xsl:with-param name="number" select = "2"/>
			    </xsl:apply-templates >
			  <xsl:apply-templates select="following-sibling::item[2]" mode="novinki_glavnaya_2">
			       <xsl:with-param name="number" select = "3"/>
			  </xsl:apply-templates >
			  <xsl:apply-templates select="following-sibling::item[3]" mode="novinki_glavnaya_2">
			      <xsl:with-param name="number" select = "4"/>
			   </xsl:apply-templates >
			  <xsl:apply-templates select="following-sibling::item[4]" mode="novinki_glavnaya_2">
			      <xsl:with-param name="number" select = "5"/>
			   </xsl:apply-templates >
              </div>
            </div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines/item" mode="novinki_glavnaya_1">
		   <xsl:variable name="element" select="/result/page" />
		   <xsl:variable name="page" select="document(concat('upage://', @id))/udata/page" />
		 <div class="newItem newItem-main newItem-1">
                  <a href="{@link}">
                    <div class="newItem__image">
					  
				<img src="{document(concat('udata://system/makeThumbnailFull/(',$page//property[@name='foto_tovara']/value[1]/@path, ')/409/auto///'))/udata/src}" alt="{$page//property[@name='foto_tovara']/value[1]/@alt}"/>
                    </div>
                    <div class="newItem__content">
					
				    <xsl:choose>
                            <xsl:when test="$page//property[@name='stoimost_new']">
					       <div class="newItem__price">
                                    <xsl:apply-templates select="$page//property[@name='stoimost_new']/value" mode="cena" />
					       </div>	 
                           </xsl:when>
                           <xsl:otherwise>
						   <div class="newItem__price">
                                     <xsl:apply-templates select="$page//property[@name='stoimost']/value" mode="cena" />
						   </div>
                          </xsl:otherwise>
                        </xsl:choose>
                      <div class="newItem__name">
                        <xsl:value-of select="@name" />
                      </div>
                      <div class="newItem__number">
					  <xsl:value-of select="$page//property[@name='artikul']/value" />
				  </div>
                    </div>
                  </a>
          </div>
	</xsl:template>
	
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines/item" mode="novinki_glavnaya_2">
	    <xsl:param name="number"/>
		<xsl:variable name="page" select="document(concat('upage://', @id))/udata/page" />

		<div class="newItem newItem-{$number}">
                  <a href="{@link}">
                    <div class="newItem__image">
                      <img src="{document(concat('udata://system/makeThumbnailFull/(',$page//property[@name='foto_tovara']/value[1]/@path, ')/110/auto///'))/udata/src}" alt="{$page//property[@name='foto_tovara']/value[1]/@alt}"/>
                    </div>
                    <div class="newItem__content">
					
                      	  <xsl:choose>
                            <xsl:when test="$page//property[@name='stoimost_new']">
					       <div class="newItem__price">
                                    <xsl:apply-templates select="$page//property[@name='stoimost_new']/value" mode="cena" />
					       </div>	 
                           </xsl:when>
                           <xsl:otherwise>
						   <div class="newItem__price">
                                     <xsl:apply-templates select="$page//property[@name='stoimost']/value" mode="cena" />
						   </div>
                          </xsl:otherwise>
                        </xsl:choose>
                      <div class="newItem__name">
                         <xsl:value-of select="@name" />
                      </div>
                      <div class="newItem__number">
                        <xsl:value-of select="$page//property[@name='artikul']/value" />
                      </div>
                    </div>
                  </a>
          </div>
	</xsl:template>
	
	-->
	
	
	
	
	
	

	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines" mode="novinki_glavnaya_mob">
	     <div class="newsItem__slide-wrapper newsItem__slider-mobile">
			  <xsl:apply-templates select="item[position()&lt;8]" mode="novinki_glavnaya_mob"/>
          </div>
	</xsl:template>
	
	
     <xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines/item" mode="novinki_glavnaya_mob">
	     <xsl:variable name="page" select="document(concat('upage://', @id))/udata/page" />
	       <div class="newItem newItem-{position()}">
              <a href="{@link}">
                <div class="newItem__image">
                    <img src="{document(concat('udata://system/makeThumbnailFull/(',$page//property[@name='menu_pic_a']/value/@path, ')/97/121///'))/udata/src}" alt="{$page//property[@name='menu_pic_a']/value/@alt}"/>
                  </div>
                <div class="newItem__content">
				
				
                  		 <xsl:choose>
                            <xsl:when test="$page//property[@name='stoimost_new']">
					       <div class="newItem__price">
                                    <xsl:apply-templates select="$page//property[@name='stoimost_new']/value" mode="cena" />
					       </div>	 
                           </xsl:when>
                           <xsl:otherwise>
						   <div class="newItem__price">
                                     <xsl:apply-templates select="$page//property[@name='stoimost']/value" mode="cena" />
						   </div>
                          </xsl:otherwise>
                        </xsl:choose>
				  
				  
				  
                  <div class="newItem__name">
                      <xsl:value-of select="@name" />
                  </div>
                  <div class="newItem__number">
                       <xsl:value-of select="$page//property[@name='artikul']/value" />
                  </div>
                </div>
              </a>
            </div>
	</xsl:template>
	
	
	
	
	<!--video_obzori-->
	<xsl:template match="udata[@module = 'custom' and @method = 'getlastvideos']" mode="video_obzori"/>
	<xsl:template match="udata[@module = 'custom' and @method = 'getlastvideos' and items/item]" mode="video_obzori">
		<section class="videos">
			<div class="wrapper">
				<div class="videos__content">
					<div class="videos__panel">
						<div class="videos__title h2">Видео-обзоры</div>
					</div>
					<xsl:apply-templates select="items" mode="video_obzori"/>
				
					<xsl:apply-templates select="items" mode="video_obzori_mob"/>
				</div>
			</div>
		</section> 
	</xsl:template>
	
	<xsl:template match="udata[@module = 'custom' and @method = 'getlastvideos']/items" mode="video_obzori">
	     <div class="video__table videos__slider videos__slider-desktop">
                <xsl:apply-templates select="item" mode="video_obzori">
					<!--<xsl:sort select="@number" data-type="number" order="descending"/>-->
               </xsl:apply-templates>
          </div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'custom' and @method = 'getlastvideos']/items" mode="video_obzori_mob">
	     <div class="video__table videos__slider videos__slider-mobile">
               <xsl:apply-templates select="item[position()&lt;5]" mode="video_obzori">
					<!--<xsl:sort select="@number" data-type="number" order="descending"/>-->
               </xsl:apply-templates>
          </div>
	</xsl:template>
	
	
	<xsl:template match="udata[@module = 'custom' and @method = 'getlastvideos']/items/item" mode="video_obzori">
		<xsl:variable name="page" select="document(concat('upage://', @id))/udata/page" />
		<xsl:if test="$page//property[@name='ssylka_na_video']"> 
		 <div class="video__cell video__cell-{position()}">
              <div class="video__image">
                <a class="video" href="{$page//property[@name='ssylka_na_video']/value}" target="_blank">
					<xsl:choose>
						<xsl:when test="$page//property[@name='foto_video']/value">
							<img src="{$page//property[@name='foto_video']/value}" alt="{$page//property[@name='foto_video']/value/@alt}"/>
						</xsl:when>
						<xsl:otherwise>
							<img src="//img.youtube.com/vi/{@video_id}/mqdefault.jpg" alt=""/>
						</xsl:otherwise>
					</xsl:choose>
                </a>
              </div>
              <div class="video__top">
                <div class="video__title">
					<a href="{@link}">
					<xsl:value-of select="@name" />
					</a>
				</div>
				
				<div class="video__price">
				    <xsl:choose>
                           <xsl:when test="$page//property[@name='novaya_stoimost']">
                                <xsl:apply-templates select="$page//property[@name='novaya_stoimost']/value"  mode="cena"/>
                           </xsl:when>   
                           <xsl:otherwise>
                               <xsl:apply-templates select="$page//property[@name='stoimost']/value" mode="cena"/>
                           </xsl:otherwise>
                      </xsl:choose>
			     </div>
				 
		
                				
              </div>
              <div class="video__bottom">
                <div class="video__description"><xsl:value-of select="$page//property[@name='artikul']/value" /></div>
              </div>
          </div>
	    </xsl:if> 
	</xsl:template>
	
	<!--kontakty-->
	<xsl:template match="group" mode="kontakty">
	 <section class="contacts">
      <div class="wrapper">
        <div class="contacts__content">
          <div class="contacts__left">
            <div class="contacts__title h2">Как нас найти</div>
            <div class="contacts__list">
			   <xsl:apply-templates select=".//property[starts-with(@name,'contact_')]" mode="contacts" />
              <div class="contacts__button">
                <div class="button">
                  <a href="#modalCallback" class="popup-modal">Заказать звонок</a>
                </div>
              </div>
            </div>
			
          </div>
		    <xsl:apply-templates select=".//property[@name='map']" mode="contact_map" />
        </div>
      </div>
    </section>
	</xsl:template>
	
	<xsl:template match="property" mode="contacts">
	    <div class="contacts__contact contact__{substring-after(@name, 'contact_')}">		
          <div class="contact__title"><xsl:value-of select="title"/></div>
          <div class="contact__text"><xsl:value-of select="value" disable-output-escaping="yes"/></div>
        </div>
    </xsl:template>
	
	
	<xsl:template match="property" mode="contact_map">
      <div class="contacts__right">
       <div class="contact__map">
         <xsl:value-of select="value" disable-output-escaping="yes"/>
       </div>
      </div>
    </xsl:template>
	
	<!--publikacii_instagram-->
	<xsl:template match="group" mode="publikacii_instagram">
		<section class="carousel carousel__desktop">
			<div class="carousel__content">
				<xsl:apply-templates select=".//property[@name='profil_instagram']" mode="profil_instagram" />
				<div class="carousel__slider_n">
				</div>
				<!--<xsl:apply-templates select=".//property[@name='foto_instagram']" mode="foto_instagram" />-->
			</div>
		</section>
	</xsl:template>
	
	<xsl:template match="property" mode="profil_instagram">
		<div class="carousel__text">
			<a href="https://www.instagram.com/{value}" target="_blank">
				<span><xsl:value-of select="title"/></span>
				<span class="carousel__instagram">@<xsl:value-of select="value" disable-output-escaping="yes"/></span>
			</a>
		</div>
		<!--<xsl:apply-templates select="document(concat('udata://custom/xsltCache/3600/udata/custom/getInstagramInfo/', value))/udata"/>-->
		<!--<xsl:apply-templates select="document(concat('udata://custom/getInstagramInfo/', value))/udata"/>-->
    </xsl:template>
	
	<xsl:template match="property" mode="foto_instagram">
        <div class="carousel__slider">
		  <xsl:apply-templates select="value" mode="foto_instagram" />
        </div>
    </xsl:template>
	
	<xsl:template match="value" mode="foto_instagram">
	    <div class="carousel__slide">
            <div class="carousel__image">
              <img src="{.}" alt="{@alt}"/>
            </div>
        </div>
	</xsl:template>
	
	<xsl:template match="value[1]" mode="foto_instagram">
	    <div class="wrapper1">
          <div class="carousel__slide">
            <div class="carousel__image">
              <img src="{.}" alt="{@alt}"/>
            </div>
          </div>
        </div>
	</xsl:template>
	
	<!--publikacii_instagram_mob-->
	<xsl:template match="group" mode="publikacii_instagram_mob">
		<section class="carousel carousel__mobile">
			<div class="carousel__content">
				<xsl:apply-templates select=".//property[@name='profil_instagram']" mode="profil_instagram" />
				<div class="carousel__slider_n">
				</div>
				<!--<xsl:apply-templates select=".//property[@name='foto_instagram']" mode="foto_instagram" />-->
			</div>
		</section>
	</xsl:template>
	
	<!--stilfort-->
	<xsl:template match="group" mode="stilfort">
		<section class="facts">
			<div class="wrapper">
				<div class="facts__content">
				<div class="facts__title h2"><xsl:value-of select="title"/></div>
					<xsl:apply-templates select=".//property[starts-with(@name,'fact_')]" mode="fact" />
					<xsl:apply-templates select=".//property[@name='galereya_fact']" mode="galereya_fact" />
				</div>
			</div>
			<xsl:apply-templates select=".//property[@name='foto_sleva']" mode="after_bg"/>
		</section>
	</xsl:template>
	
	<xsl:template match="property[@name='foto_sleva']" mode="after_bg">
		<style>.facts__content::after{content:'';background-image:url('<xsl:value-of select="value"/>');}</style>
	</xsl:template>
	
	<xsl:template match="property" mode="fact">
	    <xsl:variable name="name" select="concat('descr_fact_', substring-after(@name, 'fact_'))"/>
	    <div class="facts__fact facts__fact-{substring-after(@name, 'fact_')}">
            <div class="fact__title"><xsl:value-of select="value" disable-output-escaping="yes"/></div>
			 <xsl:apply-templates select="../property[@name=$name]" mode="fact_descr" />
        </div>
	</xsl:template>
	
	<xsl:template match="property" mode="fact_descr">
	     <div class="fact__description">
              <xsl:value-of select="value" disable-output-escaping="yes"/>
          </div>
	</xsl:template>
	
	<xsl:template match="property" mode="galereya_fact">
		<div class="slider__wrapper slider__wrapper-facts">
			<div class="facts__slider">
				<xsl:apply-templates select="value" mode="galereya_fact" />
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="value" mode="galereya_fact">
		<div class="fact__slide">
			<img src="{.}" alt="{@alt}"/>
		</div>
	</xsl:template>
	
	

</xsl:stylesheet>