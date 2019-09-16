<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/header.jsp"%>

<script type="text/javascript">

	$(function(){
		$("#oldpassword").change(function(){
			
			var oldpassword = $("#oldpassword");
			$.ajax({
	            type: "post",
	            url:"${pageContext.request.contextPath }/user/pwdmodify",
	            data: {oldpassword: oldpassword.val()},
	            dataType: "json",
	            success: function (data) {
	                if (data) {//旧密码正确
	                	isOk(oldpassword,"旧密码输入正确");
	                } else {//旧密码输入不正确
	                	isError(oldpassword,"原密码输入不正确");
	                }
	            },
	            error: function () {
	                //请求出错
	               alert("请求出错");
	            }
	        });
			
		})
	})
	

	function upPWD(){
		var oldpassword = $("#oldpassword");
		if(oldpassword.parent().next().children(":first").html() != "旧密码输入正确"){
			return false;
		}
		
		var newpassword = $("#newpassword");
		if(!newpassword.val()){
			isError(newpassword,"新密码不能为空")
			return false;
		}
		isOk(newpassword,"新密码正确");
		
		var rnewpassword = $("#rnewpassword");
		if(!rnewpassword.val()){
			isError(rnewpassword,"确认密码不能为空")
			return false;
		}
		if(rnewpassword.val() != newpassword.val()){
			isError(rnewpassword,"两次密码不一致")
			return false;
		}
		isOk(rnewpassword,"密码正确");
		
		$.ajax({
		    //几个参数需要注意一下
	        type: "post",//方法类型
	        dataType: "json",//预期服务器返回的数据类型
	        url:"${pageContext.request.contextPath }/user/upPwd",//url
	        data:{"passWord":newpassword.val()},
	        success: function (data) {
	        	if(data){
	        		alert("修改密码成功，请重新登录！！！");
	        		top.location.href ="${pageContext.request.contextPath }/jsps/login.jsp"
	        	}
	        },
	        error : function() {
	        	alert("修改密码失败！！！");
	        }
		});
	}
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
</script>
<div class="container">
	<div class="row clearfix">
	<div class="col-md-8 column">
	    <div class="providerAdd">
	    	<span>${pwderror}</span>
	        <form id="userForm" name="userForm" method="post" action="${pageContext.request.contextPath }/user/savepwd">
	            <!--div的class 为error是验证错误，ok是验证成功-->
	            <div class="info">${message}</div>
	            <div class="form-group">
	                <label for="oldPassword" class="col-sm-2 control-label">旧密码：</label>
	                <div class="col-sm-7">
		                <input type="password" class="form-control" name="oldpassword" id="oldpassword" value="">
		            </div>   
		            <div class="col-sm-3">
		                <span></span>
		            </div>
	            </div>
	            <div class="form-group">
					<label for="newPassword" class="col-sm-2 control-label">新密码</label>
					<div class="col-sm-7">
						<input type="password" name="passWord" class="form-control" id="newpassword" />
					</div>
					<div class="col-sm-3">
		               	<span></span>
		            </div>
						
				</div>
	            <div class="form-group">
	                <label for="reNewPassword" class="col-sm-2 control-label">确认新密码：</label>
	                <div class="col-sm-7">
		                <input type="password" name="rnewpassword" class="form-control" id="rnewpassword" value="">
		                
	                </div>
	                <div class="col-sm-3">
		               	<span></span>
		            </div>
	            </div>
	            <div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						 <button type="button" class="btn btn-primary" onclick="upPWD()">提交</button>
					</div>
				</div>
	        </form>
	    </div>
</div>
</div>
</div>
<%@include file="../common/footer.jsp"%>
</body>
</html>
