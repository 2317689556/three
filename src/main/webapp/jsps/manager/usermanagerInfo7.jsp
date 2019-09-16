<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/header.jsp"%>

<!-- 书写内容 -->
<script type="text/javascript">
	$(function(){
		$("#excelOutData").click(function(){
			var startTime = $("#startTime").val().toString();
			var endTime = $("#endTime").val().toString();
			$.ajax({
			    //几个参数需要注意一下
		        type: "post",//方法类型
		        dataType: "json",//预期服务器返回的数据类型
		        url: "${pageContext.request.contextPath }/zTree/excelOutData",//url
		        data:{startTime:startTime,endTime:endTime},
		        success: function (data) {
		        	
		        	alert("导出成功！！！");
		        	
		        },
		        error : function() {
		        	
		         	alert("导出失败！！！");
		            
		        }
			});
		})
	})

	function size_nav(form, number) {
		
	    form.pageSize.value = number;
	    
	    form.submit();
	    
	}
	
	function page_nav(form, number) {
		
		var size = $("#changeSize").val();
		
		form.pageSize.value = size;
		
	    form.pageNum.value = number;
	    
	    form.submit();
	    
	}
	
</script>
<div class="container" align="center">
	<div class="row">
	<form action="${pageContext.request.contextPath}/zTree/findItems">
		开始时间：<input type="date" id="startTime" name="startTime" value="${startTime}" style="border:none;"/>
		结束时间：<input type="date" id="endTime" name="endTime" value="${endTime}" style="border:none;"/>
		<input type="submit" class="btn btn-primary" value="搜索">
		
		<input type="hidden" name="pageNum" value="1"/>
		<input type="hidden" name="pageSize" value="3"/>
		<c:if test="${USER_SESSION.level==1 }">
			<a href="${pageContext.request.contextPath}/jsps/manager/usermanagerInfo9.jsp" 
				type="button" class="btn btn-primary" >统计图
			</a>
		</c:if>
		<c:if test="${USER_SESSION.level==2 || USER_SESSION.level==4 }">
			<a href="${pageContext.request.contextPath}/jsps/manager/usermanagerInfo_10.jsp" 
				type="button" class="btn btn-primary" >统计图
			</a>
		</c:if>
		<a href="##" 
			type="button" class="btn btn-primary" id="excelOutData">导出数据 
		</a>
	</form>
	</div>
</div>	
<table class="table table-hover text-center table-striped" border="1">
    <thead>
    	<tr class='text-danger' style='border:none;'>
	    	<td>机构名称</td>
	    	<td>计划召开桌数</td>
	    	<td>实际召开桌数</td>
	    	<td>执行率</td>
	    	<td>新客户</td>
	    	<td>旧客户</td>
	    	<td>意向客户</td>
	    	<td>预估保费</td>
    	</tr>
   </thead>
   <tbody>
   <c:forEach items="${auditItems.getList()}" var="items">
		<tr>
			<td>${items.deptName}</td>
			<td>${items.numActivities}</td>
			<td>${items.numActual}</td>
			<td><fmt:formatNumber value="${items.numActual/items.numActivities}" type="percent" /></td>
			<td>${items.newClient}</td>
			<td>${items.oldClient}</td>
			<td>${items.yxClient}</td>
			<td>${items.money}</td>
		</tr>
	</c:forEach>
   </tbody>
</table>

<div class="container" align="center">
	<div class="row">
		<div class="col-md-2">
			 <select class="form-control" id="changeSize" onchange="size_nav(document.forms[0],this.value)">
		      	<option value="3" <c:if test='${pageSize ==3 }'>selected="selected"</c:if> >每页显示3条数据</option>
		      	<option value="5" <c:if test='${pageSize ==5 }'>selected="selected"</c:if> >每页显示5条数据</option>
			    <option value="10" <c:if test='${pageSize ==10 }'>selected="selected"</c:if> >每页显示10条数据</option>
			    <option value="20" <c:if test='${pageSize ==20 }'>selected="selected"</c:if> >每页显示20条数据</option>
		   	</select>
		</div>  
		<div class="col-md-9">	
			<ul class="pagination">
				<li><a
					href="javascript:page_nav(document.forms[0],1);">&laquo;</a></li>
				<c:if test="${auditItems.pageNum>1 }">
					<li><a
						href="javascript:page_nav(document.forms[0],${auditItems.pageNum-1});">上一页</a></li>
				</c:if>
				
				<c:forEach begin="1" step="1" end="${auditItems.pages }" var="n">
					<li><a
						href="javascript:page_nav(document.forms[0],${n});">${n }</a></li>
				</c:forEach>
				
				<c:if test="${auditItems.pageNum < auditItems.pages }">
					<li><a
						href="javascript:page_nav(document.forms[0],${auditItems.pageNum+1});">下一页</a></li>
				</c:if>
				<li><a
					href="javascript:page_nav(document.forms[0],${auditItems.pages});">&raquo;</a></li>
			</ul>
		</div>
	</div>	
</div>
<%@include file="../common/footer.jsp"%>
</body>
</html>
