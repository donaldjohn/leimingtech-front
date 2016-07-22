<link href="${base}/res/css/base.css" rel="stylesheet" type="text/css">
<link href="${base}/res/css/member.css" rel="stylesheet" type="text/css">
<link href="${base}/res/css/invoice.css" rel="stylesheet" type="text/css">
<script src="${base}/res/js/jquery.js" charset="utf-8"></script>
<script src="${base}/res/js/jquery.validation.min.js" charset="utf-8"></script>
<script src="${base}/res/js/area.js" charset="utf-8"></script>
<script type="text/javascript">
	var SITEURL = '${base}';
</script>
<div id="fwin_my_address_add" class="dialog_wrapper ui-draggable" style="z-index: 1100; position: absolute; width: 550px; top: 38px;">
    <div class="dialog_body" style="position: relative;">
        <div class="dialog_content" style="margin: 0px; padding: 0px;">
            <div class="eject_con">
                <div class="adds">
                    <div id="warning" style="display: none;">
                        <label for="true_name" generated="true" class="error">请填写收货人姓名</label>
                        <label for="area_id" generated="true" class="error">请选择所在地区</label>
                        <label for="address" generated="true" class="error">请填写详细地址</label>
                        <label for="phone" generated="true" class="error">固定电话和手机请至少填写一项.</label>
                    </div>
                    <form method="post" action="" id="address_form" target="_parent">
                        <input type="hidden" name="form_submit" value="ok">
                        <input type="hidden" name="addressId" id="addressId" value="${address.addressId}">
                        <dl>
                            <dt class="required"><em class="pngFix"></em>收货人：</dt>
                            <dd>
                                <p>
                                    <input type="text" class="text" id="trueName" name="trueName" value="${address.trueName}">
                                </p>
                            </dd>
                        </dl>
                        <dl>
                            <dt class="required"><em class="pngFix"></em>所在地区：</dt>
                            <dd>
                                <div id="region">
                                    <input id="city_id" type="hidden" name="city_id" value="${address.cityId}">
									<input id="area_id" class="area_ids" type="hidden" name="area_id" value="${address.areaId}">
									<input id="area_info" class="area_names" type="hidden" name="area_info" value="${address.areaInfo}">
                                    <span id="spanarea">
							        	<select name="area" class="select" id="area">
							           		<#if areas??>
							  					<#list areas as str>
							  						<option value="${str.areaId}">${str.areaName}</option>
							  					</#list>
											</#if>
						         		</select> 	
								    </span>
								    <span id="spancity"></span>
								    <span id="spanqu"></span>
								    <span class="areaMsg" style="color: red"></span>
                                </div>
                            </dd>
                        </dl>
                        <dl>
                            <dt class="required"><em class="pngFix"></em>街道地址：</dt>
                            <dd>
                                <p>
                                    <input class="text w300" type="text" name="address" id="address" value="${address.address}">
                                </p>
                            </dd>
                        </dl>
                        <dl>
                            <dt class="required"><em class="pngFix"></em>邮编：</dt>
                            <dd>
                                <input type="text" class="text valid" name="zipCode" id="zipCode" maxlength="6" value="${address.zipCode}">
                            </dd>
                        </dl>
                        <dl>
                            <dt class="required"><em class="pngFix"></em>手机号码：</dt>
                            <dd>
                                <input type="text" class="text" name="mobPhone" id="mobPhone" maxlength="11" value="${address.mobPhone}">
                            </dd>
                        </dl>
                        <dl>
                        	<dd>
                        		<a href="#none" class="btn-9" onclick="save_address()">保存</a>
								<a href="#none" class="btn-9 ml10" onclick="quxiao()">取消</a>
                            </dd>
                        </dl>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
	$(function(){
		addressValidate();
		init_area('${address.provinceId}','${address.cityId}','${address.areaId}');
	});
	
	jQuery.validator.addMethod("isZipCode",function(value,element){
		var pattern = /^[0-9]{6}$/; //邮编格式
		return this.optional(element) || (pattern.test(value));  
	},"请填写正确的邮编");
	
	jQuery.validator.addMethod("isMobPhone",function(value,element){
		var pattern = /^1\d{10}$/; //手机号格式
		return this.optional(element) || (pattern.test(value));  
	},"请填写正确的手机号");
	
	var addressValidate = function(){
		$('#address_form').validate({
		    errorPlacement: function(error, element){
		        $(element).next('.field_notice').hide();
		        $(element).after(error);
		    },
		    rules : {
		    	trueName : {
		    		required   : true
		    	},
		        mobPhone : {	
					required   : true,
					isMobPhone : true
		        },
		        address : {
		        	required   : true
		        },
		        zipCode : {
		        	required   : true,
		        	isZipCode  : true
		        }
		    },
		    messages : {
		    	trueName : {
		    		required   : '请填写您的真实姓名'
		    	},
		        mobPhone : {
					required : '请填写收货人手机',
					isMobPhone : '请填写正确的手机号'
		        },
		        address : {
		        	required   : '请填写地址'
		        },
		        zipCode : {
		        	required   : '请填写邮编',
		        	isZipCode  : '请填写正确的邮编'
		        }
		    }
		});
	}
	
	function quxiao(){
		parent.layer.closeAll();
	}
	
	function save_address(){
		if($('#address_form').valid()){
			var addressId = $('#addressId').val(); //收货地址id
            var provinceId = $('#area').val(); //省的id
            var cityId = $('#city').val(); //城市id
            var areaId = $('#qu').val(); //区的id
            var address = $('#address').val(); //具体地址
            var zipCode = $('#zipCode').val(); //具体地址
            var trueName = $('#trueName').val(); //收货人
            var mobPhone = $('#mobPhone').val(); //收货人手机号

            var provinceval = $('#area').find("option:selected").html(); //省的值
            var cityval = $('#city').find("option:selected").html(); //城市的值
            var areaInfo=provinceval+","+cityval;
            var quval = $('#qu').find("option:selected").html(); 	 //区的值
            //三级地区菜单没有的校验
			if(typeof(quval) != "undefined"){
				areaInfo=provinceval+","+cityval+","+quval;//保存到常用地址表
			}

			if(provinceId==''||provinceId=='0'){
             	$(".areaMsg").html('请选择省份');
             	return false;
         	}else{
            	$(".areaMsg").html('');
         	}
	         if(cityId==''||cityId=='0'){
	             $(".areaMsg").html('请选择城市');
	             return false;
	         }
	         if(areaId==''||areaId=='0'){
	             $(".areaMsg").html('请选择区');
	             return false;
	         }else{
	             $(".areaMsg").html('');
	         }
         
         	var formjson = '{';
            formjson += '\"addressId\":\"' + addressId + '\",';//收货地址id
            formjson += '\"trueName\":\"' + trueName + '\",';//分类id
            formjson += '\"provinceId\":\"' + provinceId + '\",';//省id
            formjson += '\"cityId\":\"' + cityId + '\",';//城市id
            //三级地区菜单没有的校验
			if(typeof(quval) != "undefined"){
				formjson += '\"areaId\":\"' + areaId + '\",';//地区ID
			}
            formjson += '\"mobPhone\":\"' + mobPhone + '\",';//手机号
            formjson += '\"areaInfo\":\"' + areaInfo + '\",';//地区全称
            formjson += '\"address\":\"' + address + '\",';//详细地址
            formjson += '\"zipCode\":\"' + zipCode + '\"';//邮编
            formjson += '}';
            $.ajax({
                 url: '${base}/myaddress/updateAds',
                 type: 'post',
                 data: {'data': formjson},
                 dataType: 'json',
                 success: function (data) {
                     if (data.success == 'true') {
                         parent.layer.msg('修改成功', {icon: 1}, parent.initDataList());
                     	 parent.layer.closeAll();
                     } else {
                         parent.layer.msg('修改失败', {icon: 2});
                     }
                 }, error: function (data) {
                     parent.layer.msg('通信失败', {icon: 2});
                 }
             });
		}
	}
</script>