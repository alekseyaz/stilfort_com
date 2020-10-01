<?xml version="1.0" encoding="UTF-8"?>
<!--
TODO: // Write here your own templates
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl"
	xmlns:udt="http://umi-cms.ru/2007/UData/templates"
	extension-element-prefixes="php"
	exclude-result-prefixes="xsl php udt">

	
	
	<xsl:template match="Каталог">
		<pages>
			<!-- Разделы каталога -->
			<xsl:apply-templates select="/КоммерческаяИнформация/Классификатор/Группы/Группа/Группы/Группа" mode="groups_root" />

			<!-- Объекты каталога -->
			<xsl:apply-templates select="Товары/Товар" />
		</pages>
	</xsl:template>

	<xsl:template match="Группы/Группа" mode="groups_root">
		<page id="{Ид}" type-id="root-catalog-category-type">

			<default-active>
				<xsl:value-of select="$catalog_rubric_activity" />
			</default-active>

			<default-visible>
				<xsl:value-of select="$catalog_rubric_visible" />
			</default-visible>

			<basetype module="catalog" method="category">Разделы каталога</basetype>

			<name><xsl:value-of select="Наименование" /></name>

			<xsl:if test="string-length($catalog_rubric_template)">
				<default-template>
					<xsl:value-of select="$catalog_rubric_template" />
				</default-template>
			</xsl:if>

			<properties>
				<xsl:call-template name="common-group">
					<xsl:with-param name="name" select="Наименование" />
				</xsl:call-template>
			</properties>
		</page>

		<xsl:apply-templates select="Группы/Группа" mode="groups" />
	</xsl:template>

	<xsl:template match="Группы/Группа" mode="groups">
		<page id="{Ид}" parentId="{$catalog-id}" type-id="root-catalog-category-type">
			<xsl:if test="$isCatalogItemsRestoreOnImport = 1">
				<xsl:attribute name="is-deleted">0</xsl:attribute>
			</xsl:if>

			<xsl:if test="name(../../.) = 'Группа'">
				<xsl:attribute name="parentId"><xsl:value-of select="../../Ид" /></xsl:attribute>
			</xsl:if>

			<default-active>
				<xsl:value-of select="$catalog_rubric_activity" />
			</default-active>

			<default-visible>
				<xsl:value-of select="$catalog_rubric_visible" />
			</default-visible>

			<basetype module="catalog" method="category">Разделы каталога</basetype>

			<name><xsl:value-of select="Наименование" /></name>

			<xsl:if test="string-length($catalog_rubric_template)">
				<default-template>
					<xsl:value-of select="$catalog_rubric_template" />
				</default-template>
			</xsl:if>

			<properties>
				<xsl:call-template name="common-group">
					<xsl:with-param name="name" select="Наименование" />
				</xsl:call-template>
			</properties>
		</page>

		<xsl:apply-templates select="Группы" mode="groups" />
	</xsl:template>
	
	<xsl:template match="Товары/Товар">
		<xsl:param name="group_id" select="string(Группы/Ид)" />

		<xsl:param name="name">
			<xsl:choose>
				<xsl:when test="string-length(ПолноеНаименование)">
					<xsl:value-of select="ПолноеНаименование" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="Наименование" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>

		<page id="{Ид}" parentId="{$group_id}" type-id="{$group_id}">
			<xsl:choose>
				<xsl:when test="Статус = 'Удален'">
					<xsl:attribute name="is-deleted">1</xsl:attribute>
				</xsl:when>
				<xsl:when test="$isCatalogItemsRestoreOnImport = 1">
					<xsl:attribute name="is-deleted">0</xsl:attribute>
				</xsl:when>
			</xsl:choose>

			<xsl:if test="not(Группы/Ид)">
				<xsl:attribute name="parentId"><xsl:value-of select="$catalog-id" /></xsl:attribute>
				<xsl:attribute name="type-id">root-catalog-object-type</xsl:attribute>
			</xsl:if>

			<default-active>
				<xsl:value-of select="$catalog_item_activity" />
			</default-active>

			<default-visible>
				<xsl:value-of select="$catalog_item_visible" />
			</default-visible>

			<basetype module="catalog" method="object">Объекты каталога</basetype>

			<name><xsl:value-of select="$name" /></name>

			<xsl:if test="string-length($catalog_item_template)">
				<default-template>
					<xsl:value-of select="$catalog_item_template" />
				</default-template>
			</xsl:if>

			<properties>
				<xsl:call-template name="common-group">
					<xsl:with-param name="name" select="$name" />
				</xsl:call-template>

				<group name="product">
					<title>1C: Общие свойства</title>

					<xsl:if test="string-length(Описание)">
						<property name="description" title="Описание" type="wysiwyg" allow-runtime-add="1">
							<type data-type="wysiwyg" />
							<title>Описание</title>
							<value>
								<xsl:choose>
									<xsl:when test="Описание/@ФорматHTML = 'true'">
										<xsl:value-of select="Описание"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="php:function('nl2br', string(Описание))" disable-output-escaping="yes" />
									</xsl:otherwise>
								</xsl:choose>
							</value>
						</property>
					</xsl:if>

					<property name="1c_catalog_id" type="string">
						<title>Идентификатор каталога 1С</title>
						<value><xsl:value-of select="$catalog-id" /></value>
					</property>

					<property name="1c_product_id" type="string">
						<title>Идентификатор в 1С</title>
						<value><xsl:value-of select="Ид" /></value>
					</property>

					<property name="artikul" type="string">
						<title>Артикул</title>
						<value><xsl:value-of select="Артикул" /></value>
					</property>

					<property name="bar_code" type="string">
						<title>Штрих-код</title>
						<value><xsl:value-of select="Штрихкод" /></value>
					</property>

					<property name="weight" type="float">
						<title>Вес</title>
						<value><xsl:value-of select="ЗначенияРеквизитов/ЗначениеРеквизита[Наименование = 'Вес']/Значение"/></value>
					</property>

					<xsl:apply-templates select="Картинка" />
				</group>

				<xsl:apply-templates select="ЗначенияРеквизитов" />


				<xsl:apply-templates select="ЗначенияСвойств" />
			</properties>
		</page>
	</xsl:template>
	
	<xsl:template match="Товар/ЗначенияРеквизитов">
		<group name="requisites" title="1C: Реквизиты" visible="visible">
			<xsl:apply-templates select="ЗначениеРеквизита"/>
		</group>
	</xsl:template>
	
	
	<xsl:template match="Товар/ЗначенияРеквизитов/ЗначениеРеквизита">
		<property name="{Наименование}" type="string" is-public="1" visible="visible" allow-runtime-add="1">
			<type data-type="string" />
			<title><xsl:value-of select="Наименование"/></title>
			<value><xsl:value-of select="Значение"/></value>
		</property>
	</xsl:template>
	

	
</xsl:stylesheet>
