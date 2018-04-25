<%--suppress ALL --%>
<html>
<head>
    <title> Profile</title>
</head>
<body>
<%--suppress ALL --%>
<%@ page import="entity.AuthInfEntity" %>
<%@ page import="util.CookieUtil" %>
<%@ page import="util.MailUtil" %>
<%@ page import="util.MethodUtil" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
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

    <link href="/resources/userPages/css/paper.css" rel="stylesheet"/>
    <link href="/resources/userPages/css/animate.min.css" rel="stylesheet"/>

    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="/resources/userPages/css/main_form.css" rel="stylesheet"/>

    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <%
        CookieUtil cookieUtil = new CookieUtil(request);
        String myUuid = cookieUtil.getUserUuidFromToken();

        String urlRedirect = "/pages/signin.jsp";
        String fbutton_text = "Подписаться";
        if (MethodUtil.isExistFollowing(myUuid, request.getParameter("uuidAuth"))) {
            fbutton_text = "Отписаться";
        }
        List<AuthInfEntity> authInfEntityList = null;
        if (cookieUtil.isFindCookie()) {
            try {
                authInfEntityList = MethodUtil.getAuthInfByUuid(request.getParameter("uuidAuth"));
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
                        <li><a href="/pages/followings.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Мои подписки</a></li>
                    </ul>
                <li><a href="/pages/requests.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Запросы</a></li>
                </li>
                <%if (!cookieUtil.isFindCookie()) {%>
                <li><a class="btn" href="#">Авторизация</a></li>
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
            <h2 style="color: #ffffff;">Добро пожаловать,<%=authInfEntityList.get(0).getFName()%>
            </h2>
        </div>
    </div>
</header>
<!-- /Header -->

<!-- Intro -->
<div class="container">
    <ol class="breadcrumb">
        <li><a href="index.jsp">Главная</a></li>
        <li class="active"><a href="#">Профиль</a></li>
    </ol>
    <br><br>
    <div class="text-center">
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-4 col-md-5">
                        <div class="card card-user">
                            <div class="image">
                                <img src="/resources/userPages/images/background.jpg" alt="..."/>
                            </div>
                            <div class="content">
                                <div class="author">
                                    <img class="avatar border-white" src="/resources/userPages/images/avatar.png"
                                         alt="..."/>
                                    <h4 class="title"><%=authInfEntityList.get(0).getFName()%> <%=authInfEntityList.get(0).getLName()%>
                                        <br/>
                                        <a href="#">
                                            <small><%=authInfEntityList.get(0).getEmail()%>
                                            </small>
                                        </a>
                                    </h4>
                                </div>
                                <br>
                                <%if (!cookieUtil.getUserUuidFromToken().equals(authInfEntityList.get(0).getUuid())) {%>
                                <form method="post" action="/follow">
                                    <input type="hidden" name="uuidFollower"
                                           value="<%=cookieUtil.getUserUuidFromToken()%>">
                                    <input type="hidden" name="uuidFollowing"
                                           value="<%=authInfEntityList.get(0).getUuid()%>">
                                    <input type="submit" class="btn btn-info btn-fill btn-wd"
                                           value="<%=fbutton_text%>">
                                </form>
                                <%}%>
                                <br>
                            </div>
                            <div class="text-center">
                                <div class="row">
                                    <div class="col-md-3 col-md-offset-1">
                                        <h5><small><a href="/pages/catalog.jsp?uuidAuth=<%=request.getParameter("uuidAuth")%>"style="text-decoration: none; color: #999999">Курсы</a></small></h5>
                                    </div>
                                    <div class="col-md-4">
                                        <h5><small><a href="/pages/followings.jsp?uuidAuth=<%=request.getParameter("uuidAuth")%>" style="text-decoration: none; color: #999999">Подписки</a></small></h5>
                                    </div>
                                    <div class="col-md-3">
                                        <h5><small><a href="/pages/followers.jsp?uuidAuth=<%=request.getParameter("uuidAuth")%>"style="text-decoration: none; color: #999999">Подпищики</a></small></h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-7">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Изменить профиль</h4>
                            </div>
                            <div class="content">
                                <form method="post" action="/editprofile">
                                    <input type="hidden" name="uuid" value="<%=cookieUtil.getUserUuidFromToken()%>">
                                    <input type="hidden" name="bday" value="<%=authInfEntityList.get(0).getBDay()%>">
                                    <input type="hidden" name="statusO"
                                           value="<%=authInfEntityList.get(0).getRole() %>">
                                    <input type="hidden" name="dateReg"
                                           value="<%=authInfEntityList.get(0).getDateReg()%>">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>Статус</label>
                                                <input type="text" class="form-control border-input" disabled
                                                       placeholder="status" name="status"
                                                       value="<%=authInfEntityList.get(0).getRole()%>">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Логин</label>
                                                <input type="text" class="form-control border-input" placeholder="login"
                                                       value="<%=authInfEntityList.get(0).getLogin()%>" name="login">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Email</label>
                                                <input type="email" class="form-control border-input"
                                                       placeholder="<%=authInfEntityList.get(0).getEmail()%>"
                                                       name="email">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Имя</label>
                                                <input type="text" class="form-control border-input"
                                                       placeholder="First name"
                                                       value="<%=authInfEntityList.get(0).getFName()%>" name="fname">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Фамилия</label>
                                                <input type="text" class="form-control border-input"
                                                       placeholder="Last Name"
                                                       value="<%=authInfEntityList.get(0).getLName()%>" name="lname">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>Пароль</label>
                                                <input type="password" class="form-control border-input"
                                                       placeholder="password" name="password">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>Обо мне</label>
                                                <textarea rows="5" class="form-control border-input"
                                                          placeholder="Здесь вы можете написать о себе"
                                                          value="<%=authInfEntityList.get(0).getAbout()%>"
                                                          name="desc"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <%if (authInfEntityList.get(0).getUuid().equals(cookieUtil.getUserUuidFromToken())) {%>
                                        <button type="submit" class="btn btn-info btn-fill btn-wd">Update Profile
                                        </button>
                                        <%}%>
                                    </div>
                                    <div class="clearfix"></div>
                                </form>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>
<!-- /Intro-->

<!-- Highlights - jumbotron -->
<div class="jumbotron top-space">
    <div class="container">

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

<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="/resources/userPages/js/headroom.min.js"></script>
<script src="/resources/userPages/js/jQuery.headroom.min.js"></script>
<script src="/resources/userPages/js/hs.js"></script>
<script src="/resources/userPages/js/paper.js"></script>
<script src="/resources/userPages/js/form_main.js"></script>


</body>
</html>

</body>
</html>