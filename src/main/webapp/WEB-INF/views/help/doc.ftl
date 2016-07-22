<@p.header title="LmShop B2B2C V3.0 2015版商城系统-内容"/>
<div class="clear"></div>
<!--主页内容-->
<#assign systemDocTag = newTag("systemDocTag") />
<#assign document = systemDocTag("{'docId':'${docId}'}") />
<div class="nch-breadcrumb-layout">
	<div class="nch-breadcrumb wrapper">
		<i class="icon-home"> </i> <span><a href="${base}/">首页</a></span>
		<span class="arrow">&gt;</span><span>${document.docTitle!''}</span>
	</div>
</div>
<link href="${base}/res/css/layout.css" rel="stylesheet" type="text/css">
<!---文章内容--->
<div class="nch-container wrapper">
	<div class="nch-article-con" style="margin:0 auto 20px; width:960px">
	  <h1>${document.docTitle!''}</h1>
	  <h2>${document.createTimeStr?string("yyyy-MM-dd HH:mm:ss")}</h2>
	  <div class="default">
	    ${document.docContent!''}
	  </div>
	</div>
</div>
<div class="clear"></div>
<!-----footer------>
<@p.footer />
