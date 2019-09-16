$(function () {
    $("#table").bootstrapTable({
        url:"/user/findAllMemberShips",//请求的路径
        pagination:true,//分页的开关，默认是关闭的
        sidePagination:"server",//客户端分页
        pageSize:3,
        pageList:[2,3,4,5,6],
        columns: [//field对应的是entity中的属性  title:列名
            {
                field: 'id', // 返回json数-据中的name
                title: '序号', // 表格表头显示文字
                align: 'center',
                formatter:function(value,row,index){
                    return index+1;
                }
            }, {
                field: 'userName',
                title: '会员名',
                align: 'center',
                formatter:function( value,row,index ){
                    //单元格格式化函数，有三个参数：
                    // value： 该列的字段值；
                    // row： 这一行的数据对象；
                    // index： 行号，第几行，从0开始计算
                    //如何使用拿到的多个数据 直接返回拼接好的html;
                    var html="";
                        html = "<strong>"+row.userName+"(真实姓名："+row.trueName+")</strong><br/>"+"注册时间:"+row.createtime;
                    return html;
                }
            }, {
                field: 'secUserDetail.integral',
                title: '会员积分',
                align: 'center'
            },  {
                field: 'secUserDetail.gold',
                title: '会员金币',
                align: 'center'
            },  {
                field: 'loginCount',
                title: '登陆次数',
                align: 'center'
            }, {
                field: 'secUserDetail',
                title: '预存款',
                align: 'center',
                formatter:function( value,row,index ){
                    var ht="";
                     if(null!=row.secUserDetail){
                        ht = "<strong>可用:"+row.secUserDetail.availableBalance+"元</strong><br/>"+"<strong>冻结:"+row.secUserDetail.freezeBlance+"元</strong>";
                     }
                    return ht;
                }
            }, {
                field: 'secUserDetail.storeId',
                title: '店铺',
                align: 'center',
                formatter:function( value,row,index ){
                    var str="";
                    if(row.idCard != null){
                        if(row.status == 1){
                            if(row.secUserDetail!=null){
                                if(row.secUserDetail.storeId!=null){
                                    str="<strong>店铺</strong>";
                                }else{
                                    str="<span style='color:red;'>未开店</span>";
                                }
                            }
                        }else{
                            str="<a href='/user/MemberShipAudit/"+row.id+"'style='color: #0b6cbc;'>去审核</a>";
                        }
                    }else{
                        str="<span style='color:red;'>未认证</span>";
                    }
                    return str;
                }
            }, {
                title: "操作",
                field:'id',
                formatter:function(value,row,index){
                    var str="<a href='#'style='color: #0b6cbc'>编辑</a>&nbsp;&nbsp;&nbsp;<a href='#' style='color: #2a62bc'>删除</a>";
                    return str;
                }
            }
        ]
    });
})