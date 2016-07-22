<html>
<head>
<meta charset="utf-8">
<title>微信支付</title>
<script src="${base}/res/js/jquery.js"></script>
<script src="${base}/res/js/createcode/qrcode.js"></script>
<link href="${base}/res/css/lay-out1.css" rel="stylesheet" type="text/css">
</head>
<body>
   <div class="conunt-bg">
	<p class="conunt-top"><span class="fs16 text-l gray-color left">请您及时付款，以便订单尽快处理！订单：${paysn}</span><span class="fs16 text-r gray-color right">应付金额<em class="money">29.90</em>元</span></p>
    <p class="conunt-top2"><span class="left text-l">请您在提交订单后<em class="red-color">24小时</em>内完成支付，否则订单会自动取消。雷铭提供<em class="outside">保</em><em class="blue-color">在线支付保障</em>请您放心购买。</span><span class="right blue-color text-r">收起详情</span></p>
    <p class="clearfix"><p class="fege-line "></p></p>
  <!--   <p class="info-cont">收货地址：北京市朝阳区三环到四环之间金台路万科公园8号楼703 收货人：郭艳辉 136*****7674
</p>
    <p class="info-cont">商品名称：创意太阳系星球星空棒棒糖 平安夜圣诞节元旦男朋友送女朋友10支装精美礼盒
</p> -->
</div>
    <div class="con_below" id="qrcode">
    <center><img src="${base}/res/images/tupian2.png"></center>
    </div>
    <div class="con_pi2" id="con_pi2" style="margin-top: -250px;">
      <p id="df" style="font-size: 10px;">过期后请刷新页面重新获取二维码。</p>
      <p style="font-size: 10px;">距离二微码过期还剩<a style="font-size:20px;color:#ff6600;" id="timeto"></a>秒，</p>
    </div>
</body>
</html>

<script>
     //封包
    var iCount,i = 9;
    var wait=36;
    var paysn='${paysn}';
    $(function(){
       //这个地址是Demo.java生成的code_url,这个很关键
		var url ='${tocodeurl}';
		//var url="wx20151127100916170f8e40950670268306";
		//参数1表示图像大小，取值范围1-10；参数2表示质量，取值范围'L','M','Q','H'
		var qr = qrcode(10, 'M');
		qr.addData(url);
		qr.make();
		/* var dom=document.createElement('DIV');
		dom.innerHTML = qr.createImgTag(); */
		var dom=$("#df").before(qr.createImgTag());
		/* var element=document.getElementById("qrcode");
		element.appendChild(dom); */
		time();//判断时间
        iCount = setInterval(startRequest,4000);//定时请求判断订单是否已支付
    });
      function startRequest() {
        if(!i--){
          clearInterval(iCount);
        }
        $.ajax({
            type: "post",
            url: "${base}/weChatScanpayment/checkorderstate?paysn="+paysn,
            dataType: "json",
            success: function (data) {
                if(data){
                    clearInterval(iCount);
                    location.href="${base}/weChatScanpayment/payfront?ordersn="+paysn;
                }
            }
        });
    }
    
    function time() {
	//console.log(wait);
	if(wait==0){
	
	}else{
		var timeto = $("#timeto");
		timeto.html("(" + wait+")");
		wait--;
		setTimeout(function() {
			time();
		}, 1000);
	}
}
 </script>