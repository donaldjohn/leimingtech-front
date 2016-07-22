<@p.userHeader title="我的地址－个人中心"/>
<script type="text/javascript" src="${base}/res/js/layer/layer.js"></script>
<div id="container" class="wrapper">
    <div class="layout">
        <@m.memberleft  title="收货地址"/>
        <div class="right-content">
            <div class="path">
                <div><a href="${base}">我的商城</a><span>&raquo;</span>
                    <a href="#"/>收货地址</a><span>&raquo;</span>地址列表
                </div>
            </div>
            <form id="acct-form" method="post" action="${base}/myaddress/index" name ="queryListForm">
                <input type="hidden" name="div" id="div" value = "#dataListDiv"/>
            </form>
            <!--列表替换地方-->
            <div class="main" id="dataListDiv">
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    /*界面初始化*/
    $(function(){
        initDataList();
    });

    /*初始化*/
    function initDataList(){
        $.ajax({
            async:false,
            url:"${base}/myaddress/list",//默认加载list 页面
            error:function(){
                layer.msg("通讯失败!" , 1 , 9 );
               /* frameControl.lhDgFalInfo("通讯失败!");*/
            },
            dataType:'html',
            type: "POST",
            contentType:"application/x-www-form-urlencoded; charset=utf-8",
            success: function(data){
                $("#dataListDiv").empty();
                $("#dataListDiv").html(data);
                $("#dataListDiv").hide();
                $("#dataListDiv").fadeIn(300);
            }
        });
    }
    
    
     /**准备删除*/
    function deleteAddress(id){
        var url = "${base}/myaddress/deleteAddress?id="+id;
        layer.confirm('确定删除?', function(){
            $.ajax({
                type: "post",
                url: url,
                data: null,
                dataType: "json",
                async:false,
                success:function(data) {
                    if(data.success == "true"){
                        layer.msg('删除成功', {icon: 1},initDataList());
                    }else{
                        layer.msg('删除失败', {icon: 2});
                    }
                }
            });
        });
    }
    /*修改地址*/
     function updateAddress(id) {
         layer.open({
             type: 2,
             move: false,
             shade: false,
             title: '修改地址',
             content: ['${base}/myaddress/updateAddress?id='+id, 'no'],
             area: ['550px', '330px']
         });
     }

    /*添加地址*/
    function addAddress(){
        layer.open({
            type:2,
            move: false,
            shade: false,
            title: '新增地址',
            //content: '${base}/myaddress/addAddress',
            content:['${base}/myaddress/addAddress', 'no'],
            //content:$('#fwin_my_address_add'),
            area: ['550px', '330px']
        });
    }
</script>
<@p.userfooter />
