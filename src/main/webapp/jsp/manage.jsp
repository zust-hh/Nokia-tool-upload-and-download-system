<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/4
  Time: 14:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理页</title>
    <link rel="stylesheet" href="../css/manage.css" />
    <link rel="stylesheet" href="../uikit/css/uikit.min.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="../uikit/css/components/search.css" />
    <script src="../uikit/jquery.min.js"></script>
    <script src="../uikit/js/uikit.min.js"></script>
    <script src="../js/manage.js"></script>
</head>

<body>
<div id="dropNavContainer" class="uk-width-1-1">
    <a class="uk-navbar-brand" href="/" style="margin-left: 35px;margin-top: 10px;"><img src="../img/nokia.png" style="width:120px;"></a>
    <a class="uk-navbar-brand" href="/" style="margin-top:11px;font-size: 20px;color:rgb(18,65,145);line-height: 40px;padding-left: 0;"><strong>工具管理平台</strong></a>
    <span>
        <form id="dropSearchForm" method="get" action="/SearchPageServlet">
            <input id="dropSearchInput" name="searchKey" type="text" placeholder="Search Tools You Like...">
            <input class="dropSubmit" type="submit" value=""></input>
            <i class="uk-icon-search dropSearchButton"></i>
        </form>
    </span>
    <c:if test="${loggedUserBean==null}">
        <a class="dropLogin" href="#loginBox" data-uk-modal>登录</a>
    </c:if>
    <c:if test="${loggedUserBean!=null}">
        <div class="uk-navbar-flip dropLogined">
            <ul class="uk-navbar-nav">
                <li class="uk-parent" data-uk-dropdown>
                    <a class="dropNavUser">
                        <img src="../img/headIcon.jpg">
                        <div class="navUserName uk-hidden-small">${loggedUserBean.userName}</div>
                        <i class="uk-icon-chevron-down uk-icon-xsmall uk-hidden-small navUserDown"></i>
                    </a>
                    <div class="uk-dropdown uk-dropdown-navbar dropdownList">
                        <ul class="uk-nav uk-nav-navbar uk-list-striped dropDownStyle">
                            <li><a href="/UserCenterServlet?uid=${loggedUserBean.userId}">个人中心</a></li>
                            <li><a href="/UploadPageServlet">工具上传</a></li>
                            <c:if test="${loggedUserBean.userLevel==2}">
                                <li><a href="/manage">管理中心</a></li>
                            </c:if>
                            <li><a href="/logout">退出</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
    </c:if>
</div>
<header></header>
<div class="manage-body">
    <ul class="manage-menu uk-nav uk-nav-side" data-uk-switcher="{connect:'#manage-function'}">
        <li class="uk-active li1">
            <a href="#" class="menu-a">管理权限</a>
        </li>
        <li>
            <a href="#" class="menu-a">添加权限</a>
        </li>
        <li class="li1">
            <a href="#" class="menu-a">查询用户ID</a>
        </li>
        <li>
            <a href="#" class="menu-a">分类管理</a>
        </li>
    </ul>
    <ul id="manage-function" class="uk-switcher">
        <li class="see-permission">
            <table class="uk-table uk-table-hover uk-table-striped">
                <caption>目前权限分配</caption>
                <thead>
                <tr>
                    <th>用户昵称（ID）</th>
                    <th>管理板块</th>
                    <th>撤销授权</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${adminList}" var="currentSubAdmin">
                    <c:forEach items="${currentSubAdmin.authCategory}" var="categoryId">
                        <tr>
                            <td><span class="username">${currentSubAdmin.userName}</span>（<span class="userid">${currentSubAdmin.uid}</span>）</td>
                            <td class="changeToCateName">${categoryId}</td>
                            <td>
                                <a href="/api/manage/cancel_auth?uid=${currentSubAdmin.uid}&category=${categoryId}">撤销该板块授权</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:forEach>


                </tbody>
            </table>
        </li>
        <li class="add-permission">
            <h3>添加权限</h3>
            <form method="post" action="/api/add_sub_admin_auth">
            <input type="text" name="uid" placeholder="输入预授权用户ID" id="fillin-userid" />
            <p>选择板块：</p>
            <select name="category" id="plate-select">
                <option value="1">办公</option>
                <option value="2">网络</option>
                <option value="3">安全</option>
                <option value="4">系统维护</option>
            </select><br />
            <input type="submit" value="确认授权" class="uk-button uk-button-primary sub-auth" />
            </form>
        </li>
        <li class="query-id">
            <input type="text" placeholder="输入要查询用户姓名" id="query-text" />
            <input type="submit" value="查询" id="query-button" class="uk-button uk-button-primary" />
            <div>
                <p>你查询的用户ID为：</p>
                <span id="query-result"></span>
            </div>
        </li>
    </ul>
</div>
</body>
<script src="../js/common.js"></script>
<script type="application/javascript">
    var mp = {
        "1":"办公",
        "2":"网络",
        "3":"安全",
        "4":"系统维护",
        "5":"其他"
    };
    $('.changeToCateName').each(function(){
        $(this).html(mp[$(this).html()]);
    });
</script>
</html>