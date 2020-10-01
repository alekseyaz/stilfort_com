<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>


	<xsl:template match="result[@module = 'content' and @method = 'content' and page/@type-id='140' ]">
   
			<section class="about about__single">
				<div class="wrapper">
				<xsl:call-template name="navibar" />
					<xsl:apply-templates select=".//group[@name='slajder_o_kompanii']" mode="slajder_o_kompanii" />
				</div>
			</section>
	
	        <xsl:apply-templates select=".//group[@name='stilfort']" mode="stilfort_about" />

            <xsl:apply-templates select=".//group[@name='sertifikaty_kompanii']" mode="sertifikaty" />

            <xsl:apply-templates select=".//group[@name='preimuwestva']" mode="preimuwestva" />

            <xsl:apply-templates select=".//group[@name='proizvodstvo']" mode="proizvodstvo" />

		  
	</xsl:template>
	
	
	<!--slajder_o_kompanii-->
	<xsl:template match="group" mode="slajder_o_kompanii">
	    <div class="about__content">
          <div class="about__slider">
		     <xsl:apply-templates select=".//property[starts-with(@name,'foto_o_kompanii_')]" mode="foto_o_kompanii" />
          </div>
        </div>
	</xsl:template>
	
	<xsl:template match="property" mode="foto_o_kompanii">
	  <xsl:variable name="name" select="concat('o_kompanii_', substring-after(@name, 'foto_o_kompanii_'))"/>
	    <div class="about__slide about__slide-{substring-after(@name, 'foto_o_kompanii_')}">
            <div class="slide__title h2">О Stilfort</div>
			<xsl:apply-templates select="../property[@name=$name]" mode="o_kompanii_descr" />
 
                <div class="slider__image">
                   <img src="{value}" alt="{value/@alt}"/>
                </div>
        </div>
	</xsl:template>
	
	<xsl:template match="property" mode="o_kompanii_descr">
	    <div class="slide__description">
           <xsl:value-of select="value" disable-output-escaping="yes"/>
        </div>
	</xsl:template>
	
	<!--stilfort_about-->
	<xsl:template match="group" mode="stilfort_about">
		<section class="facts facts__about">
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

	<!--sertifikaty-->
	<xsl:template match="group" mode="sertifikaty">
    <section class="certificates">
        <div class="wrapper">
            <div class="certificates__wrapper-inner">
                <div class="certificates__content">
                    <div class="certificates__title h2"><xsl:value-of select="title"/></div>
                    <div class="certificates__list certificates__slider">
                        <xsl:apply-templates select=".//property" mode="sertifikaty" />  
                    </div>
					<div class="certificates__text">
						Вся продукция сертифицирована для реализации на территории РФ и стран таможенного союза
					</div>
                </div>
            </div>
        </div>
    </section>
	</xsl:template>
	
	<xsl:template match="property" mode="sertifikaty">
	   <xsl:apply-templates select="value" mode="sertifikaty" />  
	</xsl:template>
	
	<xsl:template match="value" mode="sertifikaty">
	    <div class="certificate">
            <div class="certificate__image">
                <img src="{.}" alt="{@alt}"/>
            </div>
            <div class="certificate__title">
                <xsl:value-of select="@title" disable-output-escaping="yes"/>
            </div>
        </div>
	</xsl:template>
	
	<!--preimuwestva-->
	<xsl:template match="group" mode="preimuwestva">
	 <section class="advantages">
        <div class="wrapper">
            <div class="advantages__content">
                <div class="advantages__list advantages__desktop">
				 <xsl:apply-templates select=".//property[starts-with(@name,'foto_preimuwestva_')]" mode="foto_preimuwestva" />        
                </div>
                <div class="advantages__list advantages__mobile">
				 <xsl:apply-templates select=".//property[starts-with(@name,'foto_preimuwestva_')]" mode="foto_preimuwestva" />               
                </div>
            </div>
        </div>
    </section>
	</xsl:template>
	
	<xsl:template match="property" mode="foto_preimuwestva">
	  <xsl:variable name="name" select="concat('preimuwestvo_', substring-after(@name, 'foto_preimuwestva_'))"/>
	  		
		<div class="advantage">
               <div class="advantage__icon">
                   <img src="{value}" alt="{value/@alt}"/>
               </div>
			   <xsl:apply-templates select="../property[@name=$name]" mode="preimuwestvo" />
          </div>
	</xsl:template>
	
	<xsl:template match="property" mode="preimuwestvo">
	     <div class="advantage__title">
              <xsl:value-of select="value" disable-output-escaping="yes"/>
          </div>
	</xsl:template>
	
	
	<!--proizvodstvo-->
	<xsl:template match="group" mode="proizvodstvo">
    <section class="production">
        <div class="wrapper">
            <div class="production__content">
                <div class="production__info">
                    <div class="production__title h2"><xsl:value-of select="title"/></div>
                         <xsl:apply-templates select=".//property[starts-with(@name,'produkciya_')]" mode="produkciya" />
					 <xsl:apply-templates select=".//property[@name='foto_produkcii']" mode="foto_produkcii" />  
                </div>
            </div>
        </div>
    </section>
	</xsl:template>
	
	<xsl:template match="property" mode="produkciya">
	  <xsl:variable name="name" select="concat('opisanie_produkcii_', substring-after(@name, 'produkciya_'))"/>
	  				  
		    <div class="production__cell production__cell-{substring-after(@name, 'produkciya_')}">
                   <div class="production__name">
                        <xsl:value-of select="value" disable-output-escaping="yes"/>
                    </div>
					<xsl:apply-templates select="../property[@name=$name]" mode="opisanie_produkcii" />
               </div> 
	</xsl:template>
	
	<xsl:template match="property" mode="opisanie_produkcii">
	     <div class="production__description">
               <xsl:value-of select="value" disable-output-escaping="yes"/>
         </div>
	</xsl:template>
	
	<xsl:template match="property" mode="foto_produkcii">
         <div class="production__slider-wrapper">
              <div class="production__slider">
			    <xsl:apply-templates select="value" mode="foto_produkcii" />  
              </div>
         </div>
	</xsl:template>
	
	<xsl:template match="value" mode="foto_produkcii">
	     <div class="production__slide">
              <img src="{.}" alt="{@alt}"/>
         </div>
	</xsl:template>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


</xsl:stylesheet>