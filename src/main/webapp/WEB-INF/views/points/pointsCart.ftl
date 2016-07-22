<#assign pointsCartTag = newTag("pointsCartTag") />
<#assign pointsCartlistVo = pointsCartTag() />
<@p.header title="LmShop B2B2C V3.0 2015版商城系统"/>
<link href="${base }/res/css/home_point.css" rel="stylesheet" type="text/css">
<link href="${base }/res/css/home_cart.css" rel="stylesheet" type="text/css">
<link href="${base }/css/points/integral.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/res/js/layer/layer.js" charset="utf-8"></script>
<ul class="point-chart">
  <li class="step a1" title="确认兑换清单"></li>
  <li class="step b2" title="确认收货人资料"></li>
  <li class="step c2" title="兑换完成"></li>
</ul>
<div class="content wrapper">
    <div class="cart-title">
      <h3>已选择的兑换礼品</h3>
    </div>
    <table class="buy-table">
     <#if pointsCartlistVo.list?size&gt;0>
      <thead>
        <tr>
          <th colspan="2">礼品名称<hr/></th>
          <th class="w120">兑换积分<hr/></th>
          <th class="w120">兑换数量<hr/></th>
          <th class="w120">积分小计<hr/></th>
          <th class="w120">操作<hr/></th>
        </tr>
      </thead>
      <tbody>
	      <#list pointsCartlistVo.list as pointsCart>
		      <tr id="pcart_item_${pointsCart.id}">
		        <td class="w70"><p class="ware_pic"><a href="${base }/points/detail?id=${pointsCart.pgoodsId}" target="_blank"><span class="thumb size-60"><i></i>
		        <img src="${imgServer}${pointsCart.pgoodsImage}" onerror="this.src='${base}/res/images/common/default_goods_image.gif'" alt="${pointsCart.pgoodsName}" onload="javascript:DrawImage(this,60,60);" /></span></a></p></td>
		        <td class="tl vt"><dl class="cart-goods-info">
		            <dt class="cart-goods-info-name"><a href="${base}/points/detail?id=${pointsCart.pgoodsId}" target="_blank">${pointsCart.pgoodsName}</a></dt>
		          </dl>
		        </td>
		        <td class="w70"><span class="price${pointsCart.id}">${pointsCart.pgoodsPoints}</span></td>
		        <td class="w70"><a href="JavaScript:void(0);" onclick="pcart_decrease_quantity(${pointsCart.id});" title="减少" class="subtract">&nbsp;</a>
		          <input id="input_item_${pointsCart.id}" value="${pointsCart.pgoodsChoosenum}" changed="${pointsCart.id}" onkeyup="pcart_change_quantity('${pointsCart.id}', this);" class="text1 w30" type="text" style="width:30px; *float: left;text-align: center;"/>
		          <a href="JavaScript:void(0);" onclick="pcart_add_quantity(${pointsCart.id});" title="增加" class="adding">&nbsp;</a>
		        </td>
		        <td class="w70"><span id="item_${pointsCart.id}_subtotal" class="cart-point mr5">${pointsCart.pgoodsPoints*pointsCart.pgoodsChoosenum }</span>分</td>
		        <td class="w70"><a class="del" href="javascript:void(0)" onclick="drop_pcart_item('${pointsCart.id}');">删除</a></td>
		      </tr>
	      </#list>
       </tbody>
      <#else>
	       <tbody>
	        <tr>
	          <td height="60px"><span style="font-size:15px;">购物车里什么都没有</span></td>
	        </tr>
		   </tbody>
      </#if>
    </table>
    <div class="cart-bottom">
      <p>所需总积分：<span class="cart-point-b mr5" id="pcart_amount">${pointsCartlistVo.goodsTotalNums }</span>分</p>
      <p><a class="cart-back-button mr10" href="${base }/points/more">继续兑换</a><a href="javascript:;" onclick="confirm()" class="cart-button">填写并确认兑换</a></p>
    </div>
</div>
<!-----footer------>
<script type="text/javascript">
function confirm(){
	if($(".buy-table tr").length==1){
		layer.msg("购物车里什么都没有！");
		return false;
	}
	location.href='${base }/points/user/pointsCartStep2';
}

function pcart_change_quantity(pcart_id, input){
    var amount_span = $('#pcart_amount');
    var subtotal_span = $('#item_' + pcart_id + '_subtotal');
    var quantity_input = $('#input_item_' + pcart_id);
    //暂存为局部变量，否则如果用户输入过快有可能造成前后值不一致的问题
    var _v = input.value;
    $.getJSON('${base}/points/user/updatePointsCart?shopPointsCartId=' + pcart_id + '&pointsGoodsNum=' + _v,'POST', function(result){
        if(result.result=='true'){
            //更新成功
            $(input).attr('changed', _v);
            amount_span.html(result.amount);
            subtotal_span.html(result.subtotal);
            quantity_input.val(result.quantity);
        }
        else{
            //更新失败
            layer.msg(result.msg);
            window.location.reload();    //刷新
        }
    });
}
function pcart_decrease_quantity(pcart_id){
    var item = $('#input_item_' + pcart_id);
    var orig = Number(item.val());
    if(orig > 1){
        item.val(orig - 1);
        item.keyup();
    }
}
function pcart_add_quantity(pcart_id){
    var item = $('#input_item_' + pcart_id);
    var orig = Number(item.val());
    item.val(orig + 1);
    item.keyup();
}
//删除兑换积分礼品购物车
function drop_pcart_item(pcart_id){
    var tr = $('#pcart_item_' + pcart_id);
    var amount_span = $('#pcart_amount');
    var cart_goods_kinds = $('#cart_goods_kinds');
    $.post('${base}/points/user/delete?ids=' + pcart_id, function(result){
    	window.location.reload();    //刷新
    });
}
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
