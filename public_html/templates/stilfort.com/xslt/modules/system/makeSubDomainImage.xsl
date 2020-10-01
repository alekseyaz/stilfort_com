<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM  "ulang://i18n/constants.dtd:file">
 
<xsl:stylesheet  version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template name="makeSubDomainImage">
 
        <xsl:param name="element_id" />
        <xsl:param name="field_name" />
 
        <xsl:param name="subdomain" />
 
        <xsl:param name="width">auto</xsl:param>
        <xsl:param name="height">auto</xsl:param>
 
        <xsl:param name="alt" />
 
        <xsl:param name="align" />
        <xsl:param name="id" />
        <xsl:param name="class" />
        <xsl:param name="link" />
 
        <xsl:param name="empty" /> <!-- Путь к пустому изображению -->
 
        <xsl:call-template name="makeSubDomainImage_thumbnail">
            <xsl:with-param name="element_id" select="$element_id" />
            <xsl:with-param name="field_name" select="$field_name" />
 
            <xsl:with-param name="subdomain" select="$subdomain" />
 
            <xsl:with-param name="width" select="$width" />
            <xsl:with-param name="height" select="$height" />
 
            <xsl:with-param name="alt" select="$alt" />
            <xsl:with-param name="align" select="$align" />
            <xsl:with-param name="id" select="$id" />
            <xsl:with-param name="class" select="$class" />
            <xsl:with-param name="link" select="$link" />
 
        </xsl:call-template>
    </xsl:template>
 
    <xsl:template name="makeSubDomainImage_thumbnail">
        <xsl:param name="element_id" />
        <xsl:param name="field_name" />
 
        <xsl:param name="subdomain" />
 
        <xsl:param name="width">auto</xsl:param>
        <xsl:param name="height">auto</xsl:param>
 
        <xsl:param name="alt" />
        <xsl:param name="align" />
        <xsl:param name="id" />
        <xsl:param name="class" />
        <xsl:param name="link" />
<!-- <xsl:value-of select="concat('udata://custom/makeSubDomainImage/',$subdomain,'/',$element_id,'/',$field_name,'/',$width,'/',$height,'/0')"/>-->
        <xsl:apply-templates select="document(concat('udata://custom/makeSubDomainImage/',$subdomain,'/',$element_id,'/',$field_name,'/',$width,'/','auto','/0'))/udata" mode="makeSubDomainImage">
            <xsl:with-param name="element_id" select="$element_id" />
            <xsl:with-param name="field_name" select="$field_name" />
 
            <xsl:with-param name="alt" select="$alt" />
            <xsl:with-param name="align" select="$align" />
            <xsl:with-param name="id" select="$id" />
            <xsl:with-param name="class" select="$class" />
            <xsl:with-param name="link" select="$link" />
 
        </xsl:apply-templates>
    </xsl:template>
 
    <xsl:template match="udata[@method = 'makeSubDomainImage']" mode="makeSubDomainImage">
        <xsl:param name="element_id" />
        <xsl:param name="field_name" />
        <xsl:param name="alt" />
        <xsl:param name="align" />
        <xsl:param name="id" />
        <xsl:param name="class" />
        <xsl:param name="link" />
 
        <xsl:variable name="width" select="thumb_info/width" />
        <xsl:variable name="height" select="thumb_info/height" />
 
       <!--  <a href="{origin_info/src}" class="fancybox" rel="prettyPhoto[product-gallery]">
 
            <xsl:if test="$link">
                <xsl:attribute name="href">
                    <xsl:value-of select="$link" />
                </xsl:attribute>
            </xsl:if>
 
            <xsl:if test="$alt">
                <xsl:attribute name="title">
                    <xsl:value-of select="$alt" />
                </xsl:attribute>
            </xsl:if>
 
            <xsl:if test="$class">
                <xsl:attribute name="class">
                    <xsl:text>link-</xsl:text>
                    <xsl:value-of select="$class" />
                </xsl:attribute>
            </xsl:if> -->
 
           <!-- <img src="{//thumb_info/src}" width="{$width}" height="{$height}" >-->
             <img src="{//thumb_info/src}" >
                <!-- <xsl:if test="$element_id">
                    <xsl:attribute name="umi:element_id">
                        <xsl:value-of select="$element_id" />
                    </xsl:attribute>
 
                    <xsl:attribute name="umi:field_name">
                        <xsl:value-of select="$field_name" />
                    </xsl:attribute>
                </xsl:if> -->
 
                <xsl:if test="$alt">
                    <xsl:attribute name="alt">
                        <xsl:value-of select="$alt" />
                    </xsl:attribute>
 
                    <xsl:attribute name="title">
                        <xsl:value-of select="$alt" />
                    </xsl:attribute>
                </xsl:if>
 
                <xsl:if test="$align">
                    <xsl:attribute name="align">
                        <xsl:value-of select="$align" />
                    </xsl:attribute>
                </xsl:if>
 
                <xsl:if test="$id">
                    <xsl:attribute name="id">
                        <xsl:value-of select="$id" />
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="$class">
                    <xsl:attribute name="class">
                        <xsl:text>img-</xsl:text>
                        <xsl:value-of select="$class" />
                    </xsl:attribute>
                </xsl:if>
            </img>
        <!-- </a> -->
    </xsl:template>
</xsl:stylesheet>