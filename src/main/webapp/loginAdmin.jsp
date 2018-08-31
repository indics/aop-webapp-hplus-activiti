<%@page import="org.springframework.security.authentication.AuthenticationServiceException"%>
<%@page import="org.springframework.security.authentication.AccountExpiredException"%>
<%@page import="org.springframework.security.authentication.DisabledException"%>
<%@page import="org.springframework.security.authentication.LockedException"%>
<%@page import="org.springframework.security.authentication.BadCredentialsException"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.cosim.core.util.AppUtil"%>
<%@page import="java.util.Properties"%>
<%@page import="org.springframework.security.web.WebAttributes"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>运营管理后台</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="${ctx}/js/hplus/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx}/js/hplus/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx}/js/hplus/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="${ctx}/js/hplus/css/animate.min.css" rel="stylesheet">
    <link href="${ctx}/js/hplus/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    
    <%
		Properties configProperties=(Properties)AppUtil.getBean("configproperties");
		String validCodeEnabled=configProperties.getProperty("validCodeEnabled");
	%>
	<script type="text/javascript">
		if(top!=this){//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
		  top.location='<%=request.getContextPath()%>/loginSystem.jsp';
		}
	</script>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-7" style="margin-left:300px;">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>运营管理后台登录</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-6 b-r">
                                <h3 class="m-t-none m-b">登录</h3>
                                <p>
                                	欢迎登录本站(⊙o⊙)
                                	<label class="block clearfix">
										<span class="block input-icon input-icon-right">
											<span id="loginTip" style="color:#A94442">																
												<%
													Object loginError=(Object)request.getSession().getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
			
													if(loginError!=null ){
														String msg="";
														if(loginError instanceof BadCredentialsException){
															msg="密码输入错误";
														}
														else if(loginError instanceof AuthenticationServiceException){
															AuthenticationServiceException ex=(AuthenticationServiceException)loginError;
															msg=ex.getMessage();
														}
														else{
															msg=loginError.toString();
														}
												%>
												<%=msg%>
												<%
													}
												%>
											</span>
										</span>
									</label>
                                </p>
                                <form id="loginForm" role="form" method="post" action="${ctx}/loginAdminPost.ht">
                                    <div class="form-group">
                                        <label>企业账号</label>
                                        <input id="orgSn" name="orgSn" type="text" class="form-control" placeholder="用户名" />
                                    </div>
                                    <div class="form-group">
                                        <label>用户名</label>
                                        <input id="shortAccount" name="shortAccount" type="text" class="form-control" placeholder="用户名" />
                                    </div>
                                    <div class="form-group">
                                        <label>密码</label>
                                        <input id="password" name="password" type="password" class="form-control" placeholder="密码" />
                                    </div>
                                    <%
                        			if(validCodeEnabled!=null && "true".equals(validCodeEnabled)){
                        			%>
                                    <div class="form-group">
                                        <label>验证码</label>
                                        <input type="text" id="validCode" name="validCode" class="form-control" placeholder="验证码" style="width:50%"/>
										<a href='javascript:void(0);' style="cursor:pointer" title="点击更换图片" onClick="$('#validImg').attr('src','${ctx}/servlet/ValidCode?t='+Math.random());">
											<img id="validImg" src="${ctx}/servlet/ValidCode"/>
										</a>
                                    </div>
                                    <%
                          			}
                                    %>
                                    <div>
                                        <button id="btnLogin" class="btn btn-sm btn-primary pull-right m-t-n-xs" type="button"><strong>登 录</strong>
                                        </button>
                                        <label>
                                        <input type="checkbox" name="_spring_security_remember_me" class="i-checks">自动登录</label>
                                    </div>
                                </form>
                            </div>
                            <div class="col-sm-6">
                                <h4>还不是会员？</h4>
                                <p>您可以注册一个新账户</p>
                                <p class="text-center">
                                    <a href="#"><i class="fa fa-sign-in big-icon"></i></a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    	</div>
    </div>
    <script src="${ctx}/js/hplus/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctx}/js/hplus/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="${ctx}/js/hplus/js/content.min.js?v=1.0.0"></script>
    <script src="${ctx}/js/hplus/js/plugins/iCheck/icheck.min.js"></script>
    <script>
        $(document).ready(function(){$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})});
        
        $(document).ready(function(){
        	$('#password').keydown(function(e){
        		if(e.keyCode==13){
        		   $('#btnLogin').click();
        		}
        	}); 
        	
        	$('#validCode').keydown(function(e){
        		if(e.keyCode==13){
        		   $('#btnLogin').click();
        		}
        	}); 
        	
			$('#btnLogin').click(function(){
				$.ajax({
					dataType : "json",
					url : "${ctx}/loginAdminPost.ht",
					type : "post",
					data : {
						orgSn : $('#orgSn').val(),
						shortAccount : $('#shortAccount').val(),
						password : $('#password').val(),
						validCode : $('#validCode').val(),					
						_spring_security_remember_me : $("input[name='_spring_security_remember_me']:checked").val()
					},
					complete : function(xmlRequest) {
						var obj = eval("(" + xmlRequest.responseText + ")");					
						if (obj.result == 1) {
							document.location.href = "${ctx}/back/home.ht";
						} else {						
							$("#loginTip").html(obj.message);
						}
					}
				});
			});
		});
    </script>
</body>
</html>