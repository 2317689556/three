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
		view: {
			addHoverDom: addHoverDom,
			removeHoverDom: removeHoverDom,
			selectedMulti: false
		},
		edit: {
			enable: true,
			editNameSelectAll: true,
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
			beforeRemove: beforeRemove,
			beforeRename: beforeRename,
			
		}
	};
	
	var zNodes =[];

	var className = "dark";
	
	function beforeRemove(treeId, treeNode) {
		className = (className === "dark" ? "":"dark");
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		zTree.selectNode(treeNode);
		var id = treeNode.id;
		var isParent = treeNode.isParent;
		if(treeNode.children>0){
			alert("Subclasses contained cannot be deleted !!!!!!");
			return false;
		}
		
		if(confirm("确认删除 节点 -- " + treeNode.name + " 吗？")){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/manager03/deleteDept",	
				data:{id:id,isParent:isParent},
				dataType:"json",
				success:function(data){
					if(data){
						alert("删除 节点 -- " + treeNode.name +"成功！！");
					}else{
						alert("删除 节点 -- " + treeNode.name +"失败！！");
					}
				},
				error:function(msg){
					
				}
			});
		}else{
			return false;
		}
	}
	function beforeRename(treeId, treeNode, newName, isCancel) {
		className = (className === "dark" ? "":"dark");
		if (newName.length == 0) {
			setTimeout(function() {
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				zTree.cancelEditName();
				alert("节点名称不能为空.");
			}, 0);
			return false;
		}
		
		var id = treeNode.id;
		var isParent = treeNode.isParent;
		
		if(confirm("确认更改 节点 -- " + treeNode.name + "为" + newName + " 吗？")){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/manager03/updateDept",	
				data:{id:id,name:newName,isParent:isParent},
				dataType:"json",
				success:function(data){
					if(data){
						alert("更改 节点 -- " + newName +"成功！！");
					}else{
						alert("更改 节点 -- " + newName +"失败！！");
					}
				},
				error:function(msg){
					
				}
			});
		}else{
			return false;
		}
		return true;
	}
	var newCount = 1;
	function addHoverDom(treeId, treeNode) {
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
			+ "' title='add node' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) btn.bind("click", function(){
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			$("#myModal").modal("show");
			
			$("#addForm").submit(function(){
				
				var pid = treeNode.id;
				var name = $("#deptName").val();
				var code = $("#deptCode").val();
				var isParent = treeNode.isParent;
				
				zTree.addNodes(treeNode,{id:newCount+100,pid:pid,name:name,iconOpen:false,isParent:false});
				
				$.ajax({
					type:"post",
					url:"${pageContext.request.contextPath }/manager03/addDept",	
					data:{pid:pid,name:name,code:code,isParent:isParent},
					dataType:"json",
					success:function(data){
						
						alert("添加成功！！！");
						$("#myModal").modal("hide");
						return false;
					},
					error:function(msg){
						return false;
					}
				});
			})
		});
	};
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
	
	
	function selectAll() {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");
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
		
	</div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加节点</h4>
            </div>
            <div class="modal-body">
          		<form class="form-horizontal" role="addForm" action="##" id="addForm">
				<div class="form-group">
					<label for="activitiesName" class="col-sm-3 control-label">节点name</label>
					<div class="col-sm-7">
						<input type="text" id="deptName">
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>	
				</div>
				
				<div class="form-group">
					 <label for="numActivities" class="col-sm-3 control-label">节点code</label>
					<div class="col-sm-7">
						<input type="text" id="deptCode">
					</div>
					<div class="col-sm-2">
						<span></span>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						 <button id="addDept" type="submit" class="btn btn-primary">提交</button>
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						 <button type="reset" class="btn btn-primary">重置</button>
					</div>
				</div>
			</form>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> 
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<%@include file="../common/footer.jsp"%>
</body>
</html>
