<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/modules/news/lastlist.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="udata[@module = 'news' and @method = 'lastlist']" mode="news_lent">
		<xsl:apply-templates select="items" mode="news_lent"/>
	</xsl:template>

	<xsl:template match="udata[@module = 'news' and @method = 'lastlist']/items" mode="news_lent">
		<div class="row no-gutters">
			<xsl:apply-templates select="item" mode="news_lent"/>
			<!--<xsl:apply-templates select="../archive_link" />-->
		</div>
		<xsl:apply-templates select="../total" mode="show_more"/>
	</xsl:template>

	<xsl:template match="udata[@module = 'news' and @method = 'lastlist']/items/item" mode="news_lent">
		<div class="col-xs-6 col-md-4 col-lg-4 blog-item">
			<a href="{@link}" class="news-thumbnail">
				<img src="{.//property[@name='anons_pic']/value}" alt="{.//property[@name='anons_pic']/value/@alt}" class="w100p" />
				<span class="label label-danger">
					<xsl:value-of select="@lent_name" />
				</span>
			</a>
			<div class="padding">
				<div class="date">
					<span class="news-date text-muted">
						<small>
							<xsl:apply-templates select=".//property[@name='publish_time']" />
						</small>
					</span>
				</div>
				<h3>
					<a href="{@link}">
						<xsl:value-of select="@name" />
					</a>
				</h3>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'news' and @method = 'lastlist']/archive_link">
		<div class="archive_link"><a href="{.}">&news_rubric_archive_link;</a></div>
	</xsl:template>
	
	
	
	
	
	
	
	
	<!--last_news-->
	
	<xsl:template match="udata[@module = 'news' and @method = 'lastlist']" mode="last_news">
		<xsl:apply-templates select="items" mode="last_news"/>
	</xsl:template>

	<xsl:template match="udata[@module = 'news' and @method = 'lastlist']/items" mode="last_news">
		<div class="pr15">
			<ul class="list-unstyled additional-news clearfix mb30">
				<li class="h4 pull-left">
					<strong>Последние новости</strong>
				</li>
				<li class="pull-right h4">
					<a href="{$result/parents/page[1]/@link}" class="brand-color">Все новости</a>
				</li>
			</ul>
			<xsl:apply-templates select="item" mode="last_news"/>
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'news' and @method = 'lastlist']/items/item" mode="last_news">
		<div class="additional-news-container">
			<div class="date mb15">
				<span class="news-date text-muted">
					<xsl:apply-templates select=".//property[@name='publish_time']" />
				</span>
				<span class="label label-danger">
					<xsl:value-of select="@lent_name" />
				</span>
			</div>
			<h3>
				<a href="{@link}" class="brand-color">
					<xsl:value-of select="@name" />
				</a>
			</h3>
			<p class="mb15"></p>
		</div>
	</xsl:template>
	


</xsl:stylesheet>