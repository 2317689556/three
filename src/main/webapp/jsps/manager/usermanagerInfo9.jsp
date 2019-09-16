<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/header.jsp" %>

<!-- 书写内容 -->
<script type="text/javascript">
    $(function () {

        var dom = document.getElementById("container");
        var myChart = echarts.init(dom);//初始化echarts

        $.ajax({
            //几个参数需要注意一下
            type: "post",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "${pageContext.request.contextPath }/zTree/Filine",//url
            data: {},
            processData: false,
            contentType: false,
            success: function (data) {
                if (data) {
                    var activitiesName = new Array();
                    var money = new Array();
                    $(data).each(function (index, d) {
                        activitiesName[index] = d.deptName;
                        money[index] = d.money;
                    })
                    option = {
                        title: {text: '地区活动统计柱状图', x: 'center'},
                        xAxis: {type: 'category', name: '地区名称', data: activitiesName},
                        yAxis: {type: 'value', name: '元', min: 0},
                        series: [{data: money, type: 'bar', smooth: true}]
                    };
                }

                myChart.setOption(option, true);

            },
            error: function () {

                alert("失败！！！");

            }
        });


    })

</script>

<div id="container" style="height: 700px; margin: 0"></div>

<%@include file="../common/footer.jsp" %>
</body>
</html>
