<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">




	<xsl:template match="/result[@method = 'ordersList']">
		<div id="center_column" class="center_column col-xs-12 col-sm-12">
		      <h1>&users_ordersList_h1;</h1>
				<div class="picmen2">
					<a href="/emarket/ordersList" class="current">&myorder;</a>
					<span>|</span>
					<a href="/users/settings">&persinfo;</a>
				</div>
		      <div class="commbox"></div>
		      
			<div class="row">

				
				<div class="col-xs-12 col-sm-12 wfon">
					<div style="display: block;" id="noSlide">

						<div id="account-creation_form" class="std box ">
							<xsl:apply-templates select="document('udata://emarket/ordersList')/udata" />
						</div>
					</div>
			
				</div>

			</div>

		</div>

		
	
	
<!--		<div id="lay_body">
			<div class="tittt">&users_ordersList_h1;</div>


	
	
		<div class="tutabo">
			<div class="preftit">
				<span class="tittt"></span>
				<div class="picmen2">
					<a href="/emarket/ordersList" class="current">&myorder;</a>
					<span>|</span>
					<a href="/users/settings">&persinfo;</a>
				</div>
			</div>
			<div class="about">
				<xsl:apply-templates select="document('udata://emarket/ordersList')/udata" />
			</div>
		</div>
		
		
		</div>	-->	
	</xsl:template>

	<!--<xsl:template match="udata[@method = 'ordersList']"/>-->
	
	<xsl:template match="udata[@method = 'ordersList']">
		<div id="con_tab_orders">
			<xsl:if test="$method = 'personal'">
				<xsl:attribute name="style">display: none;</xsl:attribute>
			</xsl:if>

			<table class="blue">
				<thead>
					<tr>
						<th class="name">
							<xsl:text>&order-number;</xsl:text>
						</th>

						<th class="name">
							<xsl:text>&order-status;</xsl:text>
						</th>

						<th>
							<xsl:text>&order-sum;</xsl:text>
						</th>
					</tr>
							<tr>
			<td colspan="3" class="separate"></td>
		</tr>
				</thead>
				<tbody>
					<xsl:apply-templates select="items/item" mode="order" />
				</tbody>
			</table>
		</div>
	</xsl:template>

	<xsl:template match="item" mode="order">
		<xsl:apply-templates select="document(concat('udata://emarket/order/', @id))" />
		<tr>
			<td colspan="3" class="separate"></td>
		</tr>
	</xsl:template>

	<xsl:template match="item[position() = last()]" mode="order">
		<xsl:apply-templates select="document(concat('udata://emarket/order/', @id))" />
	</xsl:template>


	<xsl:template match="udata[@module = 'emarket'][@method = 'order']">
		<tr>
			<td class="name">
				<strong>
					<xsl:text>&number; </xsl:text>
					<xsl:value-of select="number" />
				</strong>
				<div>
					<xsl:text>&date-from; </xsl:text>
					<xsl:apply-templates select="document(concat('uobject://', @id, '.order_date'))//property" />
				</div>
			</td>
			<td class="name">
				<xsl:value-of select="status/@name" />
				<div>
					<xsl:text>&date-from-1; </xsl:text>
					<xsl:apply-templates select="document(concat('uobject://', @id, '.status_change_date'))//property" />
				</div>
			</td>
			<td class="name">ИТОГО:<xsl:apply-templates select="summary/price" mode="discounted-price"/></td>
		</tr>

		<xsl:apply-templates select="items/item" />
		<xsl:apply-templates select="summary/price/delivery" />
		<xsl:apply-templates select="summary/price/discount" />
	</xsl:template>

	<xsl:template match="udata[@method = 'order']/items/item">
		<tr>
			<td colspan="2" class="name">
				<a href="{page/@link}">
					<xsl:value-of select="@name" />
				</a>
			</td>

			<td>
				<xsl:apply-templates select="price" mode="discounted-price"/>
				<xsl:text> x </xsl:text>
				<xsl:apply-templates select="amount" />
				<xsl:text> = </xsl:text>
				<xsl:apply-templates select="total-price" mode="discounted-price" />
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="summary/price/delivery[.!='']">
		<tr>
			<td colspan="2" class="name">
				<strong>Доставка</strong>
			</td>
			<td><span class="price product-price product-price-new"><xsl:value-of select="document(concat('udata://custom/formatprice/',.))" /><xsl:text> </xsl:text><span class="curency">i</span></span>
<!--				<xsl:value-of select="." />
					<xsl:text> </xsl:text>
				<xsl:value-of select="../@suffix" />-->
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="summary/price/discount[.!='']">
		<tr>
			<td colspan="2" class="name">
				<strong>Скидка</strong>
			</td>
			<td><span class="price product-price product-price-new"><xsl:value-of select="document(concat('udata://custom/formatprice/',.))" /><xsl:text> </xsl:text><span class="curency">i</span></span>
<!--				<xsl:value-of select="." />
					<xsl:text> </xsl:text>
				<xsl:value-of select="../@suffix" />-->
			</td>
		</tr>
	</xsl:template>

</xsl:stylesheet>