<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>酒会管理系统 </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/ace.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/ace-rtl.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/ace-skins.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/style.css"/>


    <script src="${pageContext.request.contextPath}/static/assets/js/ace-extra.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/common/jquery-3.2.1.min.js"></script>

    <script type="text/javascript">
        if ("ontouchend" in document) document.write("<script src='/assets/js/jquery.mobile.custom.min.js'>" + "<" + "script>");
    </script>
    <script src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/assets/js/typeahead-bs2.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/assets/js/ace-elements.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/assets/js/ace.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/assets/layer/layer.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/assets/laydate/laydate.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/assets/js/jquery.nicescroll.js"
            type="text/javascript"></script>

    <script type="text/javascript">
        $(function () {
            var cid = $('#nav_list> li>.submenu');
            cid.each(function (i) {
                $(this).attr('id', "Sort_link_" + i);

            })

            $("#main-container").height($(window).height() - 76);
            $("#iframe").height($(window).height() - 140);

            $(".sidebar").height($(window).height() - 99);
            var thisHeight = $("#nav_list").height($(window).outerHeight() - 173);
            $(".submenu").height();
            $("#nav_list").children(".submenu").css("height", thisHeight);
            //当文档窗口发生改变时 触发
            $(window).resize(function () {
                $("#main-container").height($(window).height() - 76);
                $("#iframe").height($(window).height() - 140);
                $(".sidebar").height($(window).height() - 99);

                var thisHeight = $("#nav_list").height($(window).outerHeight() - 173);
                $(".submenu").height();
                $("#nav_list").children(".submenu").css("height", thisHeight);
            });
            $(document).on('click', '.iframeurl', function () {
                var cid = $(this).attr("name");
                var cname = $(this).attr("title");
                $("#iframe").attr("src", cid).ready();
                $("#Bcrumbs").attr("href", cid).ready();
                $(".Current_page a").attr('href', cid).ready();
                $(".Current_page").attr('name', cid);
                $(".Current_page").html(cname).css({"color": "#333333", "cursor": "default"}).ready();
                $("#parentIframe").html('<span class="parentIframe iframeurl"> </span>').css("display", "none").ready();
                $("#parentIfour").html('').css("display", "none").ready();
            });

            /******/
            $(document).on('click', '.link_cz > li', function () {
                $('.link_cz > li').removeClass('active');
                $(this).addClass('active');
            });
        })

        /*********************点击事件*********************/
        $(document).ready(function () {
            $('#nav_list,.link_cz').find('li.home').on('click', function () {
                $('#nav_list,.link_cz').find('li.home').removeClass('active');
                $(this).addClass('active');
            });

            //时间设置
            function currentTime() {
                var d = new Date(), str = '';
                str += d.getFullYear() + '年';
                str += d.getMonth() + 1 + '月';
                str += d.getDate() + '日';
                str += d.getHours() + '时';
                str += d.getMinutes() + '分';
                str += d.getSeconds() + '秒';
                return str;
            }

            setInterval(function () {
                $('#time').html(currentTime)
            }, 1000);

            //退出
            $('#Exit_system').on('click', function () {
                layer.confirm('是否确定退出系统？', {
                        btn: ['是', '否'],//按钮
                        icon: 2,
                    },
                    function () {
                        //点击退出确认键后  跳转到后台进行user 信息的清除
                        location.href = "${pageContext.request.contextPath}/user/logout";

                    });
            });
        });

        function link_operating(name, title) {
            var cid = $(this).name;
            var cname = $(this).title;
            $("#iframe").attr("src", cid).ready();
            $("#Bcrumbs").attr("href", cid).ready();
            $(".Current_page a").attr('href', cid).ready();
            $(".Current_page").attr('name', cid);
            $(".Current_page").html(cname).css({"color": "#333333", "cursor": "default"}).ready();
            $("#parentIframe").html('<span class="parentIframe iframeurl"> </span>').css("display", "none").ready();
            $("#parentIfour").html('').css("display", "none").ready();


        }
    </script>
    <!-- 判断是否已经登录 如果未登录则退出到登录界面 -->
    <%
        session = request.getSession();
        Object user = session.getAttribute("USER_SESSION");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/jsps/login.jsp");
        }
    %>


</head>
<body>
<div class="navbar navbar-default" id="navbar">
    <script type="text/javascript">
        try {
            ace.settings.check('navbar', 'fixed')
        } catch (e) {
        }
    </script>
    <div class="navbar-container" id="navbar-container">
        <div class="navbar-header pull-left">
            <a href="https://item.taobao.com/item.htm?id=539837098284" class="navbar-brand">
                <small>
                    <!--<img src="images/logo.png" width="470px">-->
                </small>
            </a><!-- /.brand -->
        </div><!-- /.navbar-header -->
        <div class="navbar-header operating pull-left">

        </div>
        <div class="navbar-header pull-right" role="navigation">
            <ul class="nav ace-nav">
                <li class="light-blue">
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        <span class="time"><em id="time"></em></span><span class="user-info"><small>欢迎光临,</small>
                        ${USER_SESSION.username }</span>
                        <i class="icon-caret-down"></i>
                    </a>
                    <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                        <li><a href="javascript:ovid(0)" id="Exit_system"><i class="icon-off"></i>退出</a></li>
                    </ul>
                </li>
            </ul>

        </div>
    </div>
</div>
<div class="main-container" id="main-container">
    <script type="text/javascript">
        try {
            ace.settings.check('main-container', 'fixed')
        } catch (e) {
        }
    </script>
    <div class="main-container-inner">
        <a class="menu-toggler" id="menu-toggler" href="#">
            <span class="menu-text"></span>
        </a>
        <div class="sidebar" id="sidebar">
            <script type="text/javascript">
                try {
                    ace.settings.check('sidebar', 'fixed')
                } catch (e) {
                }
            </script>
            <div class="sidebar-shortcuts" id="sidebar-shortcuts">
                <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
                    <a class="btn btn-success">
                        <i class="icon-signal"></i>
                    </a>

                    <a class="btn btn-info">
                        <i class="icon-pencil"></i>
                    </a>

                    <a class="btn btn-warning">
                        <i class="icon-group"></i>
                    </a>

                    <a class="btn btn-danger">
                        <i class="icon-cogs"></i>
                    </a>
                </div>

                <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
                    <span class="btn btn-success"></span>

                    <span class="btn btn-info"></span>

                    <span class="btn btn-warning"></span>

                    <span class="btn btn-danger"></span>
                </div>
            </div><!-- #sidebar-shortcuts -->
            <div id="menu_style" class="menu_style">
                <ul class="nav nav-list" id="nav_list">
                    <li>
                        <a href="#" class="dropdown-toggle"><i class="icon-credit-card"></i><span class="menu-text"> 数据管理 </span><b
                                class="arrow icon-angle-down"></b></a>
                        <ul class="submenu">
                            <li class="home">

                                <a href="javascript:void(0)" name="${pageContext.request.contextPath}/zTree/findItems"
                                   title="查询数据 " class="iframeurl">
                                    <i class="icon-double-angle-right"></i>查询数据
                                </a>

                            </li>
                        </ul>
                    </li>
                    <c:if test='${USER_SESSION.level ==4}'>
                        <li>
                            <a href="#" class="dropdown-toggle"><i class="icon-credit-card"></i><span class="menu-text"> 用户管理 </span><b
                                    class="arrow icon-angle-down"></b></a>
                            <ul class="submenu">
                                <li class="home">

                                    <a href="javascript:void(0)"
                                       name="${pageContext.request.contextPath}/jsps/manager/usermanagerInfo_11.jsp"
                                       title="用户信息" class="iframeurl">
                                        <i class="icon-double-angle-right"></i>用户信息
                                    </a>

                                </li>
                            </ul>
                        </li>
                    </c:if>
                    <c:if test='${USER_SESSION.level ==4}'>
                        <li>
                            <a href="#" class="dropdown-toggle"><i class="icon-credit-card"></i><span class="menu-text"> 机构管理 </span><b
                                    class="arrow icon-angle-down"></b></a>
                            <ul class="submenu">
                                <li class="home">

                                    <a href="javascript:void(0)"
                                       name="${pageContext.request.contextPath}/jsps/manager/usermanagerInfo_12.jsp"
                                       title="用户信息" class="iframeurl">
                                        <i class="icon-double-angle-right"></i>机构信息
                                    </a>

                                </li>
                            </ul>
                        </li>
                    </c:if>
                    <c:if test='${USER_SESSION.level ==0 || USER_SESSION.level == 1}'>
                        <li>
                            <a href="#" class="dropdown-toggle"><i class="icon-credit-card"></i><span class="menu-text"> 活动管理 </span><b
                                    class="arrow icon-angle-down"></b></a>
                            <ul class="submenu">
                                <li class="home">
                                    <!-- 权限管理 -->
                                    <c:if test='${USER_SESSION.level ==0 }'>
                                        <a href="javascript:void(0)"
                                           name="${pageContext.request.contextPath }/jsps/manager/usermanagerInfo1.jsp"
                                           title="预报数据" class="iframeurl">
                                            <i class="icon-double-angle-right"></i>预报数据
                                        </a>
                                    </c:if>
                                </li>
                                <li class="home">
                                    <c:if test='${USER_SESSION.level ==0 }'>
                                        <a href="javascript:void(0)"
                                           name="${pageContext.request.contextPath}/sb/findPlan" title="上报数据 "
                                           class="iframeurl">
                                            <i class="icon-double-angle-right"></i>上报数据
                                        </a>
                                    </c:if>
                                </li>
                                <li class="home">
                                    <c:if test='${USER_SESSION.level == 1}'>
                                        <a href="javascript:void(0)"
                                           name="${pageContext.request.contextPath}/sb/findPlanOnAudit"
                                           title="审核数据 " class="iframeurl">
                                            <i class="icon-double-angle-right"></i>审核数据
                                        </a>
                                    </c:if>
                                </li>
                            </ul>
                        </li>
                    </c:if>
                    <li><a href="#" class="dropdown-toggle"><i class="icon-group"></i><span
                            class="menu-text"> 个人中心 </span><b class="arrow icon-angle-down"></b></a>
                        <ul class="submenu">
                            <li class="home">
                                <a href="javascript:void(0);"
                                   name="${pageContext.request.contextPath }/jsps/manager/usermanager.jsp" title="个人信息"
                                   class="iframeurl">
                                    <i class="icon-double-angle-right"></i>个人信息
                                </a>
                            </li>
                            <li class="home">
                                <a href="javascript:void(0);"
                                   name="${pageContext.request.contextPath }/jsps/manager/changePassword.jsp"
                                   title="修改密码" class="iframeurl">
                                    <i class="icon-double-angle-right"></i>修改密码
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <script type="text/javascript">
                $("#menu_style").niceScroll({
                    cursorcolor: "#888888",
                    cursoropacitymax: 1,
                    touchbehavior: false,
                    cursorwidth: "5px",
                    cursorborder: "0",
                    cursorborderradius: "5px"
                });
            </script>
            <div class="sidebar-collapse" id="sidebar-collapse">
                <i class="icon-double-angle-left" data-icon1="icon-double-angle-left"
                   data-icon2="icon-double-angle-right"></i>
            </div>
            <script type="text/javascript">
                try {
                    ace.settings.check('sidebar', 'collapsed')
                } catch (e) {
                }
            </script>
        </div>

        <div class="main-content">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>
            <div class="breadcrumbs" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home home-icon"></i>
                        <a href="index.html">首页</a>
                    </li>
                    <li class="active"><span class="Current_page iframeurl"></span></li>
                    <li class="active" id="parentIframe"><span class="parentIframe iframeurl"></span></li>
                    <li class="active" id="parentIfour"><span class="parentIfour iframeurl"></span></li>
                </ul>
            </div>

            <iframe id="iframe" style="border:0; width:100%; background-color:#FFF;" name="iframe" frameborder="0"
                    src="${pageContext.request.contextPath }/jsps/manager/usermanager.jsp"></iframe>


            <!-- /.page-content -->
        </div><!-- /.main-content -->

        <div class="ace-settings-container" id="ace-settings-container">
            <div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
                <i class="icon-cog bigger-150"></i>
            </div>

            <div class="ace-settings-box" id="ace-settings-box">
                <div>
                    <div class="pull-left">
                        <select id="skin-colorpicker" class="hide">
                            <option data-skin="default" value="#438EB9">#438EB9</option>
                            <option data-skin="skin-1" value="#222A2D">#222A2D</option>
                            <option data-skin="skin-2" value="#C6487E">#C6487E</option>
                            <option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
                        </select>
                    </div>
                    <span>&nbsp; 选择皮肤</span>
                </div>

                <div>
                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar"/>
                    <label class="lbl" for="ace-settings-sidebar"> 固定滑动条</label>
                </div>

                <div>
                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl"/>
                    <label class="lbl" for="ace-settings-rtl">切换到左边</label>
                </div>

                <div>
                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container"/>
                    <label class="lbl" for="ace-settings-add-container">
                        切换窄屏
                        <b></b>
                    </label>
                </div>
            </div>
        </div><!-- /#ace-settings-container -->
    </div><!-- /.main-container-inner -->

</div>
<!--底部样式-->

</body>
</html>

