<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta name="robots" content="noindex,nofollow">
	<meta name="viewport" content="width=device-width,maximum-scale=1,user-scalable=no,minimal-ui">
	<link rel="shortcut icon" href="/leimingtech-front/res/css/favicon.ico"/>
	<title>500</title>
	<link rel="stylesheet" type="text/css" href="/leimingtech-front/res/error/css/css.css">
	<link rel="stylesheet" type="text/css" media="all" href="/leimingtech-front/res/error/css/error.css">
	<script src="/leimingtech-front/res/js/jquery.js"></script>
</head>
<body>
	<script type="text/javascript" async="" src="/leimingtech-front/res/error/js/ga.js"></script>
	<div class="stars"></div>

	<div class="sun-moon">
		<div class="sun"></div>
		<div class="moon"></div>
	</div>

	<div id="js-hills" class="background hills"></div>
	<div id="js-country" class="background country"></div>
	<div id="js-foreground" class="background foreground"></div>

	<div class="error-content">
			抱歉, 您访问的页面出错啦<br>
			继续浏览请 <a href="/leimingtech-front/">点击这里</a>.<span id="timeto"></span>
	</div>
	<a href="/leimingtech-front/" class="button">返回首页</a>
		<div class="code">
			<span>5</span>
			<span>0</span>
			<span>0</span>
		</div>
</body>
<script type="text/javascript">
/**回首页**/
function homePage(){
	/* alert(window.location.href);
	alert(window.location.host);
	window.location=window.location.href; */
}
var wait=5;
$(function() {
	time();
});
function time() {
	//console.log(wait);
	if(wait==0){
		location.href="/leimingtech-front/";
	}else{
		var timeto = $("#timeto");
		timeto.html("(" + wait + "秒后返回首页)");
		wait--;
		setTimeout(function() {
			time();
		}, 1000);
	}
}
</script>
</html>