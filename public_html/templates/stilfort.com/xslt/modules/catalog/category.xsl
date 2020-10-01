<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'catalog' and @method = 'category']">
		<xsl:variable name="category" select="document(concat('udata://catalog/getCategoryList//',page/@id,'/100/1/0/'))/udata" />
		<xsl:call-template name="navibar" />

		<section class="results">
			<div class="wrapper">
				<div class="results__content">
					<div class="results__header">
						<div class="results__title h2">
							<xsl:value-of select=".//property[@name = 'h1']/value" />
						</div>
						
						<xsl:apply-templates select="$category" mode="razdeli_v_razdele"/>
						
						<xsl:if test="not($category/items/item) and not(page/@parentId = 0)">
							<xsl:apply-templates select="document(concat('udata://catalog/getCategoryList//',page/@parentId,'/100/1/0/'))/udata" mode="razdeli_v_razdele"/>
						</xsl:if>
					</div>
					
					
					<xsl:apply-templates select="document(concat('udata://catalog/getSmartFilters//' ,page/@id, '//100/87//'))/udata" />

					
					<xsl:apply-templates select="document(concat('udata://catalog/getSmartCatalog//', page/@id, '///100///'))/udata"/>

				</div>
			</div>
		</section>
	</xsl:template>
	
	
	<xsl:template match="result[@module = 'catalog' and @method = 'category' and (page/@alt-name='katalog' or page/@alt-name='catalog')]">
		<xsl:call-template name="navibar" />
		<section class="catalog">
			<div class="wrapper">
				<div class="catalog__content">
					<div class="catalog__title h2">
						<xsl:value-of select=".//property[@name = 'h1']/value" />
					</div>
					<xsl:apply-templates select="$homepage//group[@name='pdf_download']" mode="pdf_download_btn" />
					<!--<xsl:apply-templates select="document('udata://catalog/getCategoryList//0/100/1/100/')/udata" mode="razdeli_v_cataloge"/>-->
					<div class="catalogHome__grid">
						<xsl:apply-templates select="document('udata://catalog/getCategoryList//0/100/1/100/')/udata/items/item" mode="catalog_glavnaya"/>
					</div>
				</div>
			</div>
       </section>
	</xsl:template>

	<xsl:template match="result[@module = 'catalog' and @method = 'category' and page/@id = 1497]">
		<xsl:variable name="category" select="document(concat('udata://catalog/getCategoryList//',page/@id,'/100/1/0/'))/udata" />
		<xsl:call-template name="navibar" />

		<section class="results">
			<div class="wrapper">
				<div class="results__content">
					<div class="results__header">
						<div class="results__title h2">
							<xsl:value-of select=".//property[@name = 'h1']/value" />
						</div>
						
						<xsl:apply-templates select="$category" mode="razdeli_v_razdele"/>
						
						<xsl:if test="not($category/items/item) and not(page/@parentId = 0)">
							<xsl:apply-templates select="document(concat('udata://catalog/getCategoryList//',page/@parentId,'/100/1/0/'))/udata" mode="razdeli_v_razdele"/>
						</xsl:if>
					</div>
					
					
					<xsl:apply-templates select="document(concat('udata://catalog/getSmartFilters//' ,page/@id, '//100/87//'))/udata" />

					
					<xsl:apply-templates select="document(concat('udata://catalog/getSmartCatalog//', 0, '///100///'))/udata"/>

				</div>
			</div>
		</section>
	</xsl:template>
	
	<xsl:template match="group[@name='pdf_download']" mode="pdf_download_btn"/>
	<xsl:template match="group[@name='pdf_download' and .//property[@name='file_download']/value and .//property[@name='zagolovok_download']/value]" mode="pdf_download_btn">
		<div class="pdf_download_calalog">
		<div class="additional__button">
			<a href="{.//property[@name='file_download']/value}"><xsl:value-of select=".//property[@name='zagolovok_download']/value" />
				<div class="additional__icon">
					<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" id="Layer_1" style="enable-background:new 0 0 512 512;" version="1.1" viewBox="0 0 512 512" xml:space="preserve"><g id="XMLID_1302_"><g id="XMLID_1297_"><g id="XMLID_1303_"><g id="XMLID_1313_"><g id="XMLID_1316_"><polygon id="XMLID_1317_" points="419.3,112.9 319.7,112.9 319.7,13.3 334.2,13.3 334.2,98.4 419.3,98.4      "/></g><g id="XMLID_1314_"><polygon id="XMLID_1315_" points="426.6,506 37.9,506 37.9,6 334,6 426.6,102.7 426.6,256 412.1,256 412.1,108.6 327.8,20.5        52.4,20.5 52.4,491.5 412.1,491.5 412.1,457.1 426.6,457.1      "/></g></g><g id="XMLID_1304_"><g id="XMLID_1311_"><rect height="14.5" id="XMLID_1312_" width="197.1" x="98.7" y="111.4"/></g><g id="XMLID_1309_"><rect height="14.5" id="XMLID_1310_" width="129.9" x="98.7" y="154.2"/></g><g id="XMLID_1307_"><rect height="14.5" id="XMLID_1308_" width="267" x="98.7" y="197.1"/></g><g id="XMLID_1305_"><rect height="14.5" id="XMLID_1306_" width="267" x="98.7" y="239.9"/></g></g></g><g id="XMLID_1298_"><path d="M419.3,475L341,361.7h33.5v-113h89.8v113h33.5L419.3,475z M368.7,376.2l50.7,73.3l50.7-73.3h-20.3v-113     H389v113H368.7z" id="XMLID_1299_"/></g></g><g id="XMLID_2055_"><path d="M92.6,367.5H81.8v17.7h10.8c3.1,0,5.4-0.8,7-2.5c1.6-1.6,2.3-3.7,2.3-6.3c0-2.5-0.8-4.7-2.3-6.4    C98,368.3,95.7,367.5,92.6,367.5z" id="XMLID_2056_"/><path d="M136.8,367.5h-8.2v36.6h8.2c4,0,7.2-1.4,9.5-4.1c2.4-2.7,3.5-6.2,3.5-10.5v-7.7c0-4.2-1.2-7.7-3.5-10.4    C144,368.8,140.8,367.5,136.8,367.5z" id="XMLID_2057_"/><path d="M282,328.3H14.3v115H282l-56.9-57.5L282,328.3z M105.5,387.6c-3.1,2.8-7.4,4.2-13,4.2H81.8v19h-8.3v-50    h19.2c5.5,0,9.8,1.4,13,4.3c3.1,2.9,4.7,6.6,4.7,11.2C110.2,381,108.7,384.7,105.5,387.6z M158.3,389.6c0,6.3-2,11.3-6,15.3    c-4,3.9-9.1,5.9-15.5,5.9h-16.5v-50h16.5c6.3,0,11.5,2,15.5,5.9c4,4,6,9.1,6,15.3V389.6z M201.5,367.5h-23.7v15.3H198v6.7h-20.2    v21.3h-8.3v-50h32V367.5z" id="XMLID_2164_"/></g></g></svg>
				</div>
			</a>
		</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
