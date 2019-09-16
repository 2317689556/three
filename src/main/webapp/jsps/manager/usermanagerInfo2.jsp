<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp"%>

<script type="text/javascript">
	$(function(){
		
		$("#select01").change(function(){
			
			var size = $("#select01").val();

			location.href="${pageContext.request.contextPath}/sb/findPlan?pageSize="+size+" ";
		
			
		})
		
		$("#updatePlan").click(function(){
			
			var form = new FormData($("#updatePlan_form")[0]);
	
		    $.ajax({
		    //几个参数需要注意一下
		        type: "post",//方法类型
		        dataType: "json",//预期服务器返回的数据类型
		        url: "${pageContext.request.contextPath }/manager/updatePlan",//url
		        data:form,
		        processData:false,
		        contentType:false,
		        success: function (data) {
		        	if(data){
		        		alert("修改成功！！");
		        		
		        		$('#myModal01').modal('hide');
		        		
		        		$('#myModal02').modal('show');
			        	
		        	}
		        	
		        	
		        },
		        error : function() {
		            alert("修改失败！！");
		            
		        }
		    });
			
		})
		$("#sendMail").click(function(){
			var form = new FormData($("#sendMail_form")[0]);
	
		    $.ajax({
		    //几个参数需要注意一下
		        type: "post",//方法类型
		        dataType: "json",//预期服务器返回的数据类型
		        url: "${pageContext.request.contextPath }/manager02/sendMail",//url
		        data:form,
		        processData:false,
		        contentType:false,
		        success: function (data) {
		        	if(data){
		        		alert("邮件发送成功！！");
		        		
		        		location.href="${pageContext.request.contextPath}/manager/findPlan?pageNum="+${p.pageNum}+" ";
		        	}
		        	
		        },
		        error : function() {
		            alert("邮件发送失败！！");
		            
		        }
		    });
			
		})
		
	})
	function btnup(id){
			
		$.ajax({
            type:"POST",//为post请求
            url:"${pageContext.request.contextPath}/sb/findPlanById02",//这是我在后台接受数据的文件名
            data:{planId:id},
            dateType:"json",
            error:function(data){//请求失败之后的操作
				 alert("失败")
            },
            success:function(data){//请求成功之后的操作
            	
            	var startTime = new Date(data.startTime).format("yyyy-MM-dd");;
            	var endTime = new Date(data.endTime).format("yyyy-MM-dd");;
            	
           		$("#planId").attr("value",id);
          	  	$("#activitiesName").attr("value",data.activitiesName);
           		$("#numActivities").attr("value",data.numActivities);
           		$("#startTime").attr("value",startTime);
           		$("#endTime").attr("value",endTime);
           		
           		
            }
        });
	}
	
</script>
	<table class="table table-hover text-center table-striped" border="1">
	    <thead>
	    	<tr class='text-danger' style='border:none;'>
		    	<td>计划名称</td>
		    	<td>计划桌数</td>
		    	<td>开始时间</td>
		    	<td>结束时间</td>
		    	<td>录入时间</td>
		    	<td>审核状态</td>
		    	<td>操作</td>
	    	</tr>
	   </thead>
	   <tbody>
		   <c:forEach items="${p.getList()}" var="p">
				<tr>
					<td>${p.activitiesName}</td>
					<td>${p.numActivities }</td>
					<td><fmt:formatDate value="${p.startTime }" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatDate value="${p.endTime }" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatDate value="${p.timestamp}" pattern="yyyy-MM-dd"/></td>
					<td>
						<c:if test='${p.available ==1 }'>未审核</c:if>
						<c:if test='${p.available ==2 }'>已通过</c:if>
						<c:if test='${p.available ==3 }'>未通过</c:if>
					</td>
					<td>
						<a onclick="btnup('${p.id }')" class="btn btn-primary <c:if test='${p.available != 3}'>disabled</c:if>" data-toggle="modal" data-target="#myModal01">修改</a>
						<a class="btn btn-primary <c:if test='${p.available !=2 }'>disabled</c:if>" href="${pageContext.request.contextPath}/manager/findPlanById?planId=${p.id }">上报实际数据</a>
					</td>
				</tr>
			</c:forEach>
	   </tbody>
	</table>
<div class="container" align="center">
	<div class="row">
		<div class="col-md-2">
			 <select class="form-control" id="select01">
		      	<option value="3" <c:if test='${pageSize ==3 }'>selected="selected"</c:if> >每页显示3条数据</option>
		      	<option value="5" <c:if test='${pageSize ==5 }'>selected="selected"</c:if> >每页显示5条数据</option>
			    <option value="10" <c:if test='${pageSize ==10 }'>selected="selected"</c:if> >每页显示10条数据</option>
			    <option value="20" <c:if test='${pageSize ==20 }'>selected="selected"</c:if> >每页显示20条数据</option>
		   	</select>
		</div>  
		<div class="col-md-9">	
			<ul class="pagination">
				<li><a
					href="${pageContext.request.contextPath}/sb/findPlan?pageNum=1">&laquo;</a></li>
				<c:if test="${p.pageNum>1 }">
					<li><a
						href="${pageContext.request.contextPath}/sb/findPlan?pageNum=${p.pageNum-1}">上一页</a></li>
				</c:if>
				
				<c:forEach begin="1" step="1" end="${p.pages }" var="n">
					<li><a
						href="${pageContext.request.contextPath}/sb/findPlan?pageNum=${n}">${n }</a></li>
				</c:forEach>
				
				<c:if test="${p.pageNum<p.pages }">
					<li><a
						href="${pageContext.request.contextPath}/sb/findPlan?pageNum=${p.pageNum+1}">下一页</a></li>
				</c:if>
				<li><a
					href="${pageContext.request.contextPath}/sb/findPlan?pageNum=${p.pages}">&raquo;</a></li>
			</ul>
		</div>
	</div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal01" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					修改计划
				</h4>
			</div>
			<form class="form-horizontal" role="form" action="##" id="updatePlan_form">
				<div class="form-group">
					<div class="col-sm-7" id="div01">
						<input type='hidden' id="planId" name='id'/>
					</div>
				</div>
				<div class="form-group">
					<label for="activitiesName" class="col-sm-3 control-label">计划名称：</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="activitiesName" name="activitiesName"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>	
				</div>
				
				<div class="form-group">
					 <label for="numActivities" class="col-sm-3 control-label">计划召开桌数：</label>
					<div class="col-sm-7">
						<input type="number" class="form-control" id="numActivities" name="numActivities"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					 <label for="startTime" class="col-sm-3 control-label">开始时间：</label>
					<div class="col-sm-7">
						<input type="date" class="form-control" id="startTime" name="startTime"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					 <label for="endTime" class="col-sm-3 control-label">结束时间：</label>
					<div class="col-sm-7">
						<input type="date" class="form-control" id="endTime" name="endTime"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-10">
						 <button id="updatePlan" type="button" class="btn btn-primary">提交</button>
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 <button type="reset" class="btn btn-primary">重置</button>
					</div>
				</div>
			</form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal02" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					修改计划
				</h4>
			</div>
			<form class="form-horizontal" role="form" action="##" id="sendMail_form">
				<div class="form-group">
					<div class="col-sm-7" id="div01">
						<input type='hidden' id="planId" name='id'/>
					</div>
				</div>
				<div class="form-group">
					<label for="activitiesName" class="col-sm-3 control-label">邮件主题：</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="subject" name="subject"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>	
				</div>
				
				<div class="form-group">
					 <label for="numActivities" class="col-sm-3 control-label">邮件内容：</label>
					<div class="col-sm-7">
						<textarea style="margin: 10px 35px 0px 10px; height: 100px; width: 335px;" rows="30" cols="4" class="form-control" id="message" name="message"></textarea>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-10">
						 <button id="sendMail" type="button" class="btn btn-primary">发送</button>
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 <button type="reset" class="btn btn-primary">重置</button>
					</div>
				</div>
			</form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
<%@include file="../common/footer.jsp"%>
</body>
</html>
