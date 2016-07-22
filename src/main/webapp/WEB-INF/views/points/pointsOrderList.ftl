<@p.userHeader title="我的订单"/>
<script type="text/javascript" src="${base}/res/js/nc-sideMenu.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/res/js/utils.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/res/js/layer/layer.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/res/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<link href="${base}/res/css/font-icons/style.css"  rel="stylesheet" />
<div id="container" class="wrapper">
	<div class="layout">
    	<@u.left/>
    	<div class="right-content"> 
      		<div class="path">
        		<div>
        			<a href="${base}/user/index">我的商城</a><span>&raquo;</span>
                    <a href="${base}/points/user/list"/>我的订单</a><span>&raquo;</span>
                   	订单列表
                </div>
      		</div>
      		<div class="main">
       			<link rel="stylesheet" type="text/css" href="${base}/res/js/jquery-ui/themes/ui-lightness/jquery.ui.css"  />
				<style type="text/css">
				.store-name {
					width: 130px;
					display: inline-block;
					overflow: hidden;
					white-space: nowrap;
					text-overflow: ellipsis;
				}
				</style>
				<div class="wrap">
  					<div class="tabmenu">
    					<ul class="tab pngFix">
  							<li class="active"><a  href="#">订单列表</a></li>
  						</ul>
  					</div>
  					<form method="post" action="${base}/points/user/orderList" target="_self" id="queryForm" >
    					<table class="search-form">
      						<input type="hidden" name="act" value="member" />
      						<input type="hidden" name="op" value="order" />
      						<tr>
        							<th>订单号：</th>
        							<td class="w100"><input type="text" class="text" style="width: 130px" name="orderSn" value="${orderSn}"></td>
        							<th>订单状态：</th>
        							<td class="w100">
        								<select name="state">
							         	   	<option value="" <#if orderState=="">selected</#if>>所有订单</option>
					                        <option value="20" <#if orderState==20>selected</#if>>待付款</option>
					                        <option value="30" <#if orderState==30>selected</#if>>待发货</option>
					                        <option value="40" <#if orderState==40>selected</#if>>已发货</option>
					                        <option value="50" <#if orderState==50>selected</#if>>已收货</option>
					                        <option value="60" <#if orderState==60>selected</#if>>已确认</option>
					                        <option value="70" <#if orderState==70>selected</#if>>已取消</option>
          								</select>
          							</td>
          							<th>下单时间：</th>
          							<td class="w260">
	        							<input name="startTime" id="add_time_from" type="text" style="width: 110px" class="txt Wdate" value="${startTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'});" />&#8211;
	          							<input name="endTime" id="add_time_to" type="text" style="width: 110px" class="txt Wdate" value="${endTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
	          						</td>
        							<td class="w90 tc">
        								<input type="submit" class="submit" value="搜索" />
        							</td>
      							</tr>
    						</table>
						</form>
  						<table class="order ncu-table-style">
    						<thead>
      							<tr>
									<th class="w10"></th>
        							<th class="w70"></th>
        							<th>商品信息</th>
        							<th class="w60">礼品原价</th>
        							<th class="w60">所需积分</th>
        							<th class="w40">数量</th>
        							<th class="w100">订单总积分</th>
        							<th class="w110">状态与操作</th>
      							</tr>
    						</thead>
        					<tbody>
        					<#assign pointsOrderTag = newTag("pointsOrderTag")/>
       						<#assign pointsOrderGoodsTag = newTag("pointsOrderGoodsTag")/>
       						<#assign dateFormatTag = newTag("dateFormatTag")/>
							<#assign orderLists = pointsOrderTag("{'orderSn':'${orderSn}','startTime':'${startTime}','endTime':'${endTime}','orderState':'${orderState}','returnDataType':'2','pageNo':'${pageNo}','pageSize':'${pageSize}'}") />
       						<#if orderLists??>
        						<#list orderLists as order>
	            					<tr>
										<td colspan="19" class="sep-row"></td>
	      							</tr>
	      							<tr>
	        							<th colspan="19"> 
	        							<#assign pointAdddtime = dateFormatTag('{"date":"${order.pointAddtime}","format":"yyyy-MM-dd HH:mm:ss"}')/>
	        								<span class="fl ml10">订单号：<span class="goods-num"><em>${order.pointOrdersn}</em></span></span> 
	        								<span class="fl ml20">下单时间：<em class="goods-time">${pointAdddtime}</em></span> 
	        								<span class="fl ml20"><a href="${base}/points/user/orderdetail?orderId=${order.id}" target="_blank" class="nc-show-order">
	        									<i></i>查看订单</a>
	                    					</span> 
	                    					<!-- <span class="fr">
	                    						<a href="javascript:void(0)" class="snsshare-btn" nc_type="sharegoods" data-param='{"gid":"88"}'>
		                    						<i></i>
		          									<h5>分享商品</h5>
	          									</a>
	          								</span> -->
	          							</th>
	      							</tr>
	      							<#assign orderGoodsLists = pointsOrderGoodsTag("{'orderid':'${order.id }'}") />
	      							<#if orderGoodsLists?size gt 0>
      								<#assign rowsize = orderGoodsLists?size>
	  								<#list orderGoodsLists as orderGoods>
	   								<tr>
		       							<td class="bdl"></td>
		       							<td>
		       								<div class="goods-pic-small">
		       									<span class="thumb size60">
		       										<i></i>
		       										<a href="${base}/points/detail?id=${orderGoods.pointGoodsid}" target="_blank">
		       											<img src="${imgServer}${orderGoods.pointGoodsimage}" onload="javascript:DrawImage(this,60,60);" />
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
		       							<td class="goods-price">
		       								<i>
		       									<script type="text/javascript">
					              					var price = number_format(${orderGoods.pointGoodspoints},2);
					              					document.write(price);
					              				</script>
		       								</i>
		       							</td>
	      								<td>${orderGoods.pointGoodspoints}</td>
	      									<td>${orderGoods.pointGoodsnum}</td>
	      								<#if orderGoods_index == 0>
	      								<td class="bdl" rowspan="${rowsize}" >
	      									<p id="order6_order_amount">
											    <strong>
											    	<script type="text/javascript">
						              					var amount = number_format(${order.pointAllpoint},2);
						              					document.write(amount);
						              				</script>
											    </strong>
											</p>
											<p class="goods-freight">
												<#if order.shippingFee??>
									          		<#if order.shippingFee!=0>
									          			运费:
									          			<script type="text/javascript">
							              					var shipFee = number_format(${order.shippingFee},2);
							              					document.write(shipFee);
							              				</script>
							              			<#else>
							              				（免运费）
									          		</#if>
									          	</#if>
											</p>
	      								</td>
	      								<td class="bdl bdr" rowspan="${rowsize}">
											<#if order.pointOrderstate==70>
							                    <p><span style="color:#999">订单已取消</span><br/></p>
							                <#elseif order.pointOrderstate==20>
						                    	<p><span style="color:#36C">待买家付款</span><br/></p>
						                    	<p><a href="javascript:void(0)" onclick="cancelOrder('${order.pointOrdersn}','${order.id}')" style="color:#F30; text-decoration:underline;">取消订单</a></p>
						                    	<p>
						                    		<a href="${base}/points/user/pointsCartStep3?orderid=${order.id}" target="_blank" class="ncu-btn6 mt5" id="order1_action_confirm">付款</a>
						                    	</p>
							                <#elseif order.pointOrderstate==30>
							                    <p><span style="color:#F30">买家已付款</span><br/></p>
							                <#elseif order.pointOrderstate==40>
							                	<p><span style="color:#F30">卖家已发货</span><br/></p>
	                              				<p><a href="javascript:void(0)" class="ncu-btn7 mt5" onclick="finishOrder('${order.pointOrdersn}','${order.id }')" id="order5_action_cancel">确认收货</a></p>
							                <#elseif order.pointOrderstate==50>
						                		<p>
						                			<span style="color:#060">买家已收获</span><br/>
						                		</p>
							                <#elseif order.pointOrderstate==60>
							                	<p>订单已完成<br/></p>
							                </#if>
	      								</td>
	      								</#if>
	      							</tr>
	      							</#list>
	      							</#if>
              					</#list>
              				</#if>
              				
              				
                			</tbody>
        					<tfoot>
      							<tr>
        							<td colspan="19">
        								<#--获取总条数-->
									<#assign recordCount = pointsOrderTag("{'orderSn':'${orderSn}','startTime':'${startTime}','endTime':'${endTime}','orderState':'${orderState}','returnDataType':'1','pageNo':'${pageNo}','pageSize':'${pageSize}'}") />
        								<#import "/commons/usertagpage.ftl" as q> <#--引入分页-->
										<#if recordCount??>
										    <@q.pager pageNo=pageNo pageSize=pageSize recordCount=recordCount toURL="${toUrl}"/>
										</#if>
        							</td>
								</tr>
    						</tfoot>
      					</table>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
var APP_BASE = '${base}';
//订单支付方法
function goPay(ordersn, paymentId) {
    location.href = APP_BASE + "/cart/orderpay?paysn="+ordersn+"&paymentId="+paymentId;
}

/**取消订单**/
function cancelOrder(orderSn,id) {
   	layer.open({
	    type: 2,
	    area: ['500px', '290px'],
	    skin: 'layui-layer-rim',
	    title: '取消订单',
	    //content: APP_BASE + '/cart/addresslist'
	    content :  ['${base}/points/user/cancelOrderIndex?orderSn=' + orderSn, 'no'],
	    success: function(layero, index){
	    	layer.getChildFrame('#confirm_button',index).on('click', function(){
				var fmUrl = '${base}/points/user/cancelOrder';
				$.ajax({
		             type: "post",
		             url: fmUrl,
		             data: {orderid:id},
		             dataType: "json",
					 success:function(data) {
						if(data.success){
							parent.layer.alert("订单取消成功",{icon:1},function(){
								location.reload();
							});	
						}else{
							parent.layer.alert("订单取消失败",{icon:2},function(){
								location.reload();
							});		
						}
					}
		         });
			});	
	    }
	});
}

/**确认收货**/
function finishOrder(ordersn,id) {
   	layer.open({
	    type: 2,
	    area: ['500px', '240px'],
	    skin: 'layui-layer-rim',
	    title: '确认收货',
	    //content: APP_BASE + '/cart/addresslist'
	    content :  ['${base}/points/user/finishOrderIndex?orderSn=' + ordersn, 'no'],
	    success: function(layero, index){
	    	layer.getChildFrame('#confirm_button',index).on('click', function(){
				var orderSn=layer.getChildFrame("#orderSn",index).val();
				var fmUrl = '${base}/points/user/finishOrder';
				$.ajax({
		             type: "post",
		             url: fmUrl,
		             data: {orderid:id},
		             dataType: "json",
					 success:function(data) {
						if(data.success){
							parent.layer.alert("确认收货成功",{icon:1},function(){
								location.reload();
							});	
						}else{
							parent.layer.alert("确认收货失败",{icon:2},function(){
								location.reload();
							});		
						}
					}
		         }); 
			});	 
	    }
	});
}

/**退款**/
function refund(id){
	layer.open({
	    type: 2,
	    area: ['500px', '300px'],
	    skin: 'layui-layer-rim',
	    title: '订单退款',
	    //content: APP_BASE + '/cart/addresslist'
	    content :  ['${base}/user/refundOrderIndex?orderId=' + id, 'no'],
	    success: function(layero, index){
	    	layer.getChildFrame('#confirm_button',index).on('click', function(){
				var orderId=layer.getChildFrame("input[name='orderId']",index).val(); //订单id
				var orderRefund=layer.getChildFrame("input[name='order_refund']",index).val(); //订单退款金额
				var buyerMessage=layer.getChildFrame("textarea[name='buyer_message']",index).val(); //退款原因
				if(orderRefund==''){
					layer.msg("请填写退款金额",{icon:2});
					return false;
				}else if(buyerMessage==''){
					layer.msg("请填写退款原因",{icon:2});
					return false;
				} 
				var fmUrl = '${base}/user/refundOrder';
				$.ajax({
		             type: "post",
		             url: fmUrl,
		             data: {orderId:orderId,orderRefund:orderRefund,buyerMessage:buyerMessage},
		             dataType: "json",
					 success:function(data) {
						if(data.success){
							parent.layer.alert("退款提交成功",{icon:1},function(){
								location.reload();
							});	
						}else{
							parent.layer.alert("退款提交失败",{icon:2},function(){
								location.reload();
							});		
						}
					}
		         }); 
			});	   
	    }
	});
}
</script>
<@p.userfooter/>