<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/header.jsp"%>

<!-- 书写内容 -->


<div class="container">
		<div class="col-md-8 column">
			<table class="table h4 text-center ">
				 <caption class="h2 text-center">个人信息</caption>
				<tbody>
					<tr>
						<th class="text-center">
							地区名称：
						</th>
						<th class="text-center">
							${USER_SESSION.username}
						</th>
					</tr>
					<tr>
						<th class="text-center">
							账号：
						</th>
						<th class="text-center">
							${USER_SESSION.usercode}
						</th>
					</tr>
				
					<tr>
						<th class="text-center">
							电话号码：
						</th>
						<th class="text-center">
							${USER_SESSION.tel}
						</th>
					</tr>
				
					<tr>
						<th class="text-center">
							性别：
						</th>
						<th class="text-center">
							<c:if test="${USER_SESSION.sex==1}">男</c:if>
							<c:if test="${USER_SESSION.sex==2}">女</c:if>
						</th>
					</tr>
					<tr>
						<th class="text-center">
							级别：
						</th>
						<th class="text-center">
							<c:if test="${USER_SESSION.level==0}">县级</c:if>
							<c:if test="${USER_SESSION.level==1}">市级</c:if>
							<c:if test="${USER_SESSION.level==2}">省级</c:if>
							<c:if test="${USER_SESSION.level==4}">超级管理员</c:if>
						</th>
						
					</tr>
					
				</tbody>
			</table>
		</div>
		
	
</div>
<%@include file="../common/footer.jsp"%>
</body>
</html>
