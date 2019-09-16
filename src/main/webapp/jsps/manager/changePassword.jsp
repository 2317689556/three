<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/header.jsp"%>

<!-- 书写内容 -->

<script type="text/javascript">

	function getMsg(){
		var num = $("#iPhone").val();
		var form = new FormData($("#updatepwd_form")[0]);
		if(checkMobile(num)){
			$.ajax({
			    //几个参数需要注意一下
		        type: "post",//方法类型
		        dataType: "json",//预期服务器返回的数据类型
		        traditional:true,//这使json格式的字符不会被转码
		        url:"${pageContext.request.contextPath }/user/telyanzheng",//url
		        data:form,
		        processData:false,
		        contentType:false,
		        success: function (data) {
		        	if(data){
						alert("验证码发送成功，请留意手机！！！");
		        	}
		        },
		        error : function() {
		        	alert("验证码发送失败请稍后再试");
		        }
			});
		}else{
			alert("手机号码不正确");
		}
	}
	
	function xia(){
		var form = new FormData($("#updatepwd_form")[0]);
		$.ajax({
		    //几个参数需要注意一下
	        type: "post",//方法类型
	        dataType: "json",//预期服务器返回的数据类型
	        traditional:true,//这使json格式的字符不会被转码
	        url:"${pageContext.request.contextPath }/user/yanzheng",//url
	        data:form,
	        processData:false,
	        contentType:false,
	        success: function (data) {
	        	if(data){
	        		location.href="${pageContext.request.contextPath}/jsps/manager/changePassword2.jsp";
				}else{
					$("#span01").html("验证码输入有误,请重新输入");
				}
	        },
	        error : function() {
	        	alert("失败！！");
	        }
		});
	}
	
	
	function checkMobile(phone){ 
		 if(!(/^1[3|4|5|8|9][0-9]\d{4,8}$/.test(phone))){
		  alert("不是完整的11位手机号或者正确的手机号前七位"); 
		  document.mobileform.mobile.focus(); 
		  return false; 
		 }
		 return true;
	}

</script>

<div class="container">
	<div class="row clearfix">
		<div class="col-md-8 column">
			<p class="h3 text-center">验证手机号</p>
			<form class="form-horizontal" id="updatepwd_form">
				<div class="form-group">
					 <label for="iPhone" class="col-sm-2 control-label">手机号</label>
					<div class="col-sm-7">
						<input type="text" name="tel" id="iPhone" readonly="readonly" class="form-control" value="${USER_SESSION.tel}"/>
					</div>
					
					<div class="col-sm-3">
						<button class="btn btn-primary" onclick="getMsg()">点击验证</button>
					</div>
				</div>
				<div class="form-group">
					<label for="phoneText" class="col-sm-2 control-label">验证码</label>
					<div class="col-sm-7">
						<input type="text" name="phoneText" class="form-control" id="phoneText" />
					</div>
					<div class="col-sm-3">
						<span id="span01"></span>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-5 col-sm-10">
						 <button type="button" class="btn btn-primary" onclick="xia()">下一步</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<%@include file="../common/footer.jsp"%>
</body>
</html>
