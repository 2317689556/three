<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/header.jsp"%>

<!-- 书写内容 -->
<script>
	$(function(){
		$("form").submit(function(){
			var activitiesName = $("#activitiesName");
			if(!activitiesName.val()){
				isError(activitiesName,"用户名不能为空")
				return false;
			}
			isOk(activitiesName,"用户名正确");
			var numActivities = $("#numActivities");
			var reg = /^[0-9]{1,}$/;
			var num = numActivities.val();
			if(!reg.test(num)){
				isError(numActivities,"请输入正确数字")
				return false;
			}
			isOk(numActivities,"数字正确");
			
			var startTime = $("#startTime");
			if(!startTime.val()){
				isError(startTime,"请输入正确开始时间")
				return false;
			}
			isOk(startTime,"正确的开始时间");
			
			var endTime = $("#endTime");
			if(!endTime.val()){
				
				isError(endTime,"请输入正确结束时间")
				return false;
				
			}
			isOk(endTime,"正确的结束时间");
			
			var form = new FormData($("#addPlan_form")[0]);
			$.ajax({
			    //几个参数需要注意一下
		        type: "post",//方法类型
		        dataType: "json",//预期服务器返回的数据类型
		        url: "${pageContext.request.contextPath}/sb/addPlan",//url
		        data:form,
		        processData:false,
		        contentType:false,
		        success: function (data) {
		        	confirm("预报数据成功请等待审核！！");
		        	
		        	location.href="${pageContext.request.contextPath}/sb/findPlan";
			        
		        },
		        error : function() {
		           	alert("请求失败！！！！");
		            
		        }
				    
			})
		})
		
		function isOk(obj,text){
			obj.parent().parent().removeClass("has-error");
			obj.parent().parent().addClass("has-success");
			obj.parent().next().children(":first").html(text);
			
		}
		function isError(obj,text){
			obj.parent().parent().removeClass("has-success");
			obj.parent().parent().addClass("has-error");
			obj.parent().next().children(":first").html(text);
			
		}
	})
</script>
<div class="container">
	<div class="row clearfix">
		<div class="col-md-10 column">
			<form class="form-horizontal" method="post" action="##" id="addPlan_form">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-3 control-label">计划名称：</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="activitiesName" name="activitiesName"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>	
				</div>
				<div class="form-group">
					 <label for="inputPassword3" class="col-sm-3 control-label">计划召开桌数：</label>
					<div class="col-sm-7">
						<input type="number" class="form-control" id="numActivities" name="numActivities"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					 <label for="inputPassword3" class="col-sm-3 control-label">开始时间：</label>
					<div class="col-sm-7">
						<input type="date" class="form-control" id="startTime" name="startTime"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					 <label for="inputPassword3" class="col-sm-3 control-label">结束时间：</label>
					<div class="col-sm-7">
						<input type="date" class="form-control" id="endTime" name="endTime"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-10">
						 <button id="addPlan" type="submit" class="btn btn-primary">提交</button>
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 <button id="addPlan" type="reset" class="btn btn-primary">重置</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<%@include file="../common/footer.jsp"%>
</body>
</html>
