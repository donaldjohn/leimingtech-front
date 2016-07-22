<@p.userHeader title="订单详情"/>
<script type="text/javascript" src="${base}/res/js/dialog/dialog.js" id="dialog_js" charset="utf-8"></script> 
<script type="text/javascript" src="${base}/res/js/nc-sideMenu.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/res/js/utils.js" charset="utf-8"></script>
<link href="${base}/res/css/font-icons/style.css"  rel="stylesheet" />
<div id="container" class="wrapper">
		<div class="wrap-shadow">
			<div class="wrap-all ncu-order-view">
				<h2>订单详情</h2>
				<#if shopPointsOrder!=''>
				 <dl class="box">
					<dt>订单状态：</dt>
					<dd>
						<#if shopPointsOrder.pointOrderstate==70>
		                    <strong><span style="color:#999">订单已取消</span></strong>
		                <#elseif shopPointsOrder.pointOrderstate==20>
	                    	<strong><span style="color:#36C">待买家付款</span></strong>
		                <#elseif shopPointsOrder.pointOrderstate==30>
		                    <strong><span style="color:#F30">买家已付款</span></strong>
		                <#elseif shopPointsOrder.pointOrderstate==40>
		                	<strong><span style="color:#F30">卖家已发货</span></strong>
		                <#elseif shopPointsOrder.pointOrderstate==50>
		                	<strong><span style="color:#060">买家已收货</span></strong>
		                <#elseif shopPointsOrder.pointOrderstate==20>
		                	<strong>交易已完成</strong>
		                </#if>
		                
					</dd>
					<dt>订单编号：</dt>
					<dd>${shopPointsOrder.pointOrdersn}</dd>
					<dt>下单时间：</dt>
					 <#assign dateFormatTag = newTag("dateFormatTag")/>
  						<#assign  pointAddtime= dateFormatTag("{'date':'${shopPointsOrder.pointAddtime }'}")/>
					<dd>${pointAddtime}</dd>
				</dl>
				<h3>订单信息</h3>
				<table class="ncu-table-style">
					<thead>
						<tr>
							<th class="w10"></th>
							<th class="w70"></th>
							<th>商品名称</th>
							<th>单价</th>
							<th>数量</th>
							<th>商品总价</th>
						</tr>
					</thead>
					<tbody>
					<#assign pointsOrderGoodsTag = newTag("pointsOrderGoodsTag")/>
	    			<#assign pointsOrderAddressTag = newTag("pointsOrderAddressTag")/>
	    			<#assign orderGoodsList = pointsOrderGoodsTag('{"orderid":"${shopPointsOrder.id }"}')/>
					<#if orderGoodsList?size gt 0>
						<#list orderGoodsList as orderGoods>
						<tr class="bd-line">
							<td></td>
							<td>
								<div class="goods-pic-small">
									<span class="thumb size60">
										<i></i>
										<a target="_blank" href="${base}/points/detail?id=${orderGoods.pointGoodsid}">
											<img style="display: inline;" src="${imgServer}${orderGoods.pointGoodsimage}" onload="javascript:DrawImage(this,60,60);">
										</a>
									</span>
								</div>
							</td>
							<td>
								<dl class="goods-name">
									<dt>
										<a href="${base}/points/detail?id=${orderGoods.pointGoodsid}" target="_blank">${orderGoods.pointGoodsname}</a>
									</dt>
								</dl>
							</td>
							<td>
								${orderGoods.pointGoodspoints}
							</td>
							<td>${orderGoods.pointGoodsnum}</td>
							<td>
								<script type="text/javascript">
	              					var goodsAmount = number_format(${orderGoods.pointGoodspoints}*${orderGoods.pointGoodsnum},2);
	              					document.write(goodsAmount);
	              				</script>
							</td>
						</tr>
						</#list>
					</#if>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="20" >
								<dt>礼品总积分：</dt>
								<dd>
								<script type="text/javascript">
	              					var goodsamount = number_format(${shopPointsOrder.pointAllpoint},2);
	              					document.write(goodsamount);
	              				</script>
	              				</dd>
	              				
	              				<dt>运费价格：</dt>
								<dd>¥
								<script type="text/javascript">
	              					var shippingFee = number_format(${shopPointsOrder.shippingFee},2);
	              					document.write(shippingFee);
	              				</script>
	              				</dd>
							</td>
						</tr>
					</tfoot>
				</table>
				<ul class="order_detail_list">
					<#if shopPointsOrder.pointOrdermessage != null && shopPointsOrder.pointOrdermessage != ''>
	                    <li>买家附言：${shopPointsOrder.pointOrdermessage}</li>
	                </#if>
				</ul>
				
				<#assign pointsorderAddress = pointsOrderAddressTag('{"orderid":"${shopPointsOrder.id }"}')/>
				<h3>物流信息</h3>
				<#if pointsorderAddress??>
					<dl class="logistics">
						<dt>收 货 人：</dt>
						<dd>${pointsorderAddress.pointTruename}&nbsp;</dd>
						<dt>电话号码：</dt>
						<dd>${pointsorderAddress.pointTelphone}&nbsp;</dd>
						<dt>手机号码：</dt>
						<dd>${pointsorderAddress.pointMobphone}&nbsp;</dd>
						<dt class="cb">收货地址：</dt>
						<dd style="width: 90%;">${pointsorderAddress.pointAreainfo}&nbsp;&nbsp;${pointsorderAddress.pointAddress}</dd>
					</dl>
				</#if>
				
				<#else>
					<dl>
						<b style="font-size: 2em;">你查看的订单不存在</b>
					</dl>
				</#if>
			</div>
		</div>
</div>
<@p.userfooter/>