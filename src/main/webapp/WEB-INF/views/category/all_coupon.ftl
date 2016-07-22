<@p.header title="优惠券 - LmShop B2B2C V3.0 2015版商城系统" />
 <!--根据店铺id获取店铺内容  -->
<#assign storeInfoTag =newTag("storeInfoTag")>  
<#assign storeVo =storeInfoTag("{'storeId':'${storeId}'}")>

<script type="text/javascript" src="${base}/res/js/jquery.js" ></script>

<div class="clear"></div>
<!--主页内容，调用index-->
<div class="nch-breadcrumb-layout">
	<div class="nch-breadcrumb wrapper">
		<i class="icon-home"> </i> <span><a href="${base}">首页</a></span>
		<span class="arrow"> &gt;</span> <span>所有优惠券</span>
	</div>
</div>
<link href="${base}/res/css/layout.css"
	rel="stylesheet" type="text/css">
<div class="nch-container wrapper">
	<div class="nch-all-menu">
		<ul class="tab-bar">
			<li class="current"><a href="${base}/all/coupon">全部优惠券</a></li>
		</ul>
	</div>
		<div class="title" title="优惠券"></div>
		<div class="nch-barnd-list">
		<ul>
		<#if couponList??>
			<#list couponList as coupon >
				<#if coupon.couponId ??&& coupon.endTime>=now>
	            <li>
					<dl>
						<dt>
							<a href="${base}/search/goodsSearch?searchType=CouponIdSearch&keyword=${coupon.couponId}"><img src="${imgServer}/${coupons.couponPic}" alt="${coupons.couponTitle}"></a>
						</dt>
						<dd>
							${coupon.couponTitle}
						</dd>
						<dd>
							<#if coupon.startTimeStr??>
			                	${coupon.startTimeStr?string("yyyy-MM-dd")}
		                	</#if>
		                	~
							<#if coupon.endTimeStr??>
			                	${coupon.endTimeStr?string("yyyy-MM-dd")}
		                	</#if>
						</dd>
						<dd>
							<input type="button" id="recoupon" value="领取优惠券" onclick="receiveCoupon('${coupon.storeId }','${coupon.couponId}')"/>
						</dd>
					</dl>
				</li>  
	            </#if>
			</#list>
		</#if>
		</ul>
		
		</div>
	</div>
	
</div>
<script type="text/javascript">
//领取优惠券
function receiveCoupon(storeId,couponId){
	$.ajax({
        type: "post",
        url: "${base}/store/receiveCoupon?storeId=" + storeId + "&couponId=" + couponId,
        dataType: "json",
		async:false,
		success:function(data) {
			if(data.success){
				parent.layer.msg(data.msg,{icon:1,time:1000},function(){
					$("#recoupon").val("已领取");
				});
			}else{
				parent.layer.msg(data.msg,{icon:2,time:1000},function(){
					
				});
			}
		}
    });
}
</script>
<script>
jQuery(".nch-brand-class").slide({titCell:".hd ul li",mainCell:".bd",titOnClassName:"tabs-selected"});
</script>
<div class="clear"></div>
<!-----footer------>
<@p.footer />
