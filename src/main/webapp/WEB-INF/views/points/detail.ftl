<#assign pointsGoodsTag = newTag("pointsGoodsTag") />
<#assign dateFormatTag = newTag("dateFormatTag") />
 <#assign pointsGoods = pointsGoodsTag("{'id':'${id }'}") />
<@p.header title="${pointsGoods.pointsGoodsName}－LmShop"/>
<div class="clear"></div>
<!--主页内容，调用index-->
<link href="${base }/res/css/home_point.css" rel="stylesheet" type="text/css">
<link href="${base }/res/css/home_login.css" rel="stylesheet" type="text/css">
<link href="${base }/css/points/public.css" type="text/css" rel="stylesheet" />
<link href="${base }/css/points/integral.css" rel="stylesheet" type="text/css" />
<script>
jQuery(document).ready(function() {
	jQuery(".inte_rank").slide({titCell:".li_list",targetCell:".li_hover",defaultIndex:1,effect:"slideDown",triggerTime:0,returnDefault:true}); 
});
</script>
<script src="${base}/res/js/layer/layer.js"></script>
<style type="text/css">
.left_menu_con_center_left dd a { font-weight:normal; font-size:12px;}
</style>
<div class="nc-layout-all">
  <div class="integral_left">
		<h1>商城积分信息</h1>
		 <div class="inte_detail">
        	<ul>
                <li><a href="${base}/points/user/pointsCart" target="_blank">积分商品购物车</a></li>
            </ul>
        </div>
		<div class="inte_arrow"></div>
		<h1>兑换排行榜</h1>
		<div class="inte_rank">
			<#assign hotPointsGoodsTag = newTag("hotPointsGoodsTag") />
              <#assign hotPointsOrderGoodslist = hotPointsGoodsTag() />
              <#list hotPointsOrderGoodslist as hotPointsOrderGoods >
                <h3 class="li_list on "><b>${hotPointsOrderGoods_index+1}</b><a href="${base}/points/detail?id=${hotPointsOrderGoods.shopPointsGoods.id}" target="_blank">${hotPointsOrderGoods.shopPointsGoods.pointsGoodsName} </a></h3>
                <div class="li_hover"   <#if (point_index==0)>style="display:block;"<#else>style="display:none;"</#if>  >
                    <div class="li_hover_img"><a href="${base}/points/detail?id=${hotPointsOrderGoods.shopPointsGoods.id}" target="_blank"><img src="${imgServer}${hotPointsOrderGoods.shopPointsGoods.pointsGoodsImage}" /></a></div>
                    <div class="inte_price">
                        <span>市场价格:¥<s>${hotPointsOrderGoods.shopPointsGoods.pointsGoodsStorePrice}</s></span>
                        <span>兑换积分:<i class="red">${hotPointsOrderGoods.shopPointsGoods.pointsnums}</i>分</span>
                        <span>兑换数量:<i class="red">${hotPointsOrderGoods.pointGoodscount}</i>个</span>
                    </div>
                </div>
            </#list>
		</div>
	</div>
	  <#assign hotPointsOrderGoods = hotPointsGoodsTag("{'id':'${pointsGoods.id }'}") />
  <div class="nc-layout-right">
    <div class="left2 giftsClass">
      <div class="gift_con">
        <div class="giftWare" >
          <div class="title">
            <h2>${pointsGoods.pointsGoodsName}</h2>
          </div>
          <div class="wareInfo">
            <div class="warePic">
              <div class="picFloat">
                <div class="pic"><i></i><a href="${pointsGoods.pointsGoodsImage}"><img src="${imgServer}${pointsGoods.pointsGoodsImage}" onerror="this.src='${base }/res/images/default_goods_image.gif'" onload="javascript:DrawImage(this,400,400);"></a></div>
              </div>
            </div>
            <div class="wareText">
              <div class="rate">
                <h3>兑换所需：<span style="font-size: 20px;color: #d93600;">${pointsGoods.pointsnums}积分</span>&nbsp;<span style="padding:2px;font:600 12px/16px Georgia,Arial; font-size: 14px;background: #d93600;color: #ffffff;margin-top: 2px">V${pointsGoods.memberGradeId }会员</span></h3>
                <p class="hr">&nbsp;</p>
                                <h4>市场价格：<span class="cost">&yen;<s>${pointsGoods.pointsGoodsStorePrice}</s></span></h4>
                <h4>礼品编号：<span class="cost">${pointsGoods.pointsGoodsSerial}</span></h4>
                <p class="hr">&nbsp;</p>
                <!-- 兑换时间 -->
                <div class="exchange">
                <#if pointsGoods.pointsGoodsStarttime??&&pointsGoods.pointsGoodsEndtime?? >
                	 <#assign pointsGoodsStarttime = dateFormatTag("{'date':'${pointsGoods.pointsGoodsStarttime }'}") />
                	 
                	  <#assign pointsGoodsEndtime = dateFormatTag("{'date':'${pointsGoods.pointsGoodsEndtime }'}") />
                	<h6>兑换开始：${pointsGoodsStarttime }至${pointsGoodsEndtime }</h6>
                </#if>
                            <!-- 剩余库存 -->
                            <h6>剩余数量：${pointsGoods.pointsGoodsStorage-hotPointsOrderGoods.pointGoodscount }<input type="hidden" id="storagenum" value="${pointsGoods.pointsGoodsStorage-hotPointsOrderGoods.pointGoodscount }"/>
                  </h6>
                  	 <h6>每个会员最多兑换:${pointsGoods.exchangeCount}个 <input name="limitnum" type="hidden" class="text" id="limitnum" value='${pointsGoods.exchangeCount}' size="4"/></h6>	
                                    <!-- 兑换按钮 -->
                            <h6>兑换数量：<input name="exnum" type="text" class="text" id="exnum" value='1' size="4"/>
                  </h6>
                  <#assign nowTime=.now?long/>
                  <#if pointsGoods.pointsGoodsShow==0>
                    <span class="btn-on" ><i class="ico"></i>商品已下架</span> 
                    <#elseif pointsGoods.pointsGoodsStorage-hotPointsOrderGoods.pointGoodscount ==0>
                    	  <span class="btn-on" ><i class="ico"></i>商品已售罄</span> 
            	  	<#elseif pointsGoods.pointsGoodsStarttime &gt;=nowTime || pointsGoods.pointsGoodsEndtime &lt;=nowTime >
            	  			 <span class="btn-off" ><i class="ico"></i>兑换结束</span> 
                  <#else>
                  		  <span class="btn-on" onclick="return add_to_cart();"><i class="ico"></i>我要兑换</span> 
                  </#if>
                  <!-- 限制兑换数量 -->
                   <input type="hidden" id="limitnum" value=""/>
                </div>
                <p class="hr">&nbsp;</p>
             		 <dl>
		            	<dt>分&#12288;&#12288;享：</dt>
		            	<dd style="margin-top: 5px;">
		            		<div class="jiathis_style" style="right: 0;">
								<a class="jiathis_button_icons_1"></a>
								<a class="jiathis_button_icons_2"></a>
								<a class="jiathis_button_icons_3"></a>
								<a class="jiathis_button_icons_4"></a>
								<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
							</div>
							<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jia.js" charset="utf-8"></script>
		            	</dd>
		            </dl>
              </div>
            </div>
            <div class="clear"></div>
          </div>
          <div class="wareIntro">
            <ul class="userMenu">
              <li>礼品介绍</li>
            </ul>
            <div class="con" id="goodsBody"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
$(function(){
	initPointsBody();
})

function initPointsBody(){
	//异步地址
	var url = '${base}/points/pointsgoodsBody';
	//参数
	var args = {"pointsGoodsId":'${pointsGoods.id}'};
	//异步加载table
	$.post(url, args, function(data){
		$("#goodsBody").append(data);
	});
	
}
 function copy_url()
 {
	 var txt = $("#shareurl").val();
	 if(window.clipboardData)
	    { 
	        // the IE-manier
	        window.clipboardData.clearData();
	        window.clipboardData.setData("Text", txt);
	        layer.msg("复制到剪贴板成功!!");
	    }
	    else if(navigator.userAgent.indexOf("Opera") != -1)
	    {
	        window.location = txt;
	        layer.msg("复制到剪贴板成功!!");
	    }
	    else if (window.netscape)
	    {
	        // dit is belangrijk maar staat nergens duidelijk vermeld:
	        // you have to sign the code to enable this, or see notes below
	        try {
	            netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
	        } catch (e) {
	            //alert("被浏览器禁止了相关设置!\n请在浏览器地址栏输入\'about:config\'并回车\n然后将\'signed.applets.codebase_principal_support\'设置为\'true\'");
	            layer.msg("被浏览器禁止了相关设置!\n请在浏览器地址栏输入\'about:config\'并回车\n然后将\'signed.applets.codebase_principal_support\'设置为\'true\'",{icon:1});
	            return false;
	        }
	        // maak een interface naar het clipboard
	        var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
	        if (!clip){return;}
	        // alert(clip);
	        // maak een transferable
	        var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
	        if (!trans){return;}
	        // specificeer wat voor soort data we op willen halen; text in dit geval
	        trans.addDataFlavor('text/unicode');
	        // om de data uit de transferable te halen hebben we 2 nieuwe objecten
	        // nodig om het in op te slaan
	        var str = new Object();
	        var len = new Object();
	        str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
	        var copytext = txt;
	        str.data = copytext;
	        trans.setTransferData("text/unicode",str,copytext.length*2);
	        var clipid = Components.interfaces.nsIClipboard;
	        if (!clip){return false;}
	        clip.setData(trans,null,clipid.kGlobalClipboard);
	        layer.alert("复制到剪贴板成功",{icon:1});
	    }
 }
 
//积分礼品兑换倒计时
function GetRTime2() {
   var rtimer=null;
   var startTime = new Date();
   var EndTime = 0;
   var NowTime = new Date();
   var nMS =EndTime - NowTime.getTime();
   if(nMS>0){
       var nD=Math.floor(nMS/(1000*60*60*24));
       var nH=Math.floor(nMS/(1000*60*60)) % 24;
       var nM=Math.floor(nMS/(1000*60)) % 60;
       var nS=Math.floor(nMS/1000) % 60;
       document.getElementById("dhpd").innerHTML=pendingzero(nD);
       document.getElementById("dhph").innerHTML=pendingzero(nH);
       document.getElementById("dhpm").innerHTML=pendingzero(nM);
       document.getElementById("dhps").innerHTML=pendingzero(nS);
       if(nS==0&&nH==0&&nM==0){
          // document.getElementById("returntime").style.display='none';
           clearTimeout(rtimer2);
           window.location.href=window.location.href;
           return;
       }
       rtimer2=setTimeout("GetRTime2()",1000);
   }
}
GetRTime2();
function pendingzero(str){
   var result=str+"";
   if(str<10)
   {
       result="0"+str;
   }
   return result;
}

//加入购物车
function add_to_cart(){
	if(!isLogin){
		layer.alert("请先登录",{icon:1});
		return false;
	}
	var storagenum = parseInt($("#storagenum").val());//库存数量
	var limitnum = parseInt($("#limitnum").val());//限制兑换数量
	var quantity = parseInt($("#exnum").val());//兑换数量	
	//验证数量是否合法
	var checkresult = true;
	var msg = '';
	if(!quantity >=1 ){//如果兑换数量小于1则重新设置兑换数量为1
		quantity = 1;
	}
	if(limitnum > 0 && quantity > limitnum){
		checkresult = false;
		msg = '兑换数量不能大于限兑数量';
	}
	if(storagenum > 0 && quantity > storagenum){
		checkresult = false;
		msg = '兑换数量不能大于剩余数量';
	}
	if(checkresult == false){
		layer.alert(msg,{icon:2});
		return false;
	}else{
		//异步地址
		var url = '${base}/points/user/addCart';
		//参数
		var args = {"shopPointsGoodsId":'${pointsGoods.id}',"pointsGoodsNum":quantity};
		//异步加载table
		$.post(url, args, function(result){
			if(result.result=='true'){
				window.location.href = '${base}/points/user/pointsCart';
			}else{
				layer.alert(result.msg,{icon:2});
			}
			return false;
		});
		
	}
	
}

function redirect(){
	
}
</script><div class="clear"></div>

<@p.footer/>
