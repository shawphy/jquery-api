<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<xsl:template match="/">
		<html>
		<head>
			<title>jQuery <xsl:value-of select="replace(/api/categories/category[@name='Version']/category[last()]/@name,'Version ','')"/> 中文文档 </title>
			<link rel="stylesheet" href="style.css"/>
		</head>
		<body id="api">
			<div id="header">
				<div id="headerMain"><h1>jQuery 中文文档 XSLT/CSS/JS Written by <a href="http://shawphy.com">Shawphy</a> Translated by <a href="http://www.cn-cuckoo.com/">为之漫笔</a>, <a href="http://shawphy.com">Shawphy</a> and <a href="http://cloudream.name">Cloudream</a>.  <a href="http://code.google.com/p/jquery-api-zh-cn/downloads/list">下载CHM离线版</a></h1></div>
			</div>
			<div id="wrapper">
				<div id="sidebar">
					<xsl:for-each select="/api/categories/category">
						<h2><xsl:value-of select="document('jQueryAPI.zh_CN.xml')/api/categories//category[@name=current()/@name]/@zh"/></h2>
						<div>
							<xsl:choose>
								<xsl:when test="category">
									<xsl:for-each select="category">
										<xsl:if test="//entry/category[@name=current()/@name]">
											<b><xsl:value-of select="document('jQueryAPI.zh_CN.xml')/api/categories//category[@name=current()/@name]/@zh"/></b>
											<ul>
												<xsl:for-each select="//entry/category[@name=current()/@name]/..">
													<xsl:sort select="@name"/>
													<xsl:if test="not(following::entry[1]/@name=@name)">
														<xsl:choose>
															<xsl:when test="@type='selector'">
																<li class="selector">
																	<xsl:attribute name="title"><xsl:value-of select="@name"/></xsl:attribute>
																	<xsl:value-of select="sample"/>
																</li>
															</xsl:when>
															<xsl:otherwise>
																<li><xsl:value-of select="@name"/><xsl:if test="@type='method'">()</xsl:if></li>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:if>
												</xsl:for-each>
											</ul>
										</xsl:if>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<ul>
									<xsl:for-each select="//entry/category[@name=current()/@name]/..">
										<xsl:sort select="@name"/>
										<xsl:if test="not(following::entry[1]/@name=@name)">
											<li><xsl:value-of select="@name"/><xsl:if test="@type='method'">()</xsl:if></li>
										</xsl:if>
									</xsl:for-each>
									</ul>
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</xsl:for-each>
				</div>
				<div id="content">
					<xsl:for-each-group select="/api/entries/entry" group-by="@type">
						<xsl:for-each-group select="current-group()" group-by="@name">
							<xsl:sort select="@name"/>
							<xsl:choose>
								<xsl:when test="@type='selector'">
									<xsl:result-document href="./dist/entry/{replace(@name,' ','-')}-selector.html">
										<xsl:apply-templates select="current-group()"/>
									</xsl:result-document>
								</xsl:when>
								<xsl:otherwise>
									<xsl:result-document href="./dist/entry/{@name}.html">
										<xsl:apply-templates select="current-group()"/>
									</xsl:result-document>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each-group>
					</xsl:for-each-group>
				</div>
			</div><!--
			<script type="text/javascript">
				var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
				document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
				</script>
				<script type="text/javascript">
				var pageTracker = _gat._getTracker("UA-5320749-1");
				pageTracker._initData();
				pageTracker._trackPageview();
			</script>-->
			<script src="jquery.min.js"></script>
			<script><![CDATA[
				$("#sidebar h2").click(function(){
					$(this).next("div").toggle().siblings("div").hide();
				});
				$("#sidebar li").click(function(){
					$("#content").empty().css("top",$(document).scrollTop());
					var name="entry/"+$(this).text().replace("()","");
					if($(this).hasClass("selector")){
						name="entry/"+$(this).attr("title").replace(" ","-")+"-selector";
					}
					$("#content").load(name+".html?"+ +new Date,function(){
						$("iframe").each(function(){
							 var doc = this.contentDocument ||
									(iframe.contentWindow && iframe.contentWindow.document) ||
									iframe.document ||
									null;
							if(doc == null) return true;
							doc.open();
							doc.write($(this).prev().prev().find("code").text());
							doc.close();
						})
					});
				});
			]]></script>
		</body>
		</html>
	</xsl:template>

	<xsl:template match="/api/entries/entry">
		<xsl:variable name="zh-entrys" select="document('jQueryAPI.zh_CN.xml')//entry[@name=current()/@name]"/>
		<xsl:variable name="pos" select="position()"/>
		<xsl:variable name="zh-entry" select="$zh-entrys[$pos]"/>
		<div class="entry">
			<h2>
				<xsl:if test="@return!=''">
					<span>返回值:<xsl:value-of select="@return"/></span>
					</xsl:if>
				<xsl:if test="@type='method'">
						<xsl:value-of select="@name"/>(<xsl:for-each select="signature[1]/argument">
							<xsl:choose>
								<xsl:when test="@optional">
									<em class="optional">[<xsl:value-of select="@name"/>]</em>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@name"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="position() != last()">, </xsl:if>
						</xsl:for-each>)<br/>
				</xsl:if>
				<xsl:if test="@type='selector'">
					<xsl:value-of select="sample"/>
				</xsl:if>
				<xsl:if test="@type='property'">
					<xsl:value-of select="@name"/>
				</xsl:if>
			</h2>
			<div class="desc">
				<p><xsl:copy-of select="$zh-entry/desc/node()"/></p>
				<ul class="signatures">
					<xsl:for-each select="signature">
						<xsl:variable name="sigpos" select="position()"/>
						<xsl:variable name="zh-signature" select="$zh-entry/signature[$sigpos]"/>
						<li>
						<h4>
							<span><xsl:value-of select="added"/> 新增</span>
							<xsl:choose>
								<xsl:when test="../@type='selector'">
									<xsl:value-of select="../sample"/>
								</xsl:when>
								<xsl:when test="../@type='property'">
									<xsl:value-of select="../@name"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="../@name"/>(<xsl:for-each select="argument">
										<xsl:choose>
											<xsl:when test="@optional">
												<em class="optional">[<xsl:value-of select="@name"/>]</em>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="@name"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:if test="position() != last()">, </xsl:if>
									</xsl:for-each>)
								</xsl:otherwise>
							</xsl:choose>
						</h4>
						<xsl:for-each select="argument">
							<div class="arguement">
								<strong><xsl:value-of select="@name"/></strong>
								(<xsl:value-of select="@type"/>)
								<xsl:if test="@optional"> 可选参数，</xsl:if>
								<xsl:if test="@default">默认值:'<xsl:value-of select="@default"/>'</xsl:if>
								<xsl:variable name="argpos" select="position()"/>
								<xsl:copy-of select="$zh-signature/argument[$argpos]/desc/node()"/>
							</div>
						</xsl:for-each>
						<xsl:for-each select="option">
							<div class="option">
								<strong><xsl:value-of select="@name"/></strong>
								<span class="type"><a><xsl:value-of select="@type"/></a></span>
								<xsl:if test="@default"><span class="default">默认值:'<xsl:value-of select="@default"/>'</span></xsl:if>
								<div>
									<xsl:if test="@optional"> 可选参数，</xsl:if>
									<xsl:variable name="argpos" select="position()"/>
									<xsl:copy-of select="$zh-signature/option[$argpos]/desc/node()"/>
								</div>
							</div>
						</xsl:for-each>
						</li>
					</xsl:for-each>
				</ul>
				<div class="longdesc">
					<xsl:copy-of select="$zh-entry/longdesc/node()"/>
				</div>
			</div>
			<xsl:if test="example">
				<div class="example">
					<xsl:call-template name="showexample">
						<xsl:with-param name="zh-entry" select="$zh-entry"/>
						<xsl:with-param name="example" select="example"/>
					</xsl:call-template>
				</div>
			</xsl:if>
		</div>
	</xsl:template>

	<xsl:template name="showexample">
		<xsl:param name="zh-entry"/>
		<xsl:param name="example"/>
		<xsl:for-each select="$example">
			<xsl:variable name="pos" select="position()"/>
			<xsl:if test="desc">
				<h3>示例:</h3>
				<p><xsl:value-of select="$zh-entry/example[$pos]/desc"/></p>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="html[1] and code[1]">
				<pre><code>&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;<xsl:if test="css">
&lt;style&gt;<xsl:value-of select="css"/>&lt;/style&gt;</xsl:if>
&lt;script src="jquery.min.js"&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;

<xsl:value-of select="html"/>

&lt;script&gt;

<xsl:value-of select="code"/>

&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;</code></pre>
<h5>演示:</h5>
<iframe src="blank.html" width="658" height="125">
	<xsl:if test="height">
		<xsl:attribute name="height">
			<xsl:value-of select="height"/>
		</xsl:attribute>
	</xsl:if>
</iframe>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="css">
						<h5>CSS 代码:</h5>
						<pre><code><xsl:value-of select="css"/></code></pre>
					</xsl:if>
					<xsl:if test="html">
						<h5>HTML 代码:</h5>
						<pre><code><xsl:value-of select="html"/></code></pre>
					</xsl:if>
					<xsl:if test="code">
						<h5>jQuery 代码:</h5>
						<pre><code><xsl:value-of select="code"/></code></pre>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="results">
				<h5>结果:</h5>
				<pre><code><xsl:value-of select="results"/></code></pre>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
