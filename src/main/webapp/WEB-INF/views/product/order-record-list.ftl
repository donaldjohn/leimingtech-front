<div class="title hd">
     <h4 class="tooltip">销售记录</h4>
</div>
<div class="content bd" id="ncGoodsTraded">
  <div id="" class="">
  <#if orderRecordList?size gt 0>
	  	<table width="977px"  border="1"  class="tables" >
		 <tr style="background-color:#FAFAFA;" class="produ_tab">
		   <td width="205"><div align="center"><strong>用户</strong></div></td>
		   <td width="287"><div align="center"><strong>采购内容</strong></div></td>
		   <td width="366"><div align="center"><strong>交易状态</strong></div></td>
		   <td width="366"><div align="center"><strong>采购时间</strong></div></td>
		 </tr>
		  <#list orderRecordList as orl>  
		  <tr class="produ_tab">
		    <td><div align="center">${orl.buyerName}</div></td>
			<td><div align="center">${orl.goodsName}</div></td>
			  <td>
				  <div align="center">
				      	<#if orl.orderState==10>等待卖家确认</#if>
						<#if orl.orderState==20>等待买家付款</#if>
						<#if orl.orderState==30>订单执行中</#if>
						<#if orl.orderState==40>交易完成</#if>
						<#if orl.orderState==0>买家取消</#if>
				  </div>	
			  </td>
		  	  <td><div align="center">${orl.createTimeStr?string('yyyy-MM-dd')}</div></td>
		  </tr>
		  </#list>
		</table>
	<#else>
		<tr>
			暂无记录!
		</tr>  
	</#if>
   </div>
 </div>