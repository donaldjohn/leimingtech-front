<#macro foot>
<div class="phone_foot">
 	<div class="foot_top">
 		<span class="fl">
 			
 				<@shiro.user>
			      	您好，<@shiro.principal/>|
			      	<a href="${base}/m/index/logout">退出!</a> 
			  	</@shiro.user>
			  	
	 			<@shiro.guest>
 					<a href="${base}/m/index/login" style="padding-right:8px;">登陆</a>
 				</@shiro.guest>
 				
	 			<@shiro.guest>
					<a href="${base}/m/index/register">注册</a>
				</@shiro.guest>
		</span>
		<span class="fr">
			<a  href="#">TOP</a>
			<script type="text/javascript">
         	var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
         		document.write(unescape("%3Cspan id='cnzz_stat_icon_1256196951'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1256196951%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));
        	</script> 
		</span>
		
	</div>
	<div class="foot_nav"><a style="color: #000;padding: 0px 0px;" href="${base}">电脑版</href>&nbsp;|&nbsp;<a style="color: #000;padding: 0px 0px;" href="${base}/m/index/index">触屏版</href></div>
    <div class="foot_nav">b2b2c.leimingtech.com</div>
</div>

</#macro>
 