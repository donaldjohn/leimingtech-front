<link href="${base}/res/css/member.css" rel="stylesheet" type="text/css">
<link href="${base}/res/css/base.css" rel="stylesheet" type="text/css">
<link href="${base}/res/css/member_user.css" rel="stylesheet" type="text/css">
<script src="${base}/res/js/jquery.js" charset="utf-8"></script>
<div class="eject_con" style="width: 500px">
    <input type="hidden" name="orderSn" id="orderSn" value="${orderSn}">
    <h2>您确定要取消下面的订单吗?</h2>
    <dl>
      <dt>订单号：</dt>
      <dd><span class="num">${orderSn}</span></dd>
    </dl>
    <dl class="bottom">
      <dt>&nbsp;</dt>
      <input type="submit" id="confirm_button" class="submit" value="确定">
    </dl>
</div>
<script type="text/javascript">
	function selectOther(obj){
		if($("#other_reason_input").css('display')=="inline-block"){
			$(".checked").find("li").css("display","");
			$("#other_reason_input").css("display","none");
			$("#d1").attr("checked",true);
		}else{
			$(".checked").find("li").css("display","none");
			$(obj).parent().css("display","");
			$("#other_reason_input").css("display","");
		}
	}
</script>