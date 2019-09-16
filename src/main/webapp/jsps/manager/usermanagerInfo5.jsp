<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/header.jsp"%>

<!-- 书写内容 -->
<script type="text/javascript">
	$(function(){
		$("#changeSize").change(function(){
			
			var size = $("#changeSize").val();
			
			location.href="${pageContext.request.contextPath}/sb/findPlanOnAudit?pageSize="+size+" ";

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
		        	}
		        	
		        },
		        error : function() {
		            alert("邮件发送失败！！");
		            
		        }
		    });
			
		})
		
		
	})
	function btnup(id){
			
		$("#planId").attr("value",id);
			
	}
	
	
</script>
	
	<table class="table table-hover text-center table-striped" border="1">
	    <thead>
	    	<tr class='text-danger' style='border:none;'>
	    		<td>计划名称</td>
		    	<td>计划名称</td>
		    	<td>计划桌数</td>
		    	<td>开始时间</td>
		    	<td>结束时间</td>
		    	<td>录入时间</td>
		    	<td>审核状态</td>
		    	<td>审核</td>
		    	<td>操作</td>
	    	</tr>
	   </thead>
	   <tbody>
	   <c:forEach items="${auditPlan.getList()}" var="p">
			<tr>
				<td>${p.deptName}</td>
				<td>${p.activitiesName}</td>
				<td>${p.numActivities }</td>
				<td><fmt:formatDate value="${p.startTime }" pattern="yyyy-MM-dd"/></td>
				<td><fmt:formatDate value="${p.endTime }" pattern="yyyy-MM-dd"/></td>
				<td><fmt:formatDate value="${p.timestamp}" pattern="yyyy-MM-dd"/></td>
				<td>
					<c:if test='${p.available ==1 }'>未审核</c:if>
					<c:if test='${p.available ==2 }'>已审核</c:if>
					<c:if test='${p.available ==3 }'>未通过</c:if>
				</td>
				<td>
					<a href="${pageContext.request.contextPath}/manager/upPlanAvailable?planId=${p.id }&available=2" 
						type="button" class="btn btn-primary <c:if test='${p.available ==2 }'>disabled</c:if>" onclick="return confirm('是否通过该计划');">通过
					</a>
					<a href="${pageContext.request.contextPath}/manager/upPlanAvailable?planId=${p.id }&available=3" 
						type="button" class="btn btn-primary <c:if test='${p.available ==2 || p.available ==3}'>disabled</c:if>" >不通过
					</a>
				</td>
				<td>
					<a href="##" class="btn btn-primary <c:if test='${p.available ==2 }'>disabled</c:if>" onclick="return confirm('是否删除该计划');">删除</a>
					<a onclick="btnup('${p.id }')" class="btn btn-primary" data-toggle="modal" data-target="#myModal">发送邮件</a>
				</td>
			</tr>
		</c:forEach>
	   </tbody>
	</table>

<div class="container" align="center">
	<div class="row">
		<div class="col-md-2">
			 <select class="form-control" id="changeSize">
		      	<option value="3" <c:if test='${pageSize ==3 }'>selected="selected"</c:if> >每页显示3条数据</option>
		      	<option value="5" <c:if test='${pageSize ==5}'>selected="selected"</c:if> >每页显示5条数据</option>
			    <option value="10" <c:if test='${pageSize ==10 }'>selected="selected"</c:if> >每页显示10条数据</option>
			    <option value="20" <c:if test='${pageSize ==20 }'>selected="selected"</c:if> >每页显示20条数据</option>
		   	</select>
		</div>  
		<div class="col-md-9">	
			<ul class="pagination">
				<li><a
					href="${pageContext.request.contextPath}/sb/findPlanOnAudit?pageNum=1">&laquo;</a></li>
				<c:if test="${auditPlan.pageNum>1 }">
					<li><a
						href="${pageContext.request.contextPath}/sb/findPlanOnAudit?pageNum=${auditPlan.pageNum-1}">上一页</a></li>
				</c:if>
				
				<c:forEach begin="1" step="1" end="${auditPlan.pages }" var="n">
					<li><a
						href="${pageContext.request.contextPath}/sb/findPlanOnAudit?pageNum=${n}">${n }</a></li>
				</c:forEach>
				
				<c:if test="${auditPlan.pageNum<auditPlan.pages }">
					<li><a
						href="${pageContext.request.contextPath}/sb/findPlanOnAudit?pageNum=${auditPlan.pageNum+1}">下一页</a></li>
				</c:if>
				<li><a
					href="${pageContext.request.contextPath}/sb/findPlanOnAudit?pageNum=${auditPlan.pages}">&raquo;</a></li>
			</ul>
		</div>
	</div>	
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
						<input type="hidden" id="planId" name='id'/>
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
						<textarea style="margin: 0px 35px 0px 0px; height: 100px; width: 380px;" rows="30" cols="4" class="form-control" id="message" name="message"></textarea>
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
