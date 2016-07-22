<@p.header title="LmShop B2B2C V3.0 2015版商城系统"/>
<script src="${base}/res/js/layer/layer.js"></script>
<script>
	//加载完毕后,查询用户是否登陆,如果登陆则改变页头状态
	/*异步请求查询是否登陆*/
	var url = '${base}/index/getUsername';
	$.post(url, function(data){
		var result = data.result;
		$(".user-entry").empty();
		/*用户已经登陆*/
		if(result == 'true'){
			var memberName = data.memberName;
			$(".user-entry").append("您好<span>&nbsp;&nbsp;<a href='${base}/user/setting/index'>"+memberName+"</a></span>，欢迎来到"
			+"<a href='${base}'  title='首页' alt='首页'>雷铭商城系统演示站</a><span>[<a href='${base}/logout'>退出</a>]</span>");
		}else{
			$(".user-entry").append("您好，欢迎来到<a href='${base}' title='首页' alt='首页'>雷铭商城系统演示站</a>"
			+"<span>[<a href='${base}/login'>登录</a>]</span><span>[<a href='${base}/signUp'>注册</a>]</span>");
		}
		$(".user-entry").append("<span class='seller-login'>"
				+"<a href='${sellerServer}' title='商家中心' target='_blank'><i class='icon-signin'></i>商家管理中心</a></span>");
	});
</script>
<div class="clear"></div>
<link href="${base }/css/points/public.css" type="text/css" rel="stylesheet" />
<link href="${base }/css/points/integral.css" rel="stylesheet" type="text/css" />
<script>
jQuery(document).ready(function() {
	jQuery(".inte_rank").slide({titCell:".li_list",targetCell:".li_hover",defaultIndex:1,effect:"slideDown",triggerTime:0,returnDefault:true}); 
	jQuery(".inte_choose").find("li").removeClass("this");
	jQuery(".inte_choose").find("li").eq(0).addClass("this");
});
</script>
<!--[if lt IE 9]>
    <script src="#/resources/js/css3-mediaqueries.js"></script>
<![endif]-->
<style type="text/css">
.left_menu_con_center_left dd a {
	font-weight: normal;
	font-size: 12px;
}
</style>
<div class="main">
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
                    <div class="li_hover_img"><a href="#/integral/view_${hotPointsOrderGoods.shopPointsGoods.id}.htm" target="_blank"><img src="${imgServer}${hotPointsOrderGoods.shopPointsGoods.pointsGoodsImage}" /></a></div>
                    <div class="inte_price">
                        <span>市场价格:¥<s>${hotPointsOrderGoods.shopPointsGoods.pointsGoodsStorePrice}</s></span>
                        <span>兑换积分:<i class="red">${hotPointsOrderGoods.shopPointsGoods.pointsnums}</i>分</span>
                        <span>兑换数量:<i class="red">${hotPointsOrderGoods.pointGoodscount}</i>个</span>
                    </div>
                </div>
            </#list>
		</div>
	</div>

	<div class="integral_right">

		<dl class="integral_select">
			<dt>
				<span>积分选择区</span>
			</dt>
			<dd>
				<ul id="rang_ul">
					<li <#if begin==null||begin==""||end==null||end=="">class="this" </#if>><a href="${base}/points/more">全部</a></li>
	            	<li <#if begin?exists&&begin==0   && end?exists &&end=="1999">class="this" </#if>><a href="?begin=0&end=1999&rank=1">1999分以下</a></li>
	                <li <#if begin?exists&&begin==2000&& end?exists &&end=="3999">class="this" </#if>><a href="?begin=2000&end=3999&rank=2">2000分~3999分</a></li>
	                <li <#if begin?exists&&begin==4000&& end?exists &&end=="5999">class="this" </#if>><a href="?begin=4000&end=5999&rank=3">4000分~5999分</a></li>
	                <li <#if begin?exists&&begin==6000&& end?exists &&end=="9999">class="this" </#if>><a href="?begin=6000&end=9999&rank=4">6000分~9999分</a></li>
	                <li <#if begin?exists&&begin==10000&& end?exists &&end=="0">class="this" </#if>><a href="?begin=10000&end=0&rank=5">10000以上</a></li>
				</ul>
			</dd>
		</dl>
		<div class="inte_list_box">
			<div class="inte_list">
			<#assign recommendPointsGoodsTag = newTag("recommendPointsGoodsTag") />
              <#assign pager = recommendPointsGoodsTag("{'pageNo':'${pageNo}','begin':'${begin}','end':'${end}'}") />
              <#list pager.result as pointsGoods >
				<ul>
					<li class="recom_img"><a href="${base}/points/detail?id=${pointsGoods.id}"
						target="_blank"><img
							src="${imgServer}${pointsGoods.pointsGoodsImage}"
							width="200" height="200" /></a><span><a
							href="${base}/points/detail?id=${pointsGoods.id}" target="_blank">${pointsGoods.pointsGoodsName}
						</a></span><em></em></li>
					<li class="inte_number">
						<div class="level_img">
							<img
								src="${base}/css/points/userlevel_${pointsGoods.memberGradeId}.png"
								width="25" height="45" />
						</div>
						<div class="level_num">
							<strong>
						  <#if pointsGoods.memberGradeId &&pointsGoods.memberGradeId=='0' >V0及以上会员 </#if> 
            			<#if pointsGoods.memberGradeId &&pointsGoods.memberGradeId=='1' >V1及以上会员 </#if> 
            			<#if pointsGoods.memberGradeId &&pointsGoods.memberGradeId=='2' >V2及以上会员 </#if> 
            			<#if pointsGoods.memberGradeId &&pointsGoods.memberGradeId=='3' >V3及以上会员 </#if> 
							</strong> <b>需要${pointsGoods.pointsnums}积分</b>
						</div> <a href="javascript:;" onclick="return addCart('${pointsGoods.id}');" >兑换</a>
					</li>
				</ul>
				</#list>
			</div>
		</div>
 <#-- 分页用我们系统的样式 -->
		<div class="ext_page">
		
                <#import "/search/search-page-pointsgoods.ftl" as q><!--引入分页-->
                <#if pager!="" && pager??>
                <#if pager.totalRows??>
                    <@q.pager pageNo=pager.pageNo pageSize=pager.pageSize recordCount=pager.totalRows toURL="${toUrl}"/>
                </#if>
                </#if>
		</div>
	</div>
<script>

function addCart(pointsGoodsId){
	if(!isLogin){
		layer.alert("请先登录",{icon:1});
		return false;
	}
	//异步地址
		var url = '${base}/points/user/addCart';
		//参数
		var args = {"shopPointsGoodsId":pointsGoodsId};
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

 var toPageNo="";
     //排序,过滤条件搜索
    function searchPointsGoods(){
    	var url = '${base}/points/more';
    	//分页
    	if(toPageNo != ""){
    		url += '?pageNo=' + toPageNo;
    	}
    	//搜索
    	window.location.href = url;
    }
jQuery(document).ready(function(){
			//滚动条滚动事件
	jQuery(window).scroll(function(){
	var top = jQuery(document).scrollTop();
	if(top==0){
		  jQuery("#back_box").hide();
		  jQuery(".back_box_x").hide();
		}else{
		  jQuery("#back_box").show();	
	      jQuery(".back_box_x").show();
		}
	});	
	//
	jQuery("#toTop").click(function(){
       jQuery('body,html').animate({scrollTop:0},1000);
       return false;
    });
});
</script>
<@p.footer/>