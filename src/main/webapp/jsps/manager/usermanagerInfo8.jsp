<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/header.jsp"%>

<!-- 书写内容 -->
<script type="text/javascript">
$(function(){
	
	var dom01 = document.getElementById("container01");
	var dom02 = document.getElementById("container02");
	var myChart01 = echarts.init(dom01);//初始化echarts
	var myChart02= echarts.init(dom02);//初始化echarts
	
	 $.ajax({
	    //几个参数需要注意一下
        type: "post",//方法类型
        dataType: "json",//预期服务器返回的数据类型
        url: "${pageContext.request.contextPath }/zTree/Filine",//url
        data:{},
        processData:false,
        contentType:false,
        success: function (data) {
        	if(data){
				var deptName=new Array();
				var money=new Array();
				var actual=new Array();
				$(data).each(function(index,d){
                    deptName[index]=d.deptName;
					money[index]=d.money;
					actual[index]={value:d.money,name:d.deptName};
				})
				option01 = {
					title : {text: '地区活动统计折线图',x:'center'},
					xAxis: {
					    type: 'category',
						name:'活动名称',
						data: deptName
					},
					yAxis: {type: 'value', name:'元'},
					series: [{data: money,type: 'line',smooth: true}]
				};
				option02 = {
				    title : {text: '地区活动统计饼状图', x:'center'},
				    tooltip : {trigger: 'item',formatter: "{a} <br/>{b} : {c} ({d}%)"},
				    legend: {orient: 'vertical',left: 'left',data: deptName},
				    series : [{name: '同名同性学生姓名',type: 'pie',radius : '60%',center: ['50%', '50%'],data: actual,
				            itemStyle: {emphasis: {shadowBlur: 10,shadowOffsetX: 0,shadowColor: 'rgba(0, 0, 0, 0.5)'}}}]
				}; 
			}
			
			myChart01.setOption(option01, true);
			myChart02.setOption(option02, true);
        	
        },
        error : function() {
        	
         	alert("失败！！！");
            
        }
	});
	
	
})

</script>
<body >
<div class="container" align="center" style="height:100%;width: 100%">
	<div class="row" style="height: 100%; margin: 0">
		<div id="container01" style="height: 700px;width: 100%"></div>
	</div>
	
	<div class="row" style="height: 100%; margin: 0">
		<div id="container02" style="height: 700px;width: 100%"></div>
	</div>
	
</div>

<%@include file="../common/footer.jsp"%>
</body>
</html>
