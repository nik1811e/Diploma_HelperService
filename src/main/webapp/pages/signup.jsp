<%--suppress ALL --%>
<%@ page import="util.CookieUtil" %>
<%@ page import="util.ReCaptchaUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <title>Helper Service | SignUp</title>

    <link rel="shortcut icon" href="/resources/userPages/images/gt_favicon.png">

    <link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
    <link rel="stylesheet" href="/resources/userPages/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/userPages/css/font-awesome.min.css">

    <!-- Custom styles for our template -->
    <link rel="stylesheet" href="/resources/userPages/css/bootstrap-theme.css"
          media="screen">
    <link rel="stylesheet" href="/resources/userPages/css/main.css">

    <script src="/resources/userPages/js/html5shiv.js"></script>
    <script src="/resources/userPages/js/respond.min.js"></script>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <%
        CookieUtil cookieUtil = new CookieUtil(request);
    %>
</head>

<body>
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
                <li><a href="/pages/index.jsp">Главная</a></li>
                <li><a href="/pages/catalog.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Ресурсы</a></li>
                <li class="dropdown">
                    <a href="/pages/users.jsp" class="dropdown-toggle" data-toggle="dropdown">Пользователи<b
                            class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/pages/users.jsp">Список пользователей</a></li>
                        <li><a href="/pages/followings.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Мои подписки</a></li>
                    </ul>
                </li>
                <li><a class="btn" href="/pages/signin.jsp">Авторизация</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<!-- /.navbar -->

<header id="head" class="secondary"></header>

<!-- container -->
<div class="container">

    <ol class="breadcrumb">
        <li><a href="index.jsp">Главная</a></li>
        <li class="active">Регистрация</li>
    </ol>

    <div class="row">
        <!-- Article main content -->
        <article class="col-xs-12 maincontent">
            <header class="page-header">
                <h1 class="page-title">Регистрация</h1>
            </header>

            <div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h3 class="thin text-center">Создание новой учетной записи</h3>
                        <p class="text-center text-muted">Уже есть учетная запись? Пройдите по ссылке <a
                                href="signin.jsp">Login</a> для входа.</p>
                        <hr>

                        <form action="/registration" method="post">
                            <div class="top-margin">
                                <label>Имя</label>
                                <input type="text" class="form-control" name="fname">
                            </div>
                            <div class="top-margin">
                                <label>Фамилия</label>
                                <input type="text" class="form-control" name="lname">
                            </div>
                            <div class="top-margin">
                                <label>Дата рождения</label>
                                <input type="date" class="form-control" name="bday">
                            </div>
                            <div class="top-margin">
                                <label>Логин<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="login">
                            </div>
                            <div class="top-margin">
                                <label>Email<span class="text-danger">*</span></label>
                                <input type="email" class="form-control" name="email">
                            </div>
                            <div class="row top-margin">
                                <div class="col-sm-6">
                                    <label>Пароль <span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" name="password">
                                </div>
                                <div class="col-sm-6">
                                    <label>Подтвердите пароль<span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" name="confirm_password">
                                </div>
                            </div>
                            <br/>
                            <div class="g-recaptcha" data-sitekey="<%=ReCaptchaUtil.PUBLIC%>"></div>
                            <hr>
                            <div class="col-lg-4 text-right">
                                <button class="btn btn-action" type="submit">Создать</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </article>
        <!-- /Article -->

    </div>
</div>    <!-- /container -->


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
</body>
</html>
