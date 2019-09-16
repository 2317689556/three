<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/header.jsp"%>

<!-- 书写内容 -->

<script type="text/javascript">
	var setting = {
		async:{
			enable: true,
			url:"${pageContext.request.contextPath }/zTree/findAllDept",
			autoParam:["id"],
		},
		data:{
			simpleData: {
				enable: true,
				idKey: "id",//节点数据中保存唯一标识的属性名称  默认值为id
              	pIdKey: "pid",//节点数据中保存其父节点唯一标识的属性名称 默认值为pid
                rootPId: 0 //用于修正根节点父节点数据 默认值：null
			}
		},
		callback: {
			beforeClick: beforeClick
		}
	};
	
	var zNodes =[];
	
	function beforeClick(treeId, treeNode, clickFlag) {
		var id = treeNode.id;
		var isParent = treeNode.isParent;
		$.ajax({
			type:"post",
			url:"${pageContext.request.contextPath }/zTree/findUserInfo",
			data:{id:id,isParent:isParent},
			dataType:"json",
			success:function(data){
				
				$("#userInfo").children().remove();
				
				for(var i=0; i< data.length;i++){
					$("#userInfo").append("<tr class='text-danger' id='"+data[i].id+"_info' style='border:none;'><td>"+data[i].username+"</td><td>"
							+data[i].usercode+"</td><td>"+data[i].level+"</td><td>"
							+"<button class='btn btn-info' onClick='modifyUser("+data[i].id+")'>修改用户</button>"
							+"<button class='btn btn-info' onClick='deleteUser("+data[i].id+")'>删除用户</button></td></tr>");
					
					$("#addlevel").val(data[i].level);
					$("#adddeptId").val(data[i].deptId);
					$("#addareaId").val(data[i].areaId);
				}
				
				
				
			},
			error:function(msg){
				alert("请求失败");
			}
		});
	}
	function addUser(){
		var addusername = $("#addusername");
		if(!addusername.val()){
			isError(addusername,"用户名不能为空");
			return false;
		}
		isOk(addusername,"用户名正确");
		
		var addusercode = $("#addusercode");
		if(!addusercode.val()){
			isError(addusercode,"用户编码不能为空");
			return false;
		}
		isOk(addusercode,"用户编码正确");
		
		var addpassword = $("#addpassword");
		if(!addpassword.val()){
			isError(addpassword,"用户密码不能为空");
			return false;
		}
		isOk(addpassword,"用户密码正确");
		
		var addemail = $("#addemail");
		var reg=/^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
		var num = addemail.val();
		if(!reg.test(num)){
			isError(addemail,"请输入正确邮箱");
			return false;
		}
		
		isOk(addemail,"邮箱正确");
		
		var addtel = $("#addtel");
		var reg=/^1[3-9][0-9]{9}$/;
		var num = addtel.val();
		if(!reg.test(num)){
			isError(addtel,"请输入手机号码");
			return false;
		}
		isOk(addtel,"手机号码正确");
		
		
		var form = new FormData($("#adduser")[0]);
		
		$.ajax({
		    //几个参数需要注意一下
	        type: "post",//方法类型
	        dataType: "json",//预期服务器返回的数据类型
	        url: "${pageContext.request.contextPath}/user/addUser",//url
	        data:form,
	        processData:false,
	        contentType:false,
	        success: function (data) {
	        	
	        	$("#myModalAdd").modal("hide");
	        	alert("添加成功");
		        
	        	
	        },
	        error : function() {
	           	alert("请求失败！！！！");
	            
	        }
			    
		})
	}
	
	
	
	function modifyUser(id){
		$.ajax({
			type:"post",
			url:"${pageContext.request.contextPath}/user/findUserById",	
			data:{"id":id},
			dataType:"json",
			success:function(data){
				
				$("#myModalUpdate").modal("show");
				$("#updateuserid").val(data.id);
				$("#updateusername").val(data.username);
				$("#updateusercode").val(data.usercode);
				$("#updatepassword").val(data.password);
				if(data.sex == 1){
					$("input:radio[value='1']").attr('checked', 'checked');
				}else{
					$("input:radio[value='2']").attr('checked', 'checked');
				}
				$("#updatetel").val(data.tel);
				$("#updateemail").val(data.email);
				
			},
			error:function(msg){
				
			}
		});
	}
	
	function updateUser(){
		
		var updateusername = $("#updateusername");
		if(!updateusername.val()){
			isError(updateusername,"用户名不能为空");
			return false;
		}
		isOk(updateusername,"用户名正确");
		
		var updateusercode = $("#updateusercode");
		if(!updateusercode.val()){
			isError(updateusercode,"用户编码不能为空");
			return false;
		}
		isOk(updateusercode,"用户编码正确");
		
		var updatepassword = $("#updatepassword");
		if(!updatepassword.val()){
			isError(updatepassword,"用户密码不能为空");
			return false;
		}
		isOk(updatepassword,"用户密码正确");
		
		var updateemail = $("#updateemail");
		var reg=/^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
		var num = updateemail.val();
		if(!reg.test(num)){
			isError(updateemail,"请输入正确邮箱");
			return false;
		}
		
		isOk(updateemail,"邮箱正确");
		var updatetel = $("#updatetel");
		var reg=/^1[3-9][0-9]{9}$/;
		var num = updatetel.val();
		if(!reg.test(num)){
			isError(updatetel,"请输入手机号码");
			return false;
		}
		isOk(updatetel,"手机号码正确");
		
		
		var form = new FormData($("#updateUser")[0]);
		
		$.ajax({
		    //几个参数需要注意一下
	        type: "post",//方法类型
	        dataType: "json",//预期服务器返回的数据类型
	        url: "${pageContext.request.contextPath}/user/updateUser",//url
	        data:form,
	        processData:false,
	        contentType:false,
	        success: function (data) {
	        	
	        	$("#myModalUpdate").modal("hide");
	        	alert("修改成功");
		        
	        },
	        error : function() {
	           	alert("请求失败！！！！");
	            
	        }
			    
		})
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
	function deleteUser(id){
		if(confirm("确定要删除数据吗")){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/user/delUser",	
				data:{"id":id},
				dataType:"json",
				success:function(data){
					
					alert("删除成功");
					
					var deleteId = "#"+id+"_info";
					
					$(deleteId).remove();
					
				},
				error:function(msg){

				}
			});
		}
		
	}
	
	$(function(){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/zTree/findAllUser",
				data:{},
				dataType:"json",
				success:function(data){
					
					zNodes=data;
					
					$.fn.zTree.init($("#treeDemo"), setting, zNodes);
					
				},
				error:function(msg){
					
				}
			});
			
		})
		
</script>

	<style type="text/css">
		.ztree li span.button.add {
					margin-left:2px; 
					margin-right: -1px; 
					background-position:-144px 0; 
					vertical-align:top; 
					*vertical-align:middle
				}
	</style>

<div id="container" style="height: 700px; margin: 0">
	<div class="row">
	
		<div class="col-md-3">

			<div class="zTreeDemoBackground left" onclick="">
	
				<ul id="treeDemo" class="ztree"></ul>
		
			</div>
	
		</div>
		
		<div class="col-md-9">
			<table class="table h4 text-center table-striped table-hover">
				<caption class="h2 text-center">用户信息</caption>
				<thead>
		    	<tr class='text-danger' style='border:none;'>
			    	<td>地区名称</td>
			    	<td>账号</td>
			    	<td>级别</td>
			    	<td>操作</td>
		    	</tr>
  			 	</thead>
			   	<tbody id="userInfo">
					
			   	</tbody>
			</table>
		</div>
		
	</div>
	
	<button class='btn btn-info' data-toggle='modal' data-target='#myModalAdd'>添加用户</button>
	
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModalUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改用户</h4>
            </div>
            <div class="modal-body">
            	<form class="form-horizontal" role="updateForm" action="##" id="updateUser">
				<div class="form-group">
					<div class="col-sm-7" id="div01">
						<input type="hidden" id="updateuserid" name='id'/>
					</div>
				</div>
				<div class="form-group">
					<label for="activitiesName" class="col-sm-3 control-label">名称</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="updateusername" name="username"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>	
				</div>
				
				<div class="form-group">
					 <label for="numActivities" class="col-sm-3 control-label">编码</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="updateusercode" name="usercode"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					 <label for="numActivities" class="col-sm-3 control-label">密码</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="updatepassword" name="password"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					 <label for="numActivities" class="col-sm-3 control-label">性别</label>
					<div class="col-sm-7">
						<input style="margin-left:10px"  name="updatesex" type="radio" value="1"/>男 
						<input style="margin-left:10px"  name="updatesex" type="radio" value="2"/>女
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					<label for="numActivities" class="col-sm-3 control-label">邮箱</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="updateemail" name="email"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					 <label for="numActivities" class="col-sm-3 control-label">电话</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="updatetel" name="tel"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-10">
						 <button id="sendMail" type="button" onclick="updateUser()" class="btn btn-primary">提交</button>
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 <button type="reset" class="btn btn-primary">重置</button>
					</div>
				</div>
			</form>
            </div>
        </div>
    </div>
</div>	
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModalAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加用户</h4>
            </div>
            <div class="modal-body">
            	<form class="form-horizontal" role="form" action="##" id="adduser">
				<div class="form-group">
					<div class="col-sm-7" id="div01">
						<input type="hidden" id="addlevel" name='level'/>
						<input type="hidden" id="adddeptId" name='deptId'/>
						<input type="hidden" id="addareaId" name='areaId'/>
					</div>
				</div>
				<div class="form-group">
					<label for="activitiesName" class="col-sm-3 control-label">名称</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="addusername" name="username"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>	
				</div>
				
				<div class="form-group">
					 <label for="numActivities" class="col-sm-3 control-label">编码</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="addusercode" name="usercode"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					 <label for="numActivities" class="col-sm-3 control-label">密码</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="addpassword" name="password"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					 <label for="numActivities" class="col-sm-3 control-label">性别</label>
					<div class="col-sm-7">
						<input style="margin-left:10px"  name="sex" type="radio" value="1" checked="checked"/>男 
						<input style="margin-left:10px"  name="sex" type="radio" value="2"/>女
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					<label for="numActivities" class="col-sm-3 control-label">邮箱</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="addemail" name="email"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					 <label for="numActivities" class="col-sm-3 control-label">电话</label>
					<div class="col-sm-7">
						<input type="text" class="form-control" id="addtel" name="tel"/>
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-10">
						 <button id="sendMail" onclick="addUser()" type="button" class="btn btn-primary">提交</button>
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 <button type="reset" class="btn btn-primary">重置</button>
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
