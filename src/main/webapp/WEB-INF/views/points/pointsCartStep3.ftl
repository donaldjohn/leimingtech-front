<@p.header title="LmShopV3.1 积分兑换"/>
<link href="${base }/res/css/home_cart.css" rel="stylesheet" type="text/css">
<style type="text/css">
#navBar {display: none !important;}
</style>
<script type="text/javascript" >
$(function() {
$(".tabs-nav > li > a").mouseover(function(e) {
	if (e.target == this) {
		var tabs = $(this).parent().parent().children("li");
		var panels = $(this).parent().parent().parent().parent().children(".tabs-panel");
		var index = $.inArray(this, $(this).parent().parent().parent().find("a"));
	if (panels.eq(index)[0]) {
		tabs.removeClass("tabs-selected")
			.eq(index).addClass("tabs-selected");
		panels.addClass("tabs-hide")
			.eq(index).removeClass("tabs-hide");
		}
	}
}); 
});
</script>
<ul class="point-chart">
  <li class="step a2" title="确认兑换清单"></li>
  <li class="step b2" title="确认收货人资料"></li>
  <li class="step c1" title="兑换完成"></li>
</ul>
<div class="content wrapper">
<#if  nopay=='false'>
  <form action="#" method="POST" id="goto_pay" onsubmit="return false;">
    <div class="cart-order-info">
      <div class="title"><span class="all-goods-name">${goodsNames}</span><span class="goto-order"><a href="${base }/points/user/orderList?state=20" target="_blank"> 查看详单</a></span>      
        <span class="freight">运费：<em>
        <script type="text/javascript">
      			var amount = number_format(${ordersAmount},2);
				document.write("&yen;"+amount);      		
      		</script>
        </em></span>
        <span class="all-points">兑换积分：<em>
        		${pointsNums}
      		</em></span>
        
         </div>
    </div>
    <div class="cart-order-pay">
      <div class="title">
        <h3>选择支付方式</h3>
        <ul class="tabs-nav">
          <li class="tabs-selected"><a href="javascript:void(0)">线上支付</a></li>
        </ul>
      </div>
      <!-- online begin -->
      <div class="tabs-panel">
        <ul class="cart-defray">
          <li>
          <#assign paymentTag = newTag("paymentTag") />
		  <#assign paymentlist = paymentTag("{'isshow':'1'}") />
		  <#if paymentlist??>
			<#list paymentlist as payment>
	            <label class="radio">
	              <input id="payment_predeposit" type="radio" name="paymentCode" value="${payment.paymentCode}" extendattr="predeposit" checked/>
	              <input type="hidden" name="paymentId" value="${payment.paymentId}"/>
	            </label>
	            <span class="logo"><img src="${imgServer}${payment.paymentLogo}" alt="${payment.paymentName}" title="${payment.paymentName}" onload="javascript:DrawImage(this,125,50);" /></span>
	            <dl class="explain">
	              <dt></dt>
	              <dd></dd>
	            </dl>
	        </#list>
           </#if>
           </li>
         </ul>
      </div>
      <!-- online end -->
      <!-- offine begin -->
      <div class="tabs-panel tabs-hide">
        <ul class="cart-defray">
                    <li>
            <label class="radio">
              <input type="radio" id="payment_offline" name="payment_id" value="1" extendattr="offline"/>
            </label>
            <span class="logo"><img alt="线下支付-线下支付描述" title="线下支付-线下支付描述" src="api/payment/offline/logo.gif" onload="javascript:DrawImage(this,125,50);"  /> </span>
            <dl class="explain">
              <dt></dt>
              <dd>线下支付描述</dd>
            </dl>
          </li>
        </ul>
        <!--yinhanghuikuan input begin--->
        <!-- <div id="paymessagediv" style="display:none;" class="cart-paymessage">
		  <dl>
            <dt>汇款人姓名：</dt>
            <dd>
              <input type="text" name="offline[user]" maxlength="30" value="" class="text w90">
            </dd>
          </dl>
          <dl>
            <dt>汇入银行：</dt>
            <dd>
              <input type="text" name="offline[bank]" maxlength="40" value="" class="text w200">
            </dd>
          </dl>
          <dl>
            <dt>汇款入账号：</dt>
            <dd>
              <input type="text" name="offline[account]" maxlength="30" value="" class="text w200">
            </dd>
          </dl>
          <dl>
            <dt>汇款金额：</dt>
            <dd>
              <input type="text" name="offline[num]" maxlength="10" value="" class="text w60">
            </dd>
          </dl>
          <dl>
            <dt>汇款单号：</dt>
            <dd>
              <input type="text" name="offline[order]" maxlength="20" value="" class="text w200">
            </dd>
          </dl>
          <dl>
            <dt>汇款日期：</dt>
            <dd>
              <input type="text" name="offline[date]" maxlength="12" value="" class="text w90">
            </dd>
          </dl>
          <dl>
            <dt>其它：</dt>
            <dd>
              <textarea name="offline[extend]" rows="2" class="textarea w200"></textarea>
            </dd>
          </dl>
        </div> -->
        <!--yinhanghuikuan input end---> 
      </div>
      <!--offine end-->
        <div class="ml50 mb30"><a href="javascript:;"  onclick="goPay()" class="cart-button">确认支付</a></div>
        <div class="clear"></div>
    </div>
  </form>
  <#else>
  	<!-- 兑换成功 -->
  </#if>
</div>
<script type="text/javascript">
var APP_BASE = '${base}';
function goPay() {
    var ordersn = '${ordersn}';
    var paymentCode = $("input[name='paymentCode']:checked").val();
   	var paymentId = $("input[name='paymentCode']:checked").parent().find("input[name='paymentId']").val();
    location.href = APP_BASE + "/points/user/orderpay?ordersn="+ordersn+"&paymentCode="+paymentCode+"&paymentId="+paymentId;
}
function check(){
	var flag = false;
	$.each($("input[name='payment_id']"),function(i,n){
		if($(n).attr('checked')){
			flag = true;
			return false;
		}
	});
	if(flag){
		var code = $('input:radio[name="payment_id"]:checked').attr('extendattr');
		if(code=="offline" && ($('input[name="offline[user]"]').val() == '' || $('input[name="offline[account]"]').val() == '' || $('input[name="offline[num]"]').val() == '')){
			layer.msg("");
		}else{
			$('#goto_pay').submit();
		}
	}else{
		layer.msg('');
	}
}

function showmsgdiv(){
	var code = $('input:radio[name="payment_id"]:checked').attr('extendattr');
	if(code=="offline"){
		$("#paymessagediv").show();	
	}else{
		$("#paymessagediv").hide();
	}
}
$(function(){
	$('input:radio[name="payment_id"]').bind('change',showmsgdiv);
});
</script>
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
<@p.footer/>