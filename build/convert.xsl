<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />

	<xsl:template match="/">
		<xsl:result-document href="../jQueryAPI.zh_CN.xml">
			<api>
				<xsl:copy-of select="document('category.zh_CN.xml')/api/categories"/>
				<xsl:variable name="zh-entrys" select="document('jqueryapi.xml')//subcat/*"/>
				<entries>
					<xsl:for-each select="/api/entries/entry">
						<entry type="{@type}" name="{@name}">
							<desc>
								<xsl:value-of select="$zh-entrys[@type=current()/@type][@name=current()/@name]/desc"/>
								<xsl:copy-of select="desc/node()"/>
							</desc>
							<xsl:for-each select="signature">
								<signature>
									<xsl:for-each select="argument">
										<argument name="{@name}">
											<desc><xsl:copy-of select="desc/node()"/></desc>
										</argument>
									</xsl:for-each>
									<xsl:for-each select="option">
										<option name="{@name}">
											<desc><xsl:copy-of select="desc/node()"/></desc>
										</option>
									</xsl:for-each>
								</signature>
							</xsl:for-each>
							<longdesc>
								<xsl:copy-of select="$zh-entrys[@type=current()/@type][@name=current()/@name]/longdesc/node()"/>
								<xsl:copy-of select="longdesc/node()"/>
							</longdesc>
							<xsl:for-each select="example">
								<example>
									<desc><xsl:copy-of select="desc/node()"/></desc>
								</example>
							</xsl:for-each>
						</entry>
					</xsl:for-each>
				</entries>
			</api>
		</xsl:result-document>
	</xsl:template>

</xsl:stylesheet>
