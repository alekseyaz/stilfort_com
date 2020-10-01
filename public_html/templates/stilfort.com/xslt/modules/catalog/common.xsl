<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>

	<xsl:include href="category.xsl" />
	<xsl:include href="object.xsl" />
	<xsl:include href="getCategoryList.xsl" />
	<xsl:include href="getObjectsList.xsl" />
	<xsl:include href="search.xsl" />
    <xsl:include href="getSmartCatalog.xsl" />
	
	<xsl:include href="short_view.xsl" />
	
	<xsl:include href="smart-filters.xsl" />


</xsl:stylesheet>