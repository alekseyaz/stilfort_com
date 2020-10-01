<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="filter" select="'filter'" />
	<xsl:variable name="from" select="'from'" />
	<xsl:variable name="to" select="'to'" />

	<xsl:template match="udata[@method = 'getSmartFilters'][group]">
		<div class="results__filter">
			<a href="#">
				<div class="filter__content">
					<span class="filter__icon">
						<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 44.023 44.023" enable-background="new 0 0 44.023 44.023">
							<g>
								<g>
									<path d="m43.729,.29c-0.219-0.22-0.513-0.303-0.799-0.276h-41.831c-0.286-0.026-0.579,0.057-0.798,0.276-0.09,0.09-0.155,0.195-0.203,0.306-0.059,0.128-0.098,0.268-0.098,0.418 0,0.292 0.129,0.549 0.329,0.731l14.671,20.539v20.662c-0.008,0.152 0.015,0.304 0.077,0.446 0.149,0.364 0.505,0.621 0.923,0.621 0.303,0 0.565-0.142 0.749-0.354l11.98-11.953c0.227-0.227 0.307-0.533 0.271-0.828v-8.589l14.729-20.583c0.392-0.391 0.392-1.025 0-1.416zm-16.445,20.998c-0.209,0.209-0.298,0.485-0.284,0.759v8.553l-10,9.977v-18.53c0.014-0.273-0.075-0.55-0.284-0.759l-13.767-19.274h38.128l-13.793,19.274z"/>
								</g>
							</g>
						</svg>
					</span>
					<span class="filter__title">Фильтр</span>
					<span class="filter__arrows">
						<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="16" height="16" viewBox="0 0 16 16">
							<path fill="#444444" d="M2 13h2l5-5-5-5h-2l5 5z"/>
							<path fill="#444444" d="M7 13h2l5-5-5-5h-2l5 5z"/>
						</svg>
					</span>
				</div>
			</a>
		</div>
		<form class="dealer__selects results__selects" action=".">
			<xsl:apply-templates select="//field"  mode="filter" />
			<div class="add__filter">
				<button class="button" type="submit">Применить фильтр</button>
			</div>
		</form>
	</xsl:template>
	
	
	
	

	<xsl:template match="field" mode="filter">
		<div class="dealer__select results__select">
			<xsl:apply-templates select="." mode="filter_field"/>
		</div>
	</xsl:template>
	

	
	<xsl:template match="field" mode="filter_field">
		<select name="{$filter}[{@name}]" >
			<option value=""><xsl:value-of select="@title" /></option>
			<xsl:apply-templates select="item" mode="filter_field" />
		</select>
	</xsl:template>

	<xsl:template match="field/item" mode="filter_field">
		<option value="{@value}">
			<xsl:if test="@is-selected"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			<xsl:value-of select="." />
		</option>
	</xsl:template>

	
	<xsl:template match="field[@data-type = 'boolean' or @data-type = 'file' or @data-type = 'img_file' or @data-type = 'swf_file' or @data-type = 'video_file']" mode="filter_field">
		<xsl:variable name="selected_value" select="item[@is-selected = '1']" />
		<label>
			<input type="radio" name="{$filter}[{@name}]" value="1" >
				<xsl:apply-templates select="$selected_value" mode="checked">
					<xsl:with-param name="compare" select="1"/>
				</xsl:apply-templates>
			</input>
			<xsl:text>Есть</xsl:text>
		</label>
		<label>
			<input type="radio" name="{$filter}[{@name}]" value="0" >
				<xsl:apply-templates select="$selected_value" mode="checked">
					<xsl:with-param name="compare" select="0"/>
				</xsl:apply-templates>
			</input>
			<xsl:text>Нет</xsl:text>
		</label>
		<label>
			<input type="radio" name="{$filter}[{@name}]" value="" >
				<xsl:if test="not($selected_value)">
					<xsl:attribute name="checked">
						<xsl:text>checked</xsl:text>
					</xsl:attribute>
				</xsl:if>
			</input>
			<xsl:text>Неважно</xsl:text>
		</label>
	</xsl:template>

	<xsl:template match="item" mode="checked">
		<xsl:param name="compare" />

		<xsl:if test="$compare = text()">
			<xsl:attribute name="checked">
				<xsl:text>checked</xsl:text>
			</xsl:attribute>
		</xsl:if>
	</xsl:template>

	
	<xsl:template match="field[minimum][maximum]" mode="filter_field">
		<div>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="./@data-type = 'date'">
						<xsl:text>date_range</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>range</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="./@data-type != 'date'">
					<input type="text" name="{$filter}[{@name}][from]" data-boundary="{./minimum}" id="field_{../@name}_from">
						<xsl:attribute name="value">
							<xsl:apply-templates select="minimum" mode="filter_value"/>
						</xsl:attribute>
					</input>
					<span>-</span>
					<input type="text" name="{$filter}[{@name}][to]" data-boundary="{./maximum}"  id="field_{../@name}_to">
						<xsl:attribute name="value">
							<xsl:apply-templates select="maximum" mode="filter_value"/>
						</xsl:attribute>
					</input>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="date.maximum" select="document(concat('udata://system/convertDate/', ./maximum, '/m.d.y'))/udata"/>
					<xsl:variable name="date.minimum" select="document(concat('udata://system/convertDate/', ./minimum, '/m.d.y'))/udata"/>
					<input type="text" name="{$filter}[{@name}][from]" data-minimum="{$date.minimum}" data-maximum="{$date.maximum}" class="range_from">
						<xsl:attribute name="value">
							<xsl:apply-templates select="minimum" mode="date_value">
								<xsl:with-param name="default.date" select="$date.minimum"/>
							</xsl:apply-templates>
						</xsl:attribute>
					</input>
					<span>-</span>
					<input type="text" name="{$filter}[{@name}][to]" data-minimum="{$date.minimum}" data-maximum="{$date.maximum}" class="range_to">
						<xsl:attribute name="value">
							<xsl:apply-templates select="maximum" mode="date_value">
								<xsl:with-param name="default.date" select="$date.maximum"/>
							</xsl:apply-templates>
						</xsl:attribute>
					</input>
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:if test="./@data-type != 'date'">
			<div class="slider_group" id="field_{../@name}">
				<span class="min"></span><span class="max"></span>
				<div class="slider" data-minimum="{./minimum}" data-maximum="{./maximum}"></div>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="minimum|maximum" mode="filter_value">
		<xsl:choose>
			<xsl:when test="@selected">
				<xsl:value-of select="@selected" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="minimum|maximum" mode="date_value">
		<xsl:param name="default.date" />
		<xsl:choose>
			<xsl:when test="@selected">
				<xsl:value-of select="document(concat('udata://system/convertDate/', ./@selected, '/m.d.y'))/udata" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$default.date" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="group[@name='catalog_option_props']/field" mode="filter"/>

</xsl:stylesheet>