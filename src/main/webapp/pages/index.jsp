<%@ page import="util.CookieUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>

    <title>Helper service | Main</title>

    <link rel="shortcut icon" href="/resources/userPages/images/gt_favicon.png">

    <link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
    <link rel="stylesheet" href="/resources/userPages/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/userPages/css/font-awesome.min.css">

    <link rel="stylesheet" href="/resources/userPages/css/bootstrap-theme.css" media="screen">
    <link rel="stylesheet" href="/resources/userPages/css/main.css">

    <script src="/resources/userPages/js/html5shiv.js"></script>
    <script src="/resources/userPages/js/respond.min.js"></script>
    <%
        CookieUtil cookieUtil = new CookieUtil(request);
        String uuidAuth = "unknown";
        if (cookieUtil.getUserUuidFromToken() != null) {
            uuidAuth = cookieUtil.getUserUuidFromToken();
        }
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
                <li class="active"><a href="#">Главная</a></li>
                <li><a href="/pages/catalog.jsp?uuidAuth=<%=uuidAuth%>">Ресурсы</a></li>
                <li class="dropdown">
                    <a href="/pages/users.jsp" class="dropdown-toggle" data-toggle="dropdown">Пользователи<b
                            class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/pages/users.jsp">Список пользователей</a></li>
                        <li><a href="/pages/followings.jsp?uuidAuth=<%=uuidAuth%>">Мои
                            подписки</a></li>
                    </ul>
                </li>
                <li><a href="/pages/requests.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Запросы</a></li>

                <%if (!cookieUtil.isFindCookie()) {%>
                <li><a class="btn" href="/pages/signin.jsp">Авторизация</a></li>
                <%} else {%>
                <li><a class="btn" href="/pages/profile.jsp?uuidAuth=<%=uuidAuth%>">Профиль</a>
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
<div class="container text-center">
    <br> <br>
    <h2 class="thin">Сервис каталогизации ссылок самообучения</h2>
    <p class="text-muted">
        Веб-сервис информационной поддержки самообучения, позволяющий объединить и сгруппировать учебный материал
        различных областей в одном месте, создавать курсы и разделы курсов, хранить информацию в виде ссылок,
        обмениваться ресурсами, тем самым организовать взаимодействие между пользователями. Особенностью данного ресурса
        является возможность самостоятельно структурировать курс и добавлять ссылки с описанием в определенные разделы
        курса, что позволяет каждому пользователю упорядочить свои закладки и быстро найти нужный материал.
    </p>
</div>
<!-- /Intro-->
<!-- Highlights - jumbotron -->
<div class="jumbotron top-space">
    <div class="container">

        <h3 class="text-center thin">Reasons to use this template</h3>

        <div class="row">
            <a href="/pages/catalog.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>" style="text-decoration: none;color: #000 !important;">
                <div class="col-md-3 col-sm-6 highlight">
                    <div class="h-caption"><h4><i class="fa fa-cogs fa-5"></i>Мои ресурсы</h4></div>

                    <div class="h-body text-center">
                        <p>Данный раздел хранит список ваших ресурсов</p>
                    </div>
                </div>
            </a>
            <a href="/pages/users.jsp" style="text-decoration: none;color: #000 !important;">
                <div class="col-md-3 col-sm-6 highlight">
                    <div class="h-caption"><h4><i class="fa fa-flash fa-5"></i>Пользователи</h4></div>
                    <div class="h-body text-center">
                        <p>Найти друзей</p>
                    </div>
                </div>
            </a>
            <a href="/pages/requests.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>" style="text-decoration: none; color: #000 !important;">
                <div class="col-md-3 col-sm-6 highlight">
                    <div class="h-caption"><h4><i class="fa fa-heart fa-5"></i>Запросы</h4></div>
                    <div class="h-body text-center">
                        <p>Список понравившихся курсов</p>
                    </div>
                </div>
            </a>
            <a href="/pages/followings.jsp?uuidAuth=<%=uuidAuth%>" style="text-decoration: none;color: #000 !important;">
                <div class="col-md-3 col-sm-6 highlight">
                    <div class="h-caption"><h4><i class="fa fa-smile-o fa-5"></i>Мои подписки</h4></div>
                    <div class="h-body text-center">
                        <p>Перейти к разделу друзей</p>
                    </div>
                </div>
            </a>
        </div> <!-- /row  -->

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
</body>
</html>
