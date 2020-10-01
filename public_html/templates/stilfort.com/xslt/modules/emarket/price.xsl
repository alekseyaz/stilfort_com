<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet	version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	
	
	<xsl:template match="udata[@method = 'price' or @method = 'getMinOptionsPrice']">
		<span class="price">
			<span class="woocs_price_code">
				<span class="amount notavailable">По запросу</span>
			</span>
	    </span>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'price' or @method = 'getMinOptionsPrice'][price/actual or price/original]">
		<span class="price">
			<span class="woocs_price_code">
				<xsl:apply-templates select="price" />
			</span>
	    </span>
	</xsl:template>

	
	<xsl:template match="total-price" mode="discounted-price">
		<span class="amount">
			<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
			<xsl:text> руб.</xsl:text>
		</span>
	</xsl:template>
	
	<xsl:template match="total-price">
		<span class="amount notavailable">По запросу</span>
	</xsl:template>
	
	<xsl:template match="total-price[actual]">
		<span class="amount price_actual">
			<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
			<xsl:text> руб.</xsl:text>
		</span><xsl:text> </xsl:text>
		<span class="amount price_old"></span>
	</xsl:template>

	<xsl:template match="total-price[original]">
		<span class="amount price_actual">
			<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
			<xsl:text> руб.</xsl:text>
		</span><xsl:text> </xsl:text>
		<span class="amount price_old">
			<xsl:value-of select="format-number(original, '### ##0', 'df')" />
			<xsl:text> руб.</xsl:text>
		</span>
	</xsl:template>

	<xsl:template match="price" mode="discounted-price">
		<span class="amount ">
			<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
			<xsl:text> руб.</xsl:text>
		</span>
	</xsl:template>

	
	
	<xsl:template match="price">
		<span class="price">
			<span class="woocs_price_code">
				<span class="amount notavailable">По запросу</span>
			</span>
		</span>
	</xsl:template>
	
	<xsl:template match="price[actual]">
		<span class="price">
			<span class="woocs_price_code">
				<span class="amount">
					<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
					<xsl:text> руб.</xsl:text>
				</span>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="price[original]">
		<del>
			<span class="amount">
				<xsl:value-of select="format-number(original, '### ##0', 'df')" />
				<xsl:text> руб.</xsl:text>
			</span>
		</del>
		<ins>
			<span class="amount">
				<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
				<xsl:text> руб.</xsl:text>
			</span>
		</ins>
	</xsl:template>
	
	
	<xsl:template match="udata[@method = 'price' or @method = 'getMinOptionsPrice']" mode="in_object">
		<p class="price">
			<span class="woocs_price_code">
				<span class='amount notavailable'>По запросу</span>
			</span>
		</p>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'price' or @method = 'getMinOptionsPrice'][price/actual or price/original]" mode="in_object">
		<p class="price">
			<span class="woocs_price_code">
				<xsl:apply-templates select="price" mode="in_object"/>
			</span>
	    </p>
	</xsl:template>
	
	<xsl:template match="price" mode="in_object">
		<span class='amount notavailable'>По запросу</span>
	</xsl:template>
	
	<xsl:template match="price[actual]" mode="in_object">
		<!--<p class="price">
			<span class="woocs_price_code">-->
				<span class="amount" itemprop="price">
					<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
					<xsl:text> руб.</xsl:text>
				</span>
			<!--</span>
		</p>-->
	</xsl:template>

	<xsl:template match="price[original]" mode="in_object">
		<del>
			<span class="amount">
				<xsl:value-of select="format-number(original, '### ##0', 'df')" />
				<xsl:text> руб.</xsl:text>
			</span>
		</del>
		<ins>
			<span class="amount" itemprop="price">
				<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
				<xsl:text> руб.</xsl:text>
			</span>
		</ins>
	</xsl:template>
	
	
	
	<xsl:template match="udata[@method = 'price' or @method = 'getMinOptionsPrice']" mode="in_cart">
		<span class="price">
			<span class="woocs_price_code">
				<span class='amount notavailable'>По запросу</span>
			</span>
	    </span>
	</xsl:template>
	
	<xsl:template match="udata[@method = 'price' or @method = 'getMinOptionsPrice'][price/actual or price/original]" mode="in_cart">
		<span class="price">
			<span class="woocs_price_code">
				<xsl:apply-templates select="price" mode="in_cart"/>
			</span>
	    </span>
	</xsl:template>
	
	<xsl:template match="price" mode="in_cart">
		<span class="amount price_actual" itemprop="price">
			<span class='amount notavailable'>По запросу</span>
		</span><xsl:text> </xsl:text>
		<span class="amount price_old"></span>
	</xsl:template>
	
	<xsl:template match="price[actual]" mode="in_cart">
		<span class="amount price_actual" itemprop="price">
			<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
			<xsl:text> руб.</xsl:text>
		</span><xsl:text> </xsl:text>
		<span class="amount price_old"></span>
	</xsl:template>

	<xsl:template match="price[original]" mode="in_cart">
		<span class="amount price_actual">
			<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
			<xsl:text> руб.</xsl:text>
		</span><xsl:text> </xsl:text>
		<span class="amount price_old">
			<xsl:value-of select="format-number(original, '### ##0', 'df')" />
			<xsl:text> руб.</xsl:text>
		</span>
	</xsl:template>
	
	
	<xsl:template match="price" mode="in_cart_original">
		<span class='amount price_old'>
			<xsl:text>0 руб.</xsl:text>
		</span>
	</xsl:template>
	
	<xsl:template match="price[actual]" mode="in_cart_original">
		<span class="amount price_old">
			<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
			<xsl:text> руб.</xsl:text>
		</span>
	</xsl:template>
	
	<xsl:template match="price[original]" mode="in_cart_original">
		<span class="amount price_old">
			<xsl:value-of select="format-number(original, '### ##0', 'df')" />
			<xsl:text> руб.</xsl:text>
		</span>
	</xsl:template>
	
	<xsl:template match="price" mode="in_cart_actual">
		<span class="amount price_actual">
			<xsl:text>0 руб.</xsl:text>
		</span>
	</xsl:template>
	
	<xsl:template match="price[actual]" mode="in_cart_actual">
		<span class="amount price_actual">
			<xsl:value-of select="format-number(actual, '### ##0', 'df')" />
			<xsl:text> руб.</xsl:text>
		</span>
	</xsl:template>
</xsl:stylesheet>
