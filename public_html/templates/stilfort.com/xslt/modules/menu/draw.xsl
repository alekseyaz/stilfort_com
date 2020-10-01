<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Default menu -->
	<xsl:template match="udata[@module = 'menu']">
		<ul>
			<xsl:apply-templates select="item"/>
		</ul>
	</xsl:template>

	<xsl:template match="udata[@module = 'menu']/item">
		<li>
			<a href="{@link}">
				<xsl:value-of select="node()" />
			</a>
		</li>
	</xsl:template>
	
	
	

	<!-- top_menu -->
	<xsl:template match="udata[@module = 'menu']" mode="top_menu">
		<nav class="header__nav">
            <ul class="header__list">
			<xsl:apply-templates select="item" mode="top_menu" />
		   </ul>
		</nav>
	</xsl:template>

	<xsl:template match="udata[@module = 'menu']//item" mode="top_menu">
		<li>
			<a href="{@link}">
				<xsl:value-of select="node()" />
			</a>
		</li>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'menu']//item[@link = '/emarket/compare/' or @link = '/compare/']" mode="top_menu">
		<li class="compare_link">
			<a href="{@link}">
				<xsl:value-of select="node()" /><sup></sup>
			</a>
		</li>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'menu']//item[@link = '/favorite/']" mode="top_menu">
		<li class="favorite_link">
			<a href="{@link}">
				<xsl:value-of select="node()" /><sup></sup>
			</a>
		</li>
		
	</xsl:template>
	
	<!-- top_menu_mob -->
	<xsl:template match="udata[@module = 'menu']" mode="top_menu_mob">
	   <ul class="mobile__menu">
		  <xsl:apply-templates select="item" mode="top_menu" />
		  <li>
            <a href=""><xsl:value-of select="$homepage//property[@name='contact_phone']/value" /></a>
          </li>
          <li>
            <a href="#modalCallback" class="popup-modal">Заказать звонок</a>
          </li>
		  <xsl:apply-templates select="$homepage//group[@name='socseti']" mode="socseti_mob" />
	   </ul>
	</xsl:template>

	
	
	
	<!-- bottom_menu -->
	<xsl:template match="udata[@module = 'menu']" mode="bottom_menu">
		 <div class="footer__lists">
			<xsl:apply-templates select="item" mode="bottom_menu" />
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'menu']/item" mode="bottom_menu">
	      
		 <ul class="footer__list footer__list-{@name}">
		    <li class="footer_list_title">
		     <span>
				<xsl:value-of select="node()" />
	          </span>
			</li>
			<xsl:apply-templates select="items" mode="bottom_menu"/>
		</ul>
	</xsl:template>
	
	
	
	<xsl:template match="udata[@module = 'menu']/item[@name='Контакты']" mode="bottom_menu">	      
		 <ul class="footer__list footer__list-{@name}">
		   <li class="footer_list_title">
		     <a href="{@link}">
				<xsl:value-of select="node()" />
	          </a>
		    </li>
			  <xsl:apply-templates select="$homepage//group[@name='kontakty']" mode="kontakty_footer" />
			  <xsl:apply-templates select="$homepage//group[@name='socseti']" mode="socseti" />
		</ul>
	</xsl:template>
		
	<xsl:template match="udata[@module = 'menu']/item/items" mode="bottom_menu">
		<xsl:apply-templates select="item" mode="bottom_menu_2"/>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'menu']/item/items/item" mode="bottom_menu_2">
	    <li>
			<a href="{@link}">
				<xsl:if test="@name='Личный кабинет'">
					<xsl:attribute name="target">_blank</xsl:attribute>
					<xsl:attribute name="rel">nofollow</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="node()" />
			</a>
		</li>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'menu']/item/items/item[@name='Заказать звонок']" mode="bottom_menu_2">
	    <li>
			<a href="#modalCallback" class="popup-modal">
				<xsl:value-of select="node()" />
			</a>
		</li>
	</xsl:template>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

</xsl:stylesheet>