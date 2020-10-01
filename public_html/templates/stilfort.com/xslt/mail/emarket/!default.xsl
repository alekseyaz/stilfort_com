<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output encoding="utf-8" method="html" indent="yes" />

	<xsl:template match="status_notification">
		<xsl:text>Ваш заказ #</xsl:text>
		<xsl:value-of select="order_number" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="status" />
		<br/><br/>
		<xsl:text>Посмотреть историю заказов вы можете в своем </xsl:text>
		<a href="http://{domain}/emarket/personal/">
			<xsl:text>личном кабинете</xsl:text>
		</a>.
	</xsl:template>

	<xsl:template match="status_notification_receipt">
		<xsl:text>Ваш заказ #</xsl:text>
		<xsl:value-of select="order_number" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="status" />
		<br/><br/>
		<xsl:text>Посмотреть историю заказов вы можете в своем </xsl:text>
		<a href="http://{domain}/emarket/personal/">
			<xsl:text>личном кабинете</xsl:text>
		</a>.
		<br/><br/>
		<xsl:text>Квитанцию на оплату вы можете получить, перейдя по </xsl:text>
		<a href="http://{domain}/emarket/receipt/{order_id}/{receipt_signature}/">
			<xsl:text>этой ссылке</xsl:text>
		</a>.
	</xsl:template>


		<xsl:template match="neworder_notification">
			<br/>


			<!--<xsl:apply-templates select="document(concat('uobject://', order_id))/udata" mode="unic" />-->

<!--1*<xsl:apply-templates  select="document(concat('uobject://',order_id))/udata/object/properties/group/property[@name='order_items']/value" mode ="tovar"/>*-->

		<xsl:text>Заказ #</xsl:text>
		<xsl:value-of select="order_number" />
		<xsl:text> (</xsl:text>
		<a href="http://{domain}/admin/emarket/order_edit/{order_id}/">
			<xsl:text>Просмотр</xsl:text>
		</a>
		<xsl:text>)</xsl:text><br/><br/>


<strong><xsl:text> Покупатель: </xsl:text></strong><br/>
<!--<xsl:apply-templates select="document(concat('uobject://',order_id))/udata/object/properties/group/property[@name='customer_id']/value/item" mode="cust"/><br/>-->

<!--<xsl:text> Имя: </xsl:text><xsl:value-of select="document(concat('uobject://',order_id))/udata//property[@name='imya_pokupatelya']/value"/><br/>
<xsl:text> Телефон: </xsl:text><xsl:value-of select="document(concat('uobject://',order_id))/udata//property[@name='telefon_pokupatelya']/value"/><br/>
<xsl:text> Адрес: </xsl:text><xsl:value-of select="document(concat('uobject://',order_id))/udata//property[@name='adres_dostavki']/value"/><br/>-->

<hr></hr>

<strong><xsl:text> Состав заказа: </xsl:text></strong><br/>
<table>
<xsl:apply-templates  select="document(concat('uobject://',order_id))/udata/object/properties/group/property[@name='order_items']/value/item" mode ="tovar"/>
<tr>
<td>
<strong><xsl:text> Сумма заказа: </xsl:text></strong>
</td>
<td></td><td></td>
<td>
<xsl:value-of  select="document(concat('uobject://',order_id))/udata/object/properties/group/property[@name='total_price']/value" /> руб.
</td>
</tr>
</table>

		</xsl:template>



<xsl:template match="item" mode ="tovar">
      <!--<xsl:value-of  select="@id" />-->
<tr>
<td>
<xsl:value-of  select="@name" /><xsl:text>  </xsl:text>
</td><td>
<xsl:value-of select="document(concat('uobject://',@id))/udata/object/properties/group/property[@name='item_amount']/value"/><xsl:text> шт. </xsl:text>
</td><td>
</td><td>
<xsl:text> - </xsl:text><xsl:value-of select="document(concat('uobject://',@id))/udata/object/properties/group/property[@name='item_total_price']/value"/><xsl:text> руб. </xsl:text><br/>
</td>
</tr>
</xsl:template>
	

<xsl:template match="item" mode ="cust">
      <!--<xsl:value-of  select="@id" />-<xsl:value-of  select="@name" /><br/>-->
<xsl:text> Имя: </xsl:text><xsl:value-of select="document(concat('uobject://',@id))/udata/object/properties/group/property[@name='imya_pokupatelya']/value"/><br/>
<xsl:text> Телефон: </xsl:text><xsl:value-of select="document(concat('uobject://',@id))/udata/object/properties/group/property[@name='telefon_pokupatelya']/value"/><br/>
<xsl:text> Адрес: </xsl:text><xsl:value-of select="document(concat('uobject://',@id))/udata/object/properties/group/property[@name='adres_dostavki']/value"/><br/>

</xsl:template>
	
	<xsl:template match="udata" mode="unic">
	



			<xsl:text>Покупатель:  </xsl:text>
			<xsl:if test="customer/object/properties/group[@name = 'short_info']/property[@name = 'fname']/value!=''">
			<xsl:value-of select="customer/object/properties/group[@name = 'short_info']/property[@name = 'fname']/value" /><br/>
			</xsl:if>
			<xsl:if test="customer/object/properties/group[@name = 'personal_info']/property[@name = 'fname']/value!=''">
			<xsl:value-of select="customer/object/properties/group[@name = 'personal_info']/property[@name = 'fname']/value" /><br/>
			</xsl:if>


			<xsl:text>Телефон:  </xsl:text>
			<xsl:if test="customer/object/properties/group[@name = 'short_info']/property[@name = 'phone']/value!=''">
			<xsl:value-of select="customer/object/properties/group[@name = 'short_info']/property[@name = 'phone']/value" /><br/>
			</xsl:if>
			<xsl:if test="customer/object/properties/group[@name = 'contact_props']/property[@name = 'phone']/value!=''">
			<xsl:value-of select="customer/object/properties/group[@name = 'contact_props']/property[@name = 'phone']/value" /><br/>
			</xsl:if>


				  <div class="order">
				   <hr/>
				   <xsl:apply-templates select="result/data/object/@name" mode="lin"/>
				   <hr/>

				   <p>Всего товаров: <xsl:value-of select="summary/amount" /> шт.</p>
				   <p>На сумму: <xsl:value-of select="summary/price" /><xsl:value-of select="summary/price/@suffix" />. </p>
				   </div>
					<p>Спасибо за покупку, с Уважением администрация магазина</p>

	</xsl:template>
				 
	<xsl:template match="udata//item" mode="lin">
		<p><a href="{page/@link}"><xsl:value-of select="@name"/></a></p>
		<p>Цена:  <xsl:value-of select="price"/> <xsl:value-of select="price/@suffix" />. Количество: <xsl:value-of select="amount"/> шт.</p>
	</xsl:template>


	
	
	
	
</xsl:stylesheet>