<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[

]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/TR/xlink">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'catalog' and @method = 'object']">
		<xsl:call-template name="navibar" />
		<section class="products products__single">
			<div class="wrapper">
				<div class="products__content">
					<div class="products__product">
						<div class="products__panel">
							<div class="products__title h2">
								<xsl:value-of select=".//property[@name = 'h1']/value" />
							</div>
						
							<div class="products__icons">
								<div class="products__like">
									<a href="#" data-id="{page/@id}" class="tooltip" title="В избранное">
										<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"><defs><style>.cls-1{fill:#101820;}</style></defs><title/><g data-name="Layer 54" id="Layer_54"><path class="cls-1" d="M16,28.72a3,3,0,0,1-2.13-.88L3.57,17.54a8.72,8.72,0,0,1-2.52-6.25,8.06,8.06,0,0,1,8.14-8A8.06,8.06,0,0,1,15,5.68l1,1,.82-.82h0a8.39,8.39,0,0,1,11-.89,8.25,8.25,0,0,1,.81,12.36L18.13,27.84A3,3,0,0,1,16,28.72ZM9.15,5.28A6.12,6.12,0,0,0,4.89,7a6,6,0,0,0-1.84,4.33A6.72,6.72,0,0,0,5,16.13l10.3,10.3a1,1,0,0,0,1.42,0L27.23,15.91A6.25,6.25,0,0,0,29,11.11a6.18,6.18,0,0,0-2.43-4.55,6.37,6.37,0,0,0-8.37.71L16.71,8.8a1,1,0,0,1-1.42,0l-1.7-1.7a6.28,6.28,0,0,0-4.4-1.82Z"/></g></svg>
									</a>
								</div>
								<div class="products__compare">
									<a href="#" data-id="{page/@id}" class="tooltip" title="В сравнение">
										<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M1 4h2v2H1V4zm4 0h14v2H5V4zM1 9h2v2H1V9zm4 0h14v2H5V9zm-4 5h2v2H1v-2zm4 0h14v2H5v-2z"/></svg>
									</a>
								</div>
							</div>
						</div>
						
						<div class="product__content">
							<div class="product__top">
								<div class="product__info">
									<xsl:apply-templates select="." mode="parametry_tovara" />
									<!--<xsl:apply-templates select=".//group[@name='parametry_tovara']" mode="parametry_tovara" />-->
									<xsl:apply-templates select=".//property[@name='product_descr' or @name = 'polnoe_naimenovanie']" mode="product_descr" />
									
		<xsl:choose>
			<xsl:when test=".//property[@name='price']">
				<xsl:apply-templates select=".//property[@name='price']" mode="stoimost" />
			</xsl:when>
			<!--<xsl:when test=".//property[@name='stoimost_new']">
				<xsl:apply-templates select=".//property[@name='stoimost_new']" mode="stoimost" />
			</xsl:when>-->
			<xsl:otherwise>
				<xsl:apply-templates select=".//property[@name='stoimost']" mode="stoimost" />
			</xsl:otherwise>
		</xsl:choose>
		
									<xsl:apply-templates select=".//group[@name='dop_polya_tovara']" mode="dop_polya_tovara" />
								</div>
								<div class="product__gallery fotorama" data-nav="thumbs" data-height="600" data-maxheight="100%" data-width="600" data-maxwidth="100%">
									<xsl:apply-templates select=".//property[@name='photo']" mode="galereya_tovara" />
									<xsl:apply-templates select=".//group[@name='galereya_tovara']/property/value" mode="galereya_tovara" />
								</div>
							</div>
							<div class="product__bottom">
							<div class="product__zagolovok h2">Тех характеристики</div>
								<div class="product__lists">
									<xsl:apply-templates select=".//group[@name='special']" mode="harakteristiki_tovara_2col" />
									<!--<xsl:apply-templates select=".//group[@name='harakteristiki_tovara_1']" mode="harakteristiki_tovara_1" />
									<xsl:apply-templates select=".//group[@name='harakteristiki_tovara_2']" mode="harakteristiki_tovara_2" />-->
									<xsl:apply-templates select=".//group[@name='dokumenty_tovara']" mode="dokumenty_tovara" />
								</div>
							</div>
						</div>
					</div>
					<!--<xsl:apply-templates select="document(concat('udata://custom/getOtherPage/', page/@id, '/10'))/udata"  mode="drugie_tovari"/>-->
					<xsl:apply-templates select="document(concat('udata://custom/getPageByCollection/', page/@id, '/10'))/udata"  mode="drugie_tovari"/>
				</div>
			</div>
		</section>
		
		<xsl:apply-templates select="document(concat('udata://custom/dealers_have/', page/@id))/udata"/>

	</xsl:template>
	
	
	<!-- parametry_tovara -->
	<xsl:template match="group" mode="parametry_tovara">
	     <div class="product__header">
		     <xsl:apply-templates select=".//property" mode="parametry_tovara" />
          </div>
	</xsl:template>
	
	<!-- parametry_tovara -->
	<xsl:template match="result" mode="parametry_tovara">
		<div class="product__header">
			<xsl:apply-templates select=".//property[@name='kollekciya']" mode="parametry_tovara" />
		</div>
	</xsl:template>
	
	<xsl:template match="property" mode="parametry_tovara">
		<div class="product__{@name} product__string">
			<div class="product__property"><xsl:value-of select="title" />:</div>
			<div class="product__value"><xsl:apply-templates select="value" mode="parametry_tovara"/></div>
		</div>
	</xsl:template>
	
	<xsl:template match="property/value" mode="parametry_tovara">
		<xsl:value-of select="." disable-output-escaping="yes" />
	</xsl:template>
	
	<xsl:template match="property/value[@type='relation']" mode="parametry_tovara">
		<xsl:apply-templates select="item" mode="parametry_tovara"/>
	</xsl:template>
	
	<xsl:template match="property/value[@type='relation']/item" mode="parametry_tovara">
		<xsl:choose>
			<xsl:when test="position()= last()">
				<xsl:value-of select="@name" disable-output-escaping="yes" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@name" disable-output-escaping="yes" /><xsl:text>, </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- dop_polya_tovara -->
	<xsl:template match="group" mode="dop_polya_tovara">

                                <!-- <div class="product__button">
                                    <a href="#modalWherebuy" class="popup-modal">
                                        <span>Где купить</span>
                                        <div class="pin__icon">
                                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" id="pin-destination-map-location" style="enable-background:new 0 0 10.134 15.626;" version="1.1" viewBox="0 0 10.134 15.626" xml:space="preserve"><path d="M7.873,0.853c-1.705-1.137-3.908-1.137-5.612,0C0.065,2.316-0.638,5.167,0.626,7.484l4.441,8.142l4.441-8.142  C10.772,5.167,10.07,2.316,7.873,0.853z M8.631,7.006l-3.563,6.533L1.504,7.006C0.49,5.146,1.053,2.859,2.816,1.685  C3.5,1.229,4.283,1,5.067,1s1.567,0.228,2.251,0.684C9.081,2.859,9.645,5.146,8.631,7.006z"></path><path d="M5.067,2.083c-1.378,0-2.5,1.122-2.5,2.5s1.122,2.5,2.5,2.5s2.5-1.122,2.5-2.5S6.446,2.083,5.067,2.083z M5.067,6.083  c-0.827,0-1.5-0.673-1.5-1.5s0.673-1.5,1.5-1.5s1.5,0.673,1.5,1.5S5.894,6.083,5.067,6.083z"></path></svg>
                                        </div>
                                    </a>
                                </div> -->
				 <xsl:apply-templates select=".//property[@name='artikul']" mode="artikul" />	
	</xsl:template>
	
	<xsl:template match="property" mode="product_descr">
          <div class="product__description">
              <span><xsl:value-of select="value" disable-output-escaping="yes" /></span>
          </div>
	</xsl:template>
	

	
	<xsl:template match="property" mode="stoimost">
          <div class="product__price">
                <div class="price__text">Рекомендованная розничная цена:</div>
                <div class="price__number"><xsl:apply-templates select="value" mode="cena" /></div>
          </div>
	</xsl:template>
	
	<xsl:template match="property[../..//property[@name='cena_so_skidkoj']]" mode="stoimost">
          <div class="product__price">
                <div class="price__text">Рекомендованная розничная цена:</div>
                <div class="price__number through"><xsl:apply-templates select="value" mode="cena" /></div>
                <div class="price__number"><xsl:apply-templates select="../..//property[@name='cena_so_skidkoj']/value" mode="cena" /></div>
          </div>
	</xsl:template>
	
	<!--<xsl:template match="property[../..//property[@name='new_price']]" mode="stoimost">
          <div class="product__price">
                <div class="price__text">Рекомендованная розничная цена:</div>
                <div class="price__number through"><xsl:apply-templates select="value" mode="cena" /></div>
                <div class="price__number"><xsl:apply-templates select="../..//property[@name='new_price']/value" mode="cena" /></div>
          </div>
	</xsl:template>
	
	<xsl:template match="property[../..//property[@name='stoimost_new']]" mode="stoimost">
          <div class="product__price">
                <div class="price__text">Рекомендованная розничная цена:</div>
                <div class="price__number through"><xsl:apply-templates select="value" mode="cena" /></div>
                <div class="price__number"><xsl:apply-templates select="../..//property[@name='stoimost_new']/value" mode="cena" /></div>
          </div>
	</xsl:template>-->
	
	
	<xsl:template match="property" mode="artikul">
          <!-- <div class="product__article">
              <div class="article__text"><xsl:value-of select="title" />:</div>
               <div class="article__number"><xsl:value-of select="value" /></div>
          </div> -->
	</xsl:template>
	
	
	<!-- galereya_tovara -->
	<xsl:template match="group" mode="galereya_tovara">
         <div class="product__gallery fotorama" data-nav="thumbs" data-height="600" data-maxheight="100%" data-width="600" data-maxwidth="100%">
               <xsl:apply-templates select=".//property/value" mode="galereya_tovara" />
          </div>
	</xsl:template>
	
	<xsl:template match="value" mode="galereya_tovara">
	     <xsl:text> </xsl:text>
          <a href="{.}">
              <img src="{document(concat('udata://system/makeThumbnailFull/(',@path,')/auto/100///'))/udata/src}" alt="{@alt}" height="100"/>
          </a>
		  <xsl:text> </xsl:text>
	</xsl:template>
	
	
	<!-- harakteristiki_tovara_1 -->
	<xsl:template match="group" mode="harakteristiki_tovara_1">
		<ul class="product__list product__list-1">
			<xsl:apply-templates select=".//property" mode="harakteristiki_tovara_1" />
		</ul>
	</xsl:template>
	
	<!-- harakteristiki_tovara_2 -->
	<xsl:template match="group" mode="harakteristiki_tovara_2">
		<ul class="product__list product__list-2">
			<xsl:apply-templates select=".//property" mode="harakteristiki_tovara_1" />
		</ul>
	</xsl:template>
	
	<xsl:template match="group" mode="harakteristiki_tovara_2col">
		<xsl:variable name="a" select="count(.//property)"/>
		<xsl:variable name="count2" select="($a - ($a mod 2)) div 2 + 1"/>
		
		<!--<xsl:value-of select="count(.//property)"/>/<xsl:value-of select="$count2"/>-->
		<ul class="product__list product__list-1">
			<xsl:apply-templates select=".//property[position() &lt; $count2]" mode="harakteristiki_tovara_1" />
		</ul>
		<ul class="product__list product__list-2">
			<xsl:apply-templates select=".//property[not(position() &lt; $count2)]" mode="harakteristiki_tovara_1" />
		</ul>
	</xsl:template>
	
	<xsl:template match="property" mode="harakteristiki_tovara_1">
		<li>
			<div class="product__property"><xsl:value-of select="title"/>:</div>
			<div class="property__value"><xsl:value-of select="value"/></div>
		</li>
	</xsl:template>
	
	<xsl:template match="property[@type='relation']" mode="harakteristiki_tovara_1">
		<li>
			<div class="product__property"><xsl:value-of select="title"/>:</div>
			<div class="property__value"><xsl:apply-templates select="value/item" mode="harakteristiki_tovara_1_mp" /></div>
		</li>
	</xsl:template>
	
	<xsl:template match="item" mode="harakteristiki_tovara_1_mp">
		<xsl:choose>
			<xsl:when test="position()= last()">
				<xsl:value-of select="@name"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@name"/><xsl:text>, </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="property[@name='novinka']" mode="harakteristiki_tovara_1"/>
	<xsl:template match="property[@name='cena_so_skidkoj']" mode="harakteristiki_tovara_1"/>
	<xsl:template match="property[@name='status']" mode="harakteristiki_tovara_1"/>

	
	
	<!-- dokumenty_tovara -->
	<xsl:template match="group" mode="dokumenty_tovara">
          <ul class="product__list product__list-3 additional__list">
		    <xsl:apply-templates select=".//property[@name='specifikaciya']" mode="specifikaciya" />
			<xsl:apply-templates select=".//property[@name='instrukciya']" mode="instrukciya" />
			<xsl:apply-templates select=".//property[@name='ee_label']" mode="ee_label" />
			<xsl:apply-templates select=".//property[@name='3d_model']" mode="model_3d" />
         </ul>
	</xsl:template>
	
	<xsl:template match="property" mode="specifikaciya">
                                    <li>
                                        <div class="additional__button">
                                            <a href="{value}" download=""><xsl:value-of select="title" />
                                                <div class="additional__icon">
                                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" id="Layer_1" style="enable-background:new 0 0 512 512;" version="1.1" viewBox="0 0 512 512" xml:space="preserve"><g id="XMLID_1302_"><g id="XMLID_1297_"><g id="XMLID_1303_"><g id="XMLID_1313_"><g id="XMLID_1316_"><polygon id="XMLID_1317_" points="419.3,112.9 319.7,112.9 319.7,13.3 334.2,13.3 334.2,98.4 419.3,98.4      "/></g><g id="XMLID_1314_"><polygon id="XMLID_1315_" points="426.6,506 37.9,506 37.9,6 334,6 426.6,102.7 426.6,256 412.1,256 412.1,108.6 327.8,20.5        52.4,20.5 52.4,491.5 412.1,491.5 412.1,457.1 426.6,457.1      "/></g></g><g id="XMLID_1304_"><g id="XMLID_1311_"><rect height="14.5" id="XMLID_1312_" width="197.1" x="98.7" y="111.4"/></g><g id="XMLID_1309_"><rect height="14.5" id="XMLID_1310_" width="129.9" x="98.7" y="154.2"/></g><g id="XMLID_1307_"><rect height="14.5" id="XMLID_1308_" width="267" x="98.7" y="197.1"/></g><g id="XMLID_1305_"><rect height="14.5" id="XMLID_1306_" width="267" x="98.7" y="239.9"/></g></g></g><g id="XMLID_1298_"><path d="M419.3,475L341,361.7h33.5v-113h89.8v113h33.5L419.3,475z M368.7,376.2l50.7,73.3l50.7-73.3h-20.3v-113     H389v113H368.7z" id="XMLID_1299_"/></g></g><g id="XMLID_2055_"><path d="M92.6,367.5H81.8v17.7h10.8c3.1,0,5.4-0.8,7-2.5c1.6-1.6,2.3-3.7,2.3-6.3c0-2.5-0.8-4.7-2.3-6.4    C98,368.3,95.7,367.5,92.6,367.5z" id="XMLID_2056_"/><path d="M136.8,367.5h-8.2v36.6h8.2c4,0,7.2-1.4,9.5-4.1c2.4-2.7,3.5-6.2,3.5-10.5v-7.7c0-4.2-1.2-7.7-3.5-10.4    C144,368.8,140.8,367.5,136.8,367.5z" id="XMLID_2057_"/><path d="M282,328.3H14.3v115H282l-56.9-57.5L282,328.3z M105.5,387.6c-3.1,2.8-7.4,4.2-13,4.2H81.8v19h-8.3v-50    h19.2c5.5,0,9.8,1.4,13,4.3c3.1,2.9,4.7,6.6,4.7,11.2C110.2,381,108.7,384.7,105.5,387.6z M158.3,389.6c0,6.3-2,11.3-6,15.3    c-4,3.9-9.1,5.9-15.5,5.9h-16.5v-50h16.5c6.3,0,11.5,2,15.5,5.9c4,4,6,9.1,6,15.3V389.6z M201.5,367.5h-23.7v15.3H198v6.7h-20.2    v21.3h-8.3v-50h32V367.5z" id="XMLID_2164_"/></g></g></svg>
                                                </div>
                                            </a>
                                        </div>
                                    </li>
	</xsl:template>
	
	<xsl:template match="property" mode="instrukciya">
                                    <li>
                                        <div class="additional__button">
                                            <a href="{value}" download=""><xsl:value-of select="title" />
                                                <div class="additional__icon">
                                                    <svg xmlns:sketch="http://www.bohemiancoding.com/sketch/ns" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Layer_1" x="0px" y="0px" width="59px" height="64px" viewBox="0 0 59 64" enable-background="new 0 0 59 64" xml:space="preserve">
                                                        <g id="Page-1" sketch:type="MSPage">
                                                            <g id="Document-edit" transform="translate(1.000000, 1.000000)" sketch:type="MSLayerGroup">
                                                                <path id="Shape_1_" sketch:type="MSShapeGroup" fill="none" stroke="#6B6C6E" stroke-width="2" d="M47,45v15c0,1.1-0.9,2-2,2H2    c-1.1,0-2-0.9-2-2V2c0-1.1,0.9-2,2-2h25.9L47,18.1V33"/>
                                                                <path id="Shape" sketch:type="MSShapeGroup" fill="none" stroke="#6B6C6E" stroke-width="2" d="M47,18.9H30c-1.1,0-2-0.9-2-2V1"/>
                                                                <path id="Shape_2_" sketch:type="MSShapeGroup" fill="none" stroke="#6B6C6E" stroke-width="2" d="M9,17h13"/>
                                                                <path id="Shape_3_" sketch:type="MSShapeGroup" fill="none" stroke="#6B6C6E" stroke-width="2" d="M9,27h31"/>
                                                                <path id="Shape_4_" sketch:type="MSShapeGroup" fill="none" stroke="#6B6C6E" stroke-width="2" d="M9,34h31"/>
                                                                <path id="Shape_5_" sketch:type="MSShapeGroup" fill="none" stroke="#6B6C6E" stroke-width="2" d="M9,43h24"/>
                                                                <path id="Shape_6_" sketch:type="MSShapeGroup" fill="none" stroke="#6B6C6E" stroke-width="2" d="M9,49h17"/>
                                                                <g id="Group" transform="translate(27.000000, 29.000000)" sketch:type="MSShapeGroup">
                                                                    <path id="Shape_8_" fill="none" stroke="#6B6C6E" stroke-width="2" stroke-linejoin="round" d="M0,30l3.9-9.4L24.2,0.3     c0.4-0.4,1.1-0.4,1.6,0l3.9,3.9c0.4,0.4,0.4,1.1,0,1.6L9.4,26.1L0,30z"/>
                                                                    <path id="Shape_9_" fill="none" stroke="#6B6C6E" stroke-width="2" d="M21.9,2.7l5.4,5.4"/>
                                                                </g>
                                                            </g>
                                                        </g>
                                                    </svg>
                                                </div>
                                            </a>
                                        </div>
                                    </li>

	</xsl:template>
	
	<xsl:template match="property" mode="ee_label">
                                    <li>
                                        <div class="additional__button">
                                            <a href="{value}" download=""><xsl:value-of select="title" />
                                                <div class="additional__icon">
                                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0" id="Layer_1" x="0px" y="0px" width="708.66px" height="708.66px" viewBox="0 0 708.66 708.66" enable-background="new 0 0 708.66 708.66" xml:space="preserve">
                                                        <g>
                                                            <path fill="none" stroke="#373431" stroke-width="12" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" d="   M193.139,314.365c28.979-29.126,69.018-47.119,113.207-47.119l0,0l0.024-0.024l0,0c44.164,0,84.203-17.993,113.134-47.094v-0.024   l0,0c31.249-31.42,46.874-72.583,46.899-113.744l-0.049-0.073c110.473,111.107,110.473,291.257,0,402.34h-0.025   c-66.259,66.65-173.729,66.65-240.012,0l-33.179-33.349C148.949,430.844,148.949,358.799,193.139,314.365z"/>
                                                            <path fill="none" stroke="#373431" stroke-width="12" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" d="   M159.447,602.352c0-44.458,17.896-84.692,46.874-113.794v-0.024l0,0c113.135-47.143,196.63-135.912,240.111-241.331   c-43.481,105.419-126.977,194.188-240.111,241.331l0,0v0.024C177.343,517.659,159.447,557.894,159.447,602.352z"/>
                                                            <path fill="none" stroke="#373431" stroke-width="12" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" d="   M279.661,449.496c11.304-38.843,10.083-81.616-6.494-121.898C289.744,367.88,290.965,410.653,279.661,449.496z"/>
                                                            <path fill="none" stroke="#373431" stroke-width="12" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" d="   M473.19,387.948c-41.235,17.163-85.107,18.018-124.609,5.566C388.083,405.966,431.955,405.111,473.19,387.948z"/>
                                                        </g>
                                                    </svg>
                                                </div>
                                            </a>
                                        </div>
                                    </li>

	</xsl:template>
	
	<xsl:template match="property" mode="model_3d">
                                    <li>
                                        <div class="additional__button">
                                            <a href="{value}" download=""><xsl:value-of select="title" />
                                                <div class="additional__icon">
                                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Layer_1" x="0px" y="0px" viewBox="0 0 444.402 444.402" style="enable-background:new 0 0 444.402 444.402;" xml:space="preserve">
                                                        <g>
                                                            <g>
                                                                <g>
                                                                    <polygon points="264.581,255.539 277.77,263.151 285.45,249.853 272.261,242.241    "/>
                                                                    
                                                                        <rect x="346.533" y="290.708" transform="matrix(-0.8661 -0.4999 0.4999 -0.8661 511.6761 733.8608)" width="15.225" height="15.357"/>
                                                                    
                                                                        <rect x="372.904" y="305.939" transform="matrix(-0.8661 -0.4999 0.4999 -0.8661 553.2724 775.4656)" width="15.225" height="15.357"/>
                                                                    
                                                                        <rect x="241.027" y="229.787" transform="matrix(-0.8661 -0.4999 0.4999 -0.8661 345.2535 567.4308)" width="15.225" height="15.357"/>
                                                                    <rect x="293.78" y="260.248" transform="matrix(-0.8661 -0.5 0.5 -0.8661 428.4641 650.646)" width="15.225" height="15.357"/>
                                                                    <polygon points="317.331,286 330.52,293.612 338.2,280.313 325.011,272.701    "/>
                                                                    <polygon points="79.828,295.537 87.508,308.835 100.697,301.223 93.017,287.925    "/>
                                                                    
                                                                        <rect x="188.157" y="229.784" transform="matrix(0.8661 -0.4999 0.4999 0.8661 -92.4966 129.682)" width="15.225" height="15.357"/>
                                                                    <polygon points="158.959,249.849 166.639,263.148 179.828,255.536 172.148,242.237    "/>
                                                                    
                                                                        <rect x="56.209" y="305.994" transform="matrix(-0.5001 -0.866 0.866 -0.5001 -175.7357 525.7705)" width="15.357" height="15.23"/>
                                                                    
                                                                        <rect x="135.336" y="260.308" transform="matrix(-0.5003 -0.8659 0.8659 -0.5003 -17.422 525.7872)" width="15.358" height="15.227"/>
                                                                    
                                                                        <rect x="108.96" y="275.537" transform="matrix(-0.5001 -0.866 0.866 -0.5001 -70.2267 525.7597)" width="15.357" height="15.225"/>
                                                                    <rect x="214.525" y="62.232" width="15.36" height="15.23"/>
                                                                    <rect x="214.525" y="184.061" width="15.36" height="15.23"/>
                                                                    <rect x="214.525" y="153.603" width="15.36" height="15.23"/>
                                                                    <rect x="214.525" y="31.775" width="15.36" height="15.23"/>
                                                                    <rect x="214.525" y="92.693" width="15.36" height="15.227"/>
                                                                    <rect x="214.525" y="123.146" width="15.36" height="15.23"/>
                                                                    <path d="M222.205,0L29.771,111.101v222.201l192.433,111.101l192.427-111.094V111.107L222.205,0z M45.131,128.835l169.39,97.798     v195.598l-169.39-97.797V128.835z M391.593,115.542l-169.388,97.791L52.81,115.535l169.395-97.8L391.593,115.542z      M229.881,226.637l169.39-97.796v195.599l-169.39,97.794V226.637z"/>
                                                                </g>
                                                            </g>
                                                        </g>
                                                    </svg>
                                                </div>
                                            </a>
                                        </div>
                                    </li>

	</xsl:template>
	
	
	<xsl:template match="udata[@method = 'dealers_have']">
		<section class="modal modal__callback mfp-hide" id="modalWherebuy">
			<div class="wrapper">
				<div class="modal__content">
					<ul class="radio__buttons">
						<xsl:apply-templates select="items" mode="radio__buttons"/>
					</ul>
					<div class="shops__lists">
						<xsl:apply-templates select="items" mode="shop__list"/>
					</div>

					<div class="modal__close popup-modal-dismiss">
						<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="15px" height="15px" viewBox="0 0 17 17" version="1.1">
							<defs/>
							<g id="Icons" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" stroke-linecap="round">
								<g id="24-px-Icons" transform="translate(-364.000000, -124.000000)" stroke="#000000">
									<g id="ic_cancel" transform="translate(360.000000, 120.000000)">
										<g id="cross">
											<g transform="translate(5.000000, 5.000000)" stroke-width="2">
												<path d="M0,0 L14.1421356,14.1421356" id="Line"/>
												<path d="M14,0 L1.77635684e-15,14" id="Line"/>
											</g>
										</g>
									</g>
								</g>
							</g>
						</svg>
					</div>
				</div>
			</div>
		</section>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'dealers_have']/items" mode="radio__buttons">
		<li class="retail__radio radio__button">
			<a href="#">
				<xsl:value-of select="@name" disable-output-escaping="yes" />
			</a>
		</li>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'dealers_have']/items[1]" mode="radio__buttons">
		<li class="eshop__radio radio__button active">
			<a href="#">
				<xsl:value-of select="@name" disable-output-escaping="yes" />
			</a>
		</li>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'dealers_have']/items" mode="shop__list">
		<ul class="shop__list retail__list">
			<xsl:apply-templates select="item" mode="shop__list"/>
		</ul>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'dealers_have']/items[1]" mode="shop__list">
		<ul class="shop__list eshop__list active">
			<xsl:apply-templates select="item" mode="shop__list"/>
		</ul>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'dealers_have']/items/item" mode="shop__list">
		<li>
			<div class="shop__image">
				<img src="/images/footer__lamp.png" alt=""/>
			</div>
			<div class="shop__title">
				<xsl:value-of select="@name" disable-output-escaping="yes" />
			</div>
			<div class="shop__link">
				<a href="//{@site}">Перейти</a>
			</div>
		</li>
	</xsl:template>
</xsl:stylesheet>