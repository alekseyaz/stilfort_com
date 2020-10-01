<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'content' and page/@alt-name = 'flagman']">
	  <xsl:call-template name="navibar" />
	  <section class="flagmans">
        <div class="wrapper">
            <div class="flagmans__content">
                <div class="flagmans__title h2"><xsl:value-of select=".//property[@name = 'h1']/value" /></div>
                   
				   <xsl:apply-templates select="document('udata://catalog/getObjectsByFlag/////flagmanskie_produkty/')/udata" 
				mode="flagmanskie_produkty"/>
				
			
            </div>
        </div>
       </section>
	</xsl:template>
	
	
		<!--flagmanskie_produkty-->
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']" mode="flagmanskie_produkty">
		        <xsl:apply-templates select="lines" mode="flagmanskie_produkty"/>		  
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines" mode="flagmanskie_produkty">
	     <div class="flagmans__list">	 
			  <xsl:apply-templates select="item" mode="flagmanskie_produkty"/>			
          </div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'catalog' and @method = 'getObjectsByFlag']/lines/item" mode="flagmanskie_produkty">
	       <xsl:variable name="page" select="document(concat('upage://', @id))/udata/page" />        

				  <div class="flagman__wrapper">
                        <a href="{@link}" class="flagman__link"></a>
                        <div class="flagman">
                            <div class="flagman__info">
                                
                                <div class="flagman__title">
                                    <xsl:value-of select="@name" />
                                </div>
								
                     
							
					<xsl:choose>
                            <xsl:when test="$page//property[@name='stoimost_new']">
					       <div class="flagman__price">
                                  от  <xsl:apply-templates select="$page//property[@name='stoimost_new']/value" mode="cena"/>
                               </div>							   
                           </xsl:when>
                           <xsl:otherwise>
						  <div class="flagman__price">
                                от  <xsl:apply-templates select="$page//property[@name='stoimost']/value" mode="cena"/>
                               </div>  
                          </xsl:otherwise>
                        </xsl:choose>
								
                                <div class="flagman__button item__button">
                                    <a href="{@link}">Смотреть товар</a>
                                </div>
                            </div>
                            <div class="flagman__image">
								
					<img src="{document(concat('udata://system/makeThumbnailFull/(',$page//property[@name='foto_tovara']/value[1]/@path, ')/930/546///'))/udata/src}" alt="{$page//property[@name='foto_tovara']/value[1]/@alt}"/>			
								
								
                            </div>
                        </div>
                    </div>
	</xsl:template>


</xsl:stylesheet>