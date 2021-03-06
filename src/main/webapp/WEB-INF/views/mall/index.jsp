<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<div class="order-title stretch">
		<div class="title-text col-xs-3 padding-collapse">订单管理</div>
	</div>
	<div class="panel panel-default col-xs-11 stretch panel-h-align border-none">
		<form class="form-horizontal" action="" id="search_form" target="_self" search_path="/mallOrder/list.htmls">
<!-- ############################################################################################## -->
		<div class="panel-body stretch">
            <div class="input-group col-xs-6 pull-left">
                <span class="input-group-addon">订单编号</span>
                <input type="hidden" name="page_size" id="page_size">
                <input type="hidden" name="page_number" id="page_number">
                <input class="form-control" type="text" name="order_code" id="order_code" placeholder="请输入订单编号">
            </div>
            <select name="order_status" class="drop-btn width-200 select-choose form-control ml-8 pull-left"  >
               <option value="">查看全部 </option>
               <option value="1">待付款</option>
               <option value="2">未取票</option>
               <option value="3">已取消</option>
               <option value="4">已退款</option>
               <option value="5">已取票</option>
            </select> 
            <div class="col-xs-1">
                <button class="btn btn-primary bg-theme border-theme pull-left" type="submit">搜索</button>
            </div>
            	<span style="font-family: 黑体">订单总数：</span>
               <input  type="text" name="order_count" id="order_count" readonly="readonly" size="8"  style='border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;font-size:200%;font-family:黑体 ' > 
               <span style="font-family: 黑体">订单总额：</span>
               <input  type="text" name="sum_price" id="sum_price" readonly="readonly" size="7" style='border-left:0px;border-top:0px;border-right:0px;border-bottom:1px; font-size:200% ;font-family:黑体 '><span style="font-family: 黑体">元</span>
       	</div>
<!-- ############################################################################################## -->
<!-- 			
			<div class="panel-body stretch">
				<div class="input-group col-xs-6 pull-left">
					<span class="input-group-addon">订单编号</span>
					<input type="hidden" name="page_size" id="page_size">
                    <input type="hidden" name="page_number" id="page_number">
					<input class="form-control" type="text" name="order_code" id="search-input" placeholder="请输入订单编号">						
                </div>
                <div class="col-xs-1">
					<button type="submit" class="btn btn-primary btn-theme-bg pull-left">搜索</button>
				</div>
			</div> -->
			
		</form>
	</div>
	<div class="panel panel-default col-xs-11 stretch panel-h-align scroll-auto">
		
		<table class="table table-hover table-striped table-align">	
			<caption class="title">						
				<div class="title-text col-xs-4 indent-collapse">订单列表</div>
				<!-- <a href="#/competition/insert" class="btn btn-primary bg-theme border-theme pull-right indent-collapse btn-fix" id="btn_save_load">录入</a>		 -->				
			</caption>
			<thead>	
				<tr>
				    <th>序号</th>
                    <th>订单编号</th>
                    <th>商品价格</th>
                    <th>订单状态</th>
                    <th>用户名</th>
                    <th>下单时间</th>
                    
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			 
			</tbody>
		</table>
	</div>
	<div class="display-align cad-page">
	
	</div>
		<div class="modal fade in" id="detail-modal">
		    <div class="modal-dialog">
		      <div class="modal-content">		
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal"><span>×</span></button>
		          <h3 class="modal-title">订单详情</h3>
		        </div>
		        <div class="modal-body container-fluid" id="view-detail">
					<ul class="media-list">
					  <li class="media">
					    <div class="media-left">
					      
					        <img class="media-object" src="" alt="加载失败">
					     
					    </div>
					    <div class="media-body">
					      <h4 class="media-heading"></h4>
					      ...
					    </div>
					  </li>
					</ul>
	           	</div>
	            <div class="modal-footer">
        	   	   <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      		    </div>
	        </div>
	      </div>
	    </div>
	    
 	
	<script type="text/javascript">
	cadleo_data('/mallOrder/list.htmls');
	function showData(data){
		$('.cad-page').html(data.data.pageString);
		var data = data.data.result;
		window.JSONdata = data;
		var trs='';
		for(var i in data){
			var tds='<tr>';
			tds += "<td>"+(Number(i)+1)+"</td>";
			tds += "<td>"+(data[i].order_code||'')+"</td>";
			tds += "<td>"+(data[i].price||'')+'&nbsp;&nbsp;¥'+"</td>";
			tds += "<td>"+(data[i].status_name||'')+"</td>";
			tds += "<td>"+(data[i].user_login_name||'')+"</td>";
			tds += "<td>"+(data[i].create_time||'')+"</td>";
			
			tds += "<td class='text-ellipsis'>\
						<a href='#detail-modal' data-view-path='/mallOrder/detail.htmls?order_code="+data[i].order_code+"' class='fa fa-eye wj_detail_data' data-view-id='"+ i +"' title='查看详情'></a>\</td>";
			tds += '</tr>';
			trs += tds;
		}
		$('table.table-align tbody').html(trs);
	}

	
	function showDetail(data){

		var str = '';
		for(var i = 0; i < data.length ; i++){
			str += '<ul class="media-list">\
						<li class="media">\
							<div class="media-left">\
								<img class="media-object" src="'+ data[i].picture_url +'" height="84" width="84" alt="加载失败">\
							</div>\
							<div class="media-body">\
								<h4 class="media-heading">'+ data[i].name +'</h4>\
								<div>总票数：'+ data[i].total_counts +'张</div>\
								<div>有效票数：'+ data[i].effect_counts +'张</div>\
								<div>票单价：'+ data[i].single_price +'元</div>\
							</div>\
						</li>\
					</ul>';
		}
		$('#view-detail').html(str);
	}

	$('table.table-align tbody').on('click','.wj_detail_data',function(e){
		e.preventDefault();
		$.get(url + $(this).attr('data-view-path'),function(data){
			if(data.code == 0 ){
				sessionStorage.setItem('order_data',encodeURIComponent(JSON.stringify(data.data)));
				$('#detail-modal').modal('show');				
			} else {
				alert(data.message);
			}
		})
		.fail(internal_error);
	});
	$('#detail-modal').on('show.bs.modal', function (event) {
		var data = JSON.parse(decodeURIComponent(sessionStorage.getItem('order_data')));
		showDetail(data);
	});
	
	//请求获取订单总额和订单总数
 	$.post(
		 "mallOrder/sumprice.htmls",
		null,
		function(data){
			$("#order_count").val(data.data.order_count);
			$("#sum_price").val(data.data.sum_price);
		}) 
	
	</script>
