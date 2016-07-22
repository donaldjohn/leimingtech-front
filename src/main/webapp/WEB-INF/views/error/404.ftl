<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta name="robots" content="noindex,nofollow">
	<meta name="viewport" content="width=device-width,maximum-scale=1,user-scalable=no,minimal-ui">
	<link rel="shortcut icon" href="/leimingtech-front/res/css/favicon.ico"/>
	<title>404 Not Found</title>
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
			对不起, 您访问的页面不存在<br>
			继续浏览请 <a href="/leimingtech-front/">点击这里</a>.<span id="timeto"></span>
	</div>
	<a href="/leimingtech-front/" class="button">返回首页</a>
		<div class="code">
			<span>4</span>
			<span>0</span>
			<span>4</span>
		</div>

<!--
	<script type="text/javascript">
	var mouse = { x: 0, y: 0 },
		gyro = { x: 0, y: 0 },
		updateGyro = false,
		updateMouse = false,
		customEvent = null,
		hills = document.getElementById('js-hills'),
		country = document.getElementById('js-country'),
		foreground = document.getElementById('js-foreground'),
		windowWidth = window.innerWidth,
		isiPad = navigator.userAgent.match(/iPad/i) != null;

	if (windowWidth > 1024) {
		document.addEventListener('mousemove', function(e){
			updateMouse = true;
			customEvent = e;
		}, false);
	}

	if (isiPad) {
		window.addEventListener('deviceorientation', function(e){
			updateGyro = true;
			customEvent = e;
		}, false);
	}

	setInterval(function(){
		if (updateGyro) {
			updateGyro = false;
			updateOnGyroscope(customEvent);
		}
		if (updateMouse) {
			updateMouse = false;
			updateOnMouse(customEvent);
		}
	}, 50)

	function updateOnMouse(e) {
		mouse.x = (Math.round( 200 * (e.clientX || e.pageX) / window.innerWidth) - 100) / 100;
		mouse.y = (Math.round( 200 * (e.clientY || e.pageY) / window.innerHeight) - 100) / 100;
		hills.style.transform      = "translate3d(" + mouse.x * 10  + "px, " + mouse.y * 10  + "px, 0)";
		country.style.transform    = "translate3d(" + mouse.x * -5 + "px, " + mouse.y * -5 + "px, 0)";
		foreground.style.transform = "translate3d(" + mouse.x * -10  + "px, " + mouse.y * -10  + "px, 0)";
	}

	function updateOnGyroscope(e) {
		gyro.x = Math.round((e.beta % 90) * 10 / 9) / 100;
		gyro.y = Math.round((e.gamma % 90) * 10 / 9) / 100;
		hills.style.transform      = "translate3d(" + gyro.x * 20  + "px, " + gyro.y * 20  + "px, 0)";
		country.style.transform    = "translate3d(" + gyro.x * -10 + "px, " + gyro.y * -10 + "px, 0)";
		foreground.style.transform = "translate3d(" + gyro.x * -20 + "px, " + gyro.y * -20 + "px, 0)";
		hills.style.webkitTransform      = "translate3d(" + gyro.x * 20  + "px, " + gyro.y * 20  + "px, 0)";
		country.style.webkitTransform    = "translate3d(" + gyro.x * -10 + "px, " + gyro.y * -10 + "px, 0)";
		foreground.style.webkitTransform = "translate3d(" + gyro.x * -20 + "px, " + gyro.y * -20 + "px, 0)";
	}
	</script>
-->
<!-- Server: 10.1.1.235 -->
<!-- #TB_MON#CHSET#1ef114776ceb#AWSID#10.1.1.235#TB_MON# -->
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