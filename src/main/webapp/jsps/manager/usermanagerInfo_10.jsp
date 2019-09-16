<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/header.jsp"%>

<!-- 书写内容 -->
<script type="text/javascript">
$(function(){
	
	var dom = document.getElementById("container");
	var myChart = echarts.init(dom);//初始化echarts
	
	 $.ajax({
	    //几个参数需要注意一下
        type: "post",//方法类型
        dataType: "json",//预期服务器返回的数据类型
        url:"${pageContext.request.contextPath }/zTree/Filine",//url
        data:{},
        processData:false,
        contentType:false,
        success: function (data) {
        	if(data){
				var activitiesName=new Array();
				var actual=new Array();
				$(data).each(function(index,d){
                    activitiesName[index]=d.deptName;
					actual[index]={value:d.money,name:d.deptName}; 
				})
				option = {
				    title : {text: '河南省活动统计饼状图', x:'center'},
				    tooltip : {trigger: 'item',formatter: "{a} <br/>{b} : {c} ({d}%)"},
				    legend: {orient: 'vertical',left: 'left',data: activitiesName},
				    series : [{name: '地区名称',type: 'pie',radius : '50%',center: ['50%', '50%'],data: actual,
				            itemStyle: {emphasis: {shadowBlur: 10,shadowOffsetX: 0,shadowColor: 'rgba(0, 0, 0, 0.5)'}}}]
				}; 
			}
			
			myChart.setOption(option, true);
		
        },
        error : function() {
        	
         	alert("失败！！！");
            
        }
	});
	
	
})

</script>

	<div id="container" style="height: 700px; margin: 0"></div>
		
<%@include file="../common/footer.jsp"%>
</body>
</html>
