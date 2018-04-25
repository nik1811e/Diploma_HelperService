<%@ page import="entity.AuthInfEntity" %>
<%@ page import="entity.FollowingEntity" %>
<%@ page import="util.CookieUtil" %>
<%@ page import="util.MailUtil" %>
<%@ page import="util.MethodUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %><%--suppress ALL --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>

    <title>Helper service | Resource</title>

    <link rel="shortcut icon" href="/resources/userPages/images/gt_favicon.png">

    <link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
    <link rel="stylesheet" href="/resources/userPages/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/userPages/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/userPages/css/list.css">

    <link rel="stylesheet" href="/resources/userPages/css/bootstrap-theme.css" media="screen">
    <link rel="stylesheet" href="/resources/userPages/css/main.css">

    <script src="/resources/userPages/js/html5shiv.js"></script>
    <script src="/resources/userPages/js/respond.min.js"></script>

    <%
        CookieUtil cookieUtil = new CookieUtil(request);
        String urlRedirect = "/pages/signin.jsp";
        List<AuthInfEntity> authInfEntityList = new ArrayList<>();
        List<FollowingEntity> followingEntities = new ArrayList<>();

        if (cookieUtil.isFindCookie()) {
            try {
                followingEntities = MethodUtil.getUserFollowings(request.getParameter("uuidAuth"));
            } catch (Exception ex) {
                new MailUtil().sendErrorMailForAdmin(getClass().getName() + "\n" + Arrays.toString(ex.getStackTrace()));
            }
        } else {
            response.sendRedirect(urlRedirect);
        }
        assert authInfEntityList != null;
    %>

</head>

<body class="home">
<!-- Fixed navbar -->
<div class="navbar navbar-inverse navbar-fixed-top headroom">
    <div class="container">
        <div class="navbar-header">
            <!-- Button for smallest screens -->
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span
                    class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span></button>
            <a class="navbar-brand" href="/pages/index.jsp"><img src="/resources/userPages/images/logo.png"
                                                                 alt="Helper Service Logo"></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav pull-right">
                <li class="active"><a href="/pages/index.jsp">Главная</a></li>
                <li><a href="/pages/catalog.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Ресурсы</a></li>
                <li class="dropdown">
                    <a href="/pages/users.jsp" class="dropdown-toggle" data-toggle="dropdown">Пользователи<b
                            class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/pages/users.jsp">Список пользователей</a></li>
                        <li class="active">Мои подписки</li>
                    </ul>
                </li>
                <li><a href="/pages/requests.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Запросы</a></li>

                <%if (!cookieUtil.isFindCookie()) {%>
                <li><a class="btn" href="/pages/signin.jsp">Авторизация</a></li>
                <%} else {%>
                <li><a class="btn" href="/pages/profile.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Профиль</a>
                </li>
                <%}%>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<!-- /.navbar -->

<!-- Header -->
<header id="head">
    <div class="container">
        <div class="row">
            <h1 style="color: #ffffff;">Бесплатный сервис хранения ссылок и закладок!</h1>
        </div>
    </div>
</header>
<!-- /Header -->

<!-- Intro -->
<div class="container">
    <ol class="breadcrumb">
        <li><a href="index.jsp">Главная</a></li>
        <li class="active">Пользователи</li>
    </ol>
    <div class="text-center">
        <br> <br>
        <h2 class="thin">Подписки</h2>
        <br>
        <%if(followingEntities!=null){%>
        <table class="table table-hover">
            <thead>
            <tr>
                <th scope="col">Имя</th>
                <th scope="col">Фамилия</th>
                <th scope="col">Емаил</th>
                <th scope="col">Дата регистрации</th>
                <th scope="col">О пользователе</th>
            </tr>
            </thead>
            <tbody>
            <%
                assert followingEntities != null;
                for (FollowingEntity fol : followingEntities) {
                    authInfEntityList = MethodUtil.getAuthInfByUuid(MethodUtil
                            .getUuudAuthById(fol.getIdFollowing()));
                    assert authInfEntityList != null;%>
            <tr onclick="window.location.href='/pages/profile.jsp?uuidAuth=<%=authInfEntityList.get(0).getUuid()%>'">
                <td><%=authInfEntityList.get(0).getFName()%>
                </td>
                <td><%=authInfEntityList.get(0).getLName()%>
                </td>
                <td><%=authInfEntityList.get(0).getEmail()%>
                </td>
                <td><%=authInfEntityList.get(0).getDateReg()%>
                </td>
                <%if (!authInfEntityList.get(0).getAbout().isEmpty()) {%>
                <td><%=authInfEntityList.get(0).getAbout()%>
                </td>
                <%} else {%>
                <td>пусто</td>
                <%}%>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%}else{%>
        <h4 class="thin">Пусто</h4>
        <%}%>
    </div>
</div>
<!-- /Intro-->

<!-- Highlights - jumbotron -->
<div class="jumbotron top-space">
    <div class="container">
        <%--<div>
            <form method="post" action="/resourcetransfer">
                <input type="text" name="uuidNewSection">
                <input type="hidden" name="uuidCourseTransfer" value="<%=uuidCourse%>">
                <input type="hidden" name="uuidResource" value="<%=uuidResource%>">
                <button type="submit"> Перенести</button>
            </form>
        </div>--%>
    </div>
</div>
<!-- /Highlights -->
<footer id="footer" class="top-space">
    <div class="footer1">
        <div class="container">
            <div class="row">
                <div class="col-md-3 widget">
                    <h3 class="widget-title">Контакты</h3>
                    <div class="widget-body">
                        <p>
                            <a href="mailto:service.helper.eng@gmail.com">service.helper.eng@gmail.com</a><br>

                        </p>
                    </div>
                </div>
                <div class="col-md-3 widget">
                </div>
                <div class="col-md-6 widget">
                    <h3 class="widget-title">Text widget</h3>
                    <div class="widget-body">
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Excepturi, dolores, quibusdam
                            architecto voluptatem amet fugiat nesciunt placeat provident cumque accusamus itaque
                            voluptate modi quidem dolore optio velit hic iusto vero praesentium repellat commodi ad id
                            expedita cupiditate repellendus possimus unde?</p>
                        <p>Eius consequatur nihil quibusdam! Laborum, rerum, quis, inventore ipsa autem repellat
                            provident assumenda labore soluta minima alias temporibus facere distinctio quas adipisci
                            nam sunt explicabo officia tenetur at ea quos doloribus dolorum voluptate reprehenderit
                            architecto sint libero illo et hic.</p>
                    </div>
                </div>

            </div> <!-- /row of widgets -->
        </div>
    </div>

    <div class="footer2">
        <div class="container">
            <div class="row">

                <div class="col-md-6 widget">
                    <div class="widget-body">
                        <p class="simplenav">
                            <a href="#">Home</a> |
                            <b><a href="signup.jsp">Sign up</a></b>
                        </p>
                    </div>
                </div>

                <div class="col-md-6 widget">
                    <div class="widget-body">
                        <p class="text-right">
                            Copyright &copy; 2018, Developed by <a href="https://vk.com/xxxnikgtxxx" rel="developer">Eliseenko
                            Nikita</a>
                        </p>
                    </div>
                </div>

            </div> <!-- /row of widgets -->
        </div>
    </div>

</footer>
<section id="successMessage">
    <div class="popup">
        <h2>Успешно!</h2>
    </div>
</section>
<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="/resources/userPages/js/headroom.min.js"></script>
<script src="/resources/userPages/js/jQuery.headroom.min.js"></script>
<script src="/resources/userPages/js/hs.js"></script>
</body>
</html>
