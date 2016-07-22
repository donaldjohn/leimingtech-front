<@p.storeheader title="首页"/>
<!--根据店铺id获取店铺内容  -->
<#assign storeInfoTag =newTag("storeInfoTag")>  
<#assign storeVo =storeInfoTag("{'storeId':'${storeId}'}")>
<!--根据店铺id取评分内容-->
<#assign evaluateStorebyStoreIdTag =newTag("evaluateStorebyStoreIdTag")>  
<#assign evaluateStore =evaluateStorebyStoreIdTag("{'storeId':'${storeId}'}")>
 <#if storeVo??>
   <#if storeVo.storeState==1>
		  <div style="width: 1000px;overflow: hidden;margin: 0 auto;"></div>
		  <article id="content">
		    <section class="layout" >
		      <article class="nc-goods-main">
		        <div class="nc-s-c-s3 mt15">
		          <div class="title">
		            <h4>店铺详情</h4>
		          </div>
		          <div class="content pt10 pb20">
		            <div class="default" style="float:none; margin: auto;" ></div>
		            <div class="clear mb50"></div>
		            <div class="ncu-intro">
		              <div class="top"></div>
		              <div class="content clearfix">
		                <h2 class="ncu-name">${storeVo.storeName}</h2>
		                <dl class="ncu-shop-info">
		                  <dt><span class="thumb size80"><i></i><a href="#?act=show_store&id=2"><img src="<#if storeVo.storeLogo!=null>${imgServer}${storeVo.storeLogo}<#else>${base}/res/images/member/default_image.png</#if>"  onload="javascript:DrawImage(this,80,80);" title="${storeVo.storeName}" alt="${storeVo.storeName}" /></a></span></dt>
		                  <dd class="base">
		                    <p>${storeVo.storeName}</p>
		                    <!-- 店铺名称 -->
		                    <p>店铺等级：${storeVo.gradename}</p>
		                    <!-- 店铺等级 -->
		                    <!-- <p><span class="fl">认证信息：</span> --> <!-- 认证信息 -->
		                                                                </p>
		                    </ul>
		                  </dd>
		                  <dd class="qrcode"> <!-- 二维码 -->
		                    <div>
		                      <p>
		                         <#if storeVo.storeCode ??&&  storeVo.storeCode!=''>
		                             <img src="${imgServer}${storeVo.storeCode}"  onload="javascript:DrawImage(this,90,90);">
		                         </#if>
		                      </p>
		                      <p>店铺二维码</p>
		                    </div>
		                  </dd>
		                </dl>
		                <dl class="nus-basic-info">
		                  <dt>基本信息</dt>
		                  <!-- 基本信息 -->
		                  <dd><span style=" float:left;">卖家信用：</span>
		                    ${evaluateStore.averageCredit}                  </dd>
		                 <!--  <dd><span style=" float:left;">买家信用：</span>
		                    ${evaluateStore.averageCredit}                  </dd> -->
		                  <!-- <dd>商品信息：出售中的商品</dd> -->
		                  <dd>注册时间：  
		                      <#if member.createTimeStr??>
		                         ${member.createTimeStr?string('yyyy-MM-dd')}
		                      </#if>
		                  </dd>
		                  <dd>创店时间：
		                      <#if storeVo.createTimeStr??>
		                         ${storeVo.createTimeStr?string('yyyy-MM-dd')}
		                      </#if>
		                   </dd>
		                  <dd>上次登录：  
		                      <#if storeVo.storeLastLogintimestr??>
		                          ${storeVo.storeLastLogintimestr?string('yyyy-MM-dd')}
		                      </#if>
		                  </dd>
		                </dl>
		                <dl class="nus-contact">
		                  <dt>联系方式</dt>
		                  <!-- 联系方式 -->
		                  <dd>地区：       ${storeVo.areaInfo}</dd>
		                  <dd>详细地址：${storeVo.storeAddress}</dd>
		                  <dd>联系电话：${storeVo.storeTel}</dd>
		                  <dd>电子邮件：${member.memberEmail}</dd>
		                  <!-- <dd>&#12288;&#12288;Q Q：<a href="http://wpa.qq.com/msgrd?v=3&uin=905669187&Site=b2b2c.leimingtech.com&Menu=yes" target="_blank"><img src="http://wpa.qq.com/pa?p=2:1234567:47" alt="点击这里给我发消息"></a></dd> -->
		                </dl>
		              </div>
		            </div>
		            <div class="module_special ncs-map" id="container" style=" width:750px;height:600px; margin: 0 auto 30px auto;" >地图加载中...</div>
		          </div>
		        </div>
		      </article>
		    </section>
		    <div class="clear"></div>
		  </article>
		</div>
		<div id="footer" >
		<div class="wrapper">
		  <p><a href="${base}">首页</a>
		     | <a  href="#?act=article&article_id=24">招聘英才</a>
		     | <a  href="#?act=article&article_id=25">广告合作</a>
		     | <a  href="#?act=article&article_id=23">联系我们</a>
		     | <a  href="#?act=article&amp;article_id=22">关于我们</a>
		  </p>
		  Copyright 2014-2018 北京雷铭信科技有限公司 Inc.All rights reserved.&nbsp;&nbsp;ICP证：<br/>
		    <div class="footer-logo">
			<ul>
				<li class="caifutong"></li>
				<li class="caifubao"></li>
				<li class="beifen"></li>
				<li class="kexin"></li>
				<li class="shiming"></li>
				<li class="wangzhan360"></li>
				<li class="anquanlianmeng"></li>
				<div class="clear"></div>
			</ul>
		  </div>
		</div>
		</div>
   </#if>
   <#if storeVo.storeState==0>
      <div align="center">
        <b style="font-size: 3em;">该店铺已关闭</b>
      </div>
   </#if>
   <#if storeVo.storeState==2>
     <div align="center">
     	<b style="font-size: 3em;">该店铺正在审核中</b>
     </div>
   </#if>
</#if>
<script type="text/javascript" src="${base}/res/js/jquery.cookie.js" ></script>
<script type="text/javascript" src="${base}/res/js/perfect-scrollbar.min.js" ></script>
<script type="text/javascript" src="${base}/res/js/jquery.mousewheel.js" ></script>
<script type="text/javascript" src="${base}/res/js/jquery.masonry.js" ></script>
<script type="text/javascript" src="${base}/res/js/jquery.scrollLoading-min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
            //实现图片慢慢浮现出来的效果
            $("img").load(function () {
                //图片默认隐藏  
                $(this).hide();
                //使用fadeIn特效  
                $(this).fadeIn("5000");
            });
            // 异步加载图片，实现逐屏加载图片
            $(".scrollLoading").scrollLoading(); 
    });
</script>
<script type="text/javascript">
var PRICE_FORMAT = '&yen;%s';
var searchTxt = ' 请输入您要搜索的商品关键字';
function searchFocus(e){
	if(e.value == searchTxt){
		e.value='';
		$('#keyword').css("color","");
	}
}
function searchBlur(e){
	if(e.value == ''){
		e.value=searchTxt;
		$('#keyword').css("color","#999999");
	}
}
function searchInput() {
	if($('#keyword').val()==searchTxt)
		$('#keyword').attr("value","");
	return true;
}
$('#keyword').css("color","#999999");

/* $(function(){
	$("#rightsead a").hover(function(){
		if($(this).prop("className")=="youhui"){
			$(this).children("img.hides").show();
		}else{
			$(this).children("img.hides").show();
			$(this).children("img.shows").hide();
			$(this).children("img.hides").animate({marginRight:'0px'},'slow'); 
		}
	},function(){ 
		if($(this).prop("className")=="youhui"){
			$(this).children("img.hides").hide('slow');
		}else{
			$(this).children("img.hides").animate({marginRight:'-143px'},'slow',function(){$(this).hide();$(this).next("img.shows").show();});
		}
	});

	$("#top_btn").click(function(){if(scroll=="off") return;$("html,body").animate({scrollTop: 0}, 600);});

}); */

/* var cityName = "北京市";
var address = "天安门";
var store_name = "极限运动基地";  */

var cityName ='${storeVo.areaInfo}';
var address = '${storeVo.storeAddress}';
var store_name ='${storeVo.storeName}'; 
var map = "";
var localCity = "";
var opts = {width : 150,height: 50,title : "店铺名称:"+store_name};
function initialize() {
	map = new BMap.Map("container");
	localCity = new BMap.LocalCity();
	
	map.enableScrollWheelZoom(); 
	map.addControl(new BMap.NavigationControl());  
	map.addControl(new BMap.ScaleControl());  
	map.addControl(new BMap.OverviewMapControl()); 
	localCity.get(function(cityResult){
	  if (cityResult) {
	  	var level = cityResult.level;
	  	if (level < 13) level = 13;
	    map.centerAndZoom(cityResult.center, level);
	    cityResultName = cityResult.name;
	    if (cityResultName.indexOf(cityName) >= 0) cityName = cityResult.name;
	    	    	getPoint();
	     }
	});
}
 
function loadScript() {
	var script = document.createElement("script");
	script.src = "http://api.map.baidu.com/api?v=1.2&callback=initialize";
	document.body.appendChild(script);
}
function getPoint(){
	var myGeo = new BMap.Geocoder();
	myGeo.getPoint(address, function(point){
	  var point="";
	  if('${storeVo.storeLongitude}'!=''&&'${storeVo.storeAtitude}'!=null){//判断经纬度是否为空
	    point = new BMap.Point('${storeVo.storeLongitude}','${storeVo.storeAtitude}');
	  }
	  if (point) {
	    setPoint(point);
	  }
	}, cityName);
}
function setPoint(point){
	  if (point) {
	    map.centerAndZoom(point, 16);
	    var marker = new BMap.Marker(point);
	    var infoWindow = new BMap.InfoWindow("详细地址:"+address, opts);  
			marker.addEventListener("click", function(){          
			   this.openInfoWindow(infoWindow);  
			});
	    map.addOverlay(marker);
			marker.openInfoWindow(infoWindow);
	  }
}
loadScript();
</script>
</body>
</html>
