<#assign pointsCartTag = newTag("pointsCartTag") />
<#assign pointsCartlistVo = pointsCartTag() />
<@p.header title="LmShop"/>
<link href="${base }/res/css/home_point.css" rel="stylesheet" type="text/css">
<link href="${base }/res/css/home_cart.css" rel="stylesheet" type="text/css">
<link href="${base }/css/points/public.css" type="text/css" rel="stylesheet" />
<link href="${base }/css/points/integral.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/res/js/cart/goods_cart.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/res/js/common_select.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/res/js/layer/layer.js" charset="utf-8"></script>
<style type="text/css">
#navBar {display: none !important;}
</style>
<ul class="point-chart">
  <li class="step a2" title="确认兑换清单"></li>
  <li class="step b1" title="确认收货人资料"></li>
  <li class="step c2" title="兑换完成"></li>
</ul>
<form method="post" id="porder_form" name="porder_form" action="${base }/points/user/pointsCartStep3">
  	<div class="content wrapper">
		<div id="warning" class="warning" style="display:none;"></div>
		<div class="cart-title">
  			<h3>收货人地址</h3>
 			<div class="btns">
  				<a href="JavaScript:void(0);" id="span_newaddress" onclick="shownewaddress();" class="newadd"><i></i>使用新地址</a>
  			</div>
		</div>
		<div id="addressone_model" style="display:none;">
		  <ul class="receive_add address_item">
		    <li class="goto">寄送至</li>
		    <!-- <li address="" buyer=""></li> -->
		  </ul>
		</div>
		<div id="addresslist">
			<#assign addressTag = newTag("addressTag") />
			<#assign addressList =addressTag() />
			<#if addressList??>
				<#list addressList as address>
					<#if address.isDefault == 1>
						<ul class="receive_add address_item selected_address">
			    			<li class="goto">寄送至</li>
			    			<li address="${address.areaInfo}&nbsp;&nbsp;${address.address}" buyer="${address.trueName}&nbsp;&nbsp;${address.mobPhone}">
			      				<input id="address_${address.addressId}" type="radio" city_id="${address.cityId}" name="address_options" value="${address.addressId}" checked/>
			      				&nbsp;&nbsp;${address.areaInfo}&nbsp;&nbsp;${address.address}&nbsp;&nbsp; ${address.trueName}&nbsp;&nbsp; ${address.mobPhone}  
			      			</li>
			  			</ul>
			  			<input type="hidden" id="chooseaddressid" name="chooseaddressid" value='${address.addressId}'/>
			  			<#else>
		  				<ul class="receive_add address_item">
			    			<li class="goto">  &nbsp; </li>
			    			<li address="${address.areaInfo}&nbsp;&nbsp;${address.address}" buyer="${address.trueName}">
			      				<input id="address_${address.addressId}" type="radio" city_id="${address.cityId}" name="address_options" value="${address.addressId}" />
			      				&nbsp;&nbsp;${address.areaInfo}&nbsp;&nbsp;${address.address}&nbsp;&nbsp; ${address.trueName}&nbsp;&nbsp; ${address.mobPhone}  
			      			</li>
			  			</ul>
			  			<input type="hidden" id="chooseaddressid" name="chooseaddressid" value='${address.addressId}'/>
					</#if>
				</#list>
			</#if>
		</div>		
    <!-- 已经存在的收获地址end --> 
    <!-- 留言start -->
    <div class="cart-title">
      <h3>已选礼品</h3>
    </div>
    <!-- 已经选择礼品start -->
    <table class="buy-table">
      <thead>
        <tr>
          <th colspan="2">兑换商品信息<hr/></th>
          <th class="w120">兑换所需积分<hr/></th>
          <th class="w120">兑换数量<hr/></th>         
        </tr>
      </thead>
      <tbody>
       <#list pointsCartlistVo.list as pointsCart>
          <tr>
	          <td class="w70">
		          <div class="cart-goods-pic">
		          	<a href="${base }/points/detail?id=${pointsCart.pgoodsId}" target="_blank"><span class="thumb size60">
		          	<img src="${imgServer}${pointsCart.pgoodsImage}" onerror="this.src='${base }/res/images/common/default_goods_image.gif'" alt="${pointsCart.pgoodsName}" onload="javascript:DrawImage(this,60,60);" /></span>
		         	</a>
		          </div>
	          </td>
	          <td class="tl vt"><dl class="cart-goods-info">
	              <dt class="cart-goods-info-name"><a target="_blank" href="${base }/points/detail?id=${pointsCart.pgoodsId}">${pointsCart.pgoodsName}</a></dt>
	            </dl></td>
	          <td><span class="money">${pointsCart.pgoodsPoints}&nbsp;分</span></td>
	          <td>${pointsCart.pgoodsChoosenum}</td>
          </tr>
      </#list>
      </tbody>
      <tfoot>
        <tr>
         <td colspan="2"><label>我要留言&nbsp;<input type="text" class="w400 text" onclick="pcart_messageclear(this);" name="shopPointsOrderMessage" value="" placeholder="选填，可以写下您对礼品的需求"/>
            </label>
         </td>
         <td colspan="3" class="tr">
        	<i class="transport-ico"></i><span id="ship"><!-- 显示运费 -->免运费</span>
         </td>
        </tr>
      </tfoot>
    </table>
    <!-- 已经选择礼品end --> 

    <!-- 订单金额统计start -->
    <div class="cart-bottom">
      <div class="confirm-popup">
        <div class="confirm-box">
          <dl>
            <dt>所需总积分：<dt>
            <dd><span class="cart-point-b mr5">${pointsCartlistVo.goodsTotalNums }</span>分</dd>
          </dl>
          <dl>
            <dt>寄送至：</dt>
            <dd id="confirm_address"></dd>
          </dl>
          <dl>
            <dt>收货人：</dt>
            <dd id="confirm_buyer"></dd>
          </dl>
        </div>
      </div>
      <p><a href="${base }/points/user/pointsCart" class="cart-back-button mr10">返回兑换列表</a><a href="javascript:;" onclick="formSubmit()" class="cart-button">兑换完成</a></p>
    </div>
    <!-- 订单金额统计end --> 
  </div>
</form>
<script type="text/javascript">
	$(function(){	
		addShipping();
	});
	var isSubmit=false;
	function formSubmit(){
		if ($('input[name="address_options"]:checked').val() == null){
			layer.alert('请设置收货地址',{icon:2});
			return false;
		}
		if(isSubmit){
			return false;
		}
		isSubmit=true;
		$.ajax({
        	url:'${base}/points/user/validatePointsOrder',
            type:'post',
            dataType:'json',
            success:function(data){
            	if(data.result=='true'){
            		$.ajax({
        	        	url:'${base}/points/user/submitOrder',
        	            type:'post',
        	            data:$("#porder_form").serialize(),
        	            dataType:'json',
        	            success:function(data){
        	            	if(data.result=='true'){
        	            		location.href="${base}/points/user/pointsCartStep3?orderid="+data.orderid;
        	            	}else{
        	            		layer.alert(data.msg,{icon:2});
        	            		return false;
        	            	}
        	            },error:function(){
        	            	layer.alert('程序出错',{icon:2});
        	            }
        		    });
            	}else{
            		isSubmit=false;
            		layer.alert(data.msg,{icon:2});
            		return false;
            	}
            },error:function(){
            	layer.alert('程序出错',{icon:2});
            }
	    });
	}

	//加载运费
 	function addShipping(){
 		//市级id
 		var cityId = "";
 		//收货地址信息
 		var city = $("input[name='address_options']:checked");
 		//若选择收货地址,获取城市id
 		if (typeof(city) != "undefined"){
 			cityId = city.attr("city_id");
 		}
 		$.ajax({
        	url:'${base}/points/user/addShipping',
            type:'post',
            data : {'cityId':cityId},
            dataType:'json',
            success:function(data){
            	if(data.success){
            			var str='';
            			var key=0;
            			var num = 0; //循环次数
					    str+="<span>配送方式：<select name='transport_type' onChange='shipUpdate(this,0);' >";
					    $.each(data.result,function(key1,values1){  //遍历运费模板map
					    	num += 1;
					    	str+='<option value="';
					    	str+=key1+'">';  //选择的值为运输方式|店铺id
					    	if(key1=='py'){
					    		str+='平邮  '+toDecimal2(values1);
					    	}else if(key1=='kd'){
					    		str+='快递  '+toDecimal2(values1);
					    	}else if(key1=='es'){
					    		str+='EMS  '+toDecimal2(values1);
					    	}
					    	str+='</option>';
					    });   
					    str+='</select></span>';
					    //将运费加入页面
					    if(num!=0){
					    	$("#ship").html(str);
					    }
					//getTotalPrice();
                }
            },error:function(data){
            	layer.msg('通信失败', {icon: 2});
            }
        }); 
 	}

//准换价格格式
	function toDecimal2(x) {   
	    var f = parseFloat(x);   
	    if (isNaN(f)) {   
	        return false;   
	    }   
	    var f = Math.round(x*100)/100;   
	    var s = f.toString();   
	    var rs = s.indexOf('.');   
	    if (rs < 0) {   
	        rs = s.length;   
	        s += '.';   
	    }   
	    while (s.length <= rs + 2) {   
	        s += '0';   
	    }   
	    return s;   
	}  
	//<![CDATA[
    //选择已经存在的收货人地址
    $('.address_item').live('click',function(){
    	$(this).parent().find('.goto').html('&nbsp;');
    	$(this).children().first().html('');
        var checked_address_radio = $(this).find("input[name='address_options']");
        $(checked_address_radio).attr('checked', true);
        $('.address_item').removeClass('selected_address');
        $(this).addClass('selected_address');
        $("#chooseaddressid").val($(checked_address_radio).val());
        getTransport();
        var _next = $(this).find('li').eq(1);
        $('#confirm_address').html($(_next).attr('address'));
        $('#confirm_buyer').html($(_next).attr('buyer'));
        addShipping();
    });
        //弹出填写收货地址
		//shownewaddress();
	function pcart_messageclear(tt){
		if (!tt.name){
			tt.value = '';
			tt.name = 'pcart_message';
		}
	}
		/**添加收货地址**/
		function shownewaddress(){
			layer.open({
	            type:2,
	            move: false,
	            shade: false,
	            title: '新增地址',
	            content:['${base}/cart/addresslist', 'no'],
	            area: ['550px', '400px'],
	            btns: 2,
	            btn: ['确定', '取消'],
	            yes: function (index) {
	                var provinceId = layer.getChildFrame('#area').val(); //省的id
	                var cityId = layer.getChildFrame('#city').val(); //城市id
	                var areaId = layer.getChildFrame('#qu').val(); //区的id
	                var address = layer.getChildFrame('#address').val(); //具体地址
	                var zipCode = layer.getChildFrame('#zipCode').val(); //邮政编码
	                var trueName = layer.getChildFrame('#trueName').val(); //收货人
	                var mobPhone = layer.getChildFrame('#mobPhone').val(); //收货人手机号

	                var provinceval = layer.getChildFrame('#area').find("option:selected").html(); //省的值
	                var cityval = layer.getChildFrame('#city').find("option:selected").html(); //城市的值
	                var quval = layer.getChildFrame('#qu').find("option:selected").html(); 	 //区的值
	                var areaInfo=provinceval+","+cityval+","+quval;//保存到常用地址表
	                if(trueName.trim()==''){
	                    layer.getChildFrame(".trueNameMsg").html('收货人不能为空');
	                    return false;
	                }else{
	                    layer.getChildFrame(".trueNameMsg").html('');
	                }
	                
	                if(provinceId==''||provinceId=='0'){
	                    layer.getChildFrame(".areaMsg").html('请选择省份');
	                    return false;
	                }else{
	                    layer.getChildFrame(".areaMsg").html('');
	                }
	                if(cityId==''||cityId=='0'){
	                    layer.getChildFrame(".areaMsg").html('请选择城市');
	                    return false;
	                }
	                if(areaId==''||areaId=='0'){
	                    layer.getChildFrame(".areaMsg").html('请选择区');
	                    return false;
	                }else{
	                    layer.getChildFrame(".areaMsg").html('');
	                }
	                if(mobPhone.trim()==''){
	                   	layer.getChildFrame(".mobPhoneMsg").html('手机号填写不正确');
	                    return false;
	                }else{
	                   var mobileexp = /^1\d{10}$/;
	                    if(!mobileexp.test(mobPhone.trim())){
	                        layer.getChildFrame(".mobPhoneMsg").html('手机号填写不正确');
	                        return false;
	                    } else{
	                        layer.getChildFrame(".mobPhoneMsg").html('');                    
	                    }
		            }
	                if(address.trim()==''){
	                    layer.getChildFrame(".area_addressMsg").html('请填写详细地址');
	                    return false;
	                }else{
	                    layer.getChildFrame(".area_addressMsg").html('');
	                }
	                if(zipCode.trim()==''){
	                    layer.getChildFrame(".zipCodeMsg").html('请填写邮编');
	                    return false;
	                }else{
	                    layer.getChildFrame(".zipCodeMsg").html('');
	                }
	                var formjson = '{';
	                formjson += '\"trueName\":\"' + trueName + '\",';//分类id
	                formjson += '\"provinceId\":\"' + provinceId + '\",';//分类id
	                formjson += '\"cityId\":\"' + cityId + '\",';//城市id
	                formjson += '\"areaId\":\"' + areaId + '\",';//地区ID
	                formjson += '\"mobPhone\":\"' + mobPhone + '\",';//手机号
	                formjson += '\"areaInfo\":\"' + areaInfo + '\",';//地区全称
	                formjson += '\"address\":\"' + address + '\",';//详细地址
	                formjson += '\"zipCode\":\"' + zipCode + '\"';//邮编
	                formjson += '}';
	                $.ajax({
	                    url:'${base}/myaddress/saveAddress',
	                    type:'post',
//	                    data:{"trueName":trueName,"proviceId":proviceId,"cityId":cityId,"areaId":areaId,"mobPhone":mobPhone,"address":address,"zipCode":zipCode},
	                    data : {'data': formjson},
	                    dataType:'json',
	                    success:function(data){
	                        if(data.success){
	                            //删除原有的样式
			                   	$('.address_item').find('.goto').html('&nbsp;');
			                   	$('.address_item').removeClass('selected_address');
			                   	//插入新样式
			            	    var obj = data.data;
			            	    var html = "<ul class='receive_add address_item selected_address'>";
			            	    html += "<li class='goto'>寄送至</li>";
			            	    html += "<li address='"+obj.areaInfo+"&nbsp;&nbsp;"+obj.address+"' buyer='"+obj.trueName+"'>";
			                   	html += "<input id='address_"+obj.addressId+"' type='radio' city_id='"+obj.cityId+"' name='address_options' value='"+obj.addressId+"' checked/>";
			                   	html += "&nbsp;&nbsp;"+obj.areaInfo+"&nbsp;&nbsp;"+obj.address+"&nbsp;&nbsp;"+ obj.trueName+"&nbsp;&nbsp;"+obj.mobPhone;
			                   	html += "</li></ul>";
			                   	html += "<input type='hidden' id='chooseaddressid' name='chooseaddressid' value='"+obj.addressId+"'/>";
			                   	$("#addresslist").append(html);
			                   	
			             		var city = $("input[name='address_options']:checked");
					        	$('#confirm_address').html($(city).parent().attr('address'));
					        	$('#confirm_buyer').html($(city).parent().attr('buyer'));
			                   	layer.closeAll();
	                        }else{
	                            layer.msg('新增失败', {icon: 2});
	                        }
	                    },error:function(data){
	                         layer.msg('通信失败', {icon: 2});
	                    }
	                });
	                layer.close(index); //一般设定yes回调，必须进行手工关闭
	            },cancel: function(index){
	                layer.close(index);
	            }
	        });
	 	}
	function getTransport(){
		//显示寄送至
        var _select = $('.selected_address').find('li').eq(1);
        $('#confirm_address').html($(_select).attr('address'));
        $('#confirm_buyer').html($(_select).attr('buyer'));
	}
	getTransport();   
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
