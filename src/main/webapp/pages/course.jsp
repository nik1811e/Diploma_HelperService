<%--suppress ALL --%>
<%@ page import="course.CourseInformation" %>
<%@ page import="course.SectionInformation" %>
<%@ page import="course.to.SectionTO" %>
<%@ page import="entity.CourseEntity" %>
<%@ page import="util.CommonUtil" %>
<%@ page import="util.CookieUtil" %>
<%@ page import="util.MailUtil" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>Helper service | Main</title>

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

        String uuidCourse = String.valueOf(request.getParameter("uuidCourse")).trim();
        List<CourseEntity> courseInformationList = null;
        List<SectionTO> sectionTOList = null;
        if (cookieUtil.isFindCookie()) {
            try {
                courseInformationList = new CourseInformation().getCourseInformation(uuidCourse);
                sectionTOList = new SectionInformation().getCourseSection(uuidCourse);
            } catch (Exception ex) {
                new MailUtil().sendErrorMailForAdmin(getClass().getName() + "\n" + Arrays.toString(ex.getStackTrace()));
            }
        } else {
            response.sendRedirect(urlRedirect);
        }

    %>
</head>
<body class="home">
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
                <li><a href="/pages/catalog.jsp">Мои ресурсы</a></li>
                <li class="dropdown">
                    <a href="/pages/users.jsp" class="dropdown-toggle" data-toggle="dropdown">Пользователи<b
                            class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/pages/users.jsp">Список пользователей</a></li>
                        <li><a href="/pages/followings.jsp">Мои подписки</a></li>
                    </ul>
                </li>
                <li><a class="btn" href="/pages/signin.jsp">Авторизация</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>

<!-- Header -->
<!-- /Header -->
<header id="head">
    <div class="container">
        <div class="row">
            <p><a href="#myModal2" id="btn2" class="btn btn-primary">Открыть окно добавления раздела</a></p>
            <div id="myModal2" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" style="color: #3A3A3A">Добавление раздела</h4>
                        </div>
                        <div class="modal-body">
                            <form role="form" method="post" action="/sectionhandler">
                                <input type="hidden" name="uuidCourse" value="<%=request.getParameter("uuidCourse")%>">
                                <div class="form-group">
                                    <input type="text" class="form-control" id="name" name="name" required
                                           maxlength="50" placeholder="Название">
                                </div>
                                <div class="form-group">
                                    <label for="description">Описание</label>
                                    <textarea class="form-control" type="textarea" name="description" id="description"
                                              placeholder="Описание" maxlength="6000" rows="7"></textarea>
                                </div>
                                <button type="submit" class="btn btn-lg btn-success btn-block" id="btnContactUs">
                                    Добавить
                                </button>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="container">
    <ol class="breadcrumb">
        <li><a href="index.jsp">Главная</a></li>
        <li><a href="catalog.jsp">Каталог</a></li>
        <li class="active">Курс</li>
    </ol>
    <div class="text-center">
        <br> <br>
        <h2 class="thin">The best place to tell people why they are here</h2>
        <p class="text-muted">
                <%
        assert courseInformationList != null;
        if (courseInformationList.size() != 0) {
    %>
        <h3><%=courseInformationList.get(0).getUuid()%>
        </h3>
        <h3><%=courseInformationList.get(0).getNameCourse()%>
        </h3>
        <h3><%=courseInformationList.get(0).getStatus()%>
        </h3>
        <h3><%=courseInformationList.get(0).getCategory()%>
        </h3>
        <%
            }
        %>
        </p>
    </div>
</div>

<!-- Highlights - jumbotron -->
<div class="jumbotron top-space">
    <div class="container">

        <h3 class="text-center thin">Разделы курса</h3>

        <div class="row">
            <div class="older">
                <%
                    if (CommonUtil.checkAccess(
                            courseInformationList.get(0).getStatus(),
                            courseInformationList.get(0).getAuthById(),
                            cookieUtil.getUserUuidFromToken(),
                            uuidCourse)
                            )
                    {
                        if(!sectionTOList.isEmpty()){
                        assert sectionTOList != null;
                        for (int i = 0; i < sectionTOList.size(); i++) {
                            String uuidSection = sectionTOList.get(i).getUuidSection();
                            String name = sectionTOList.get(i).getName();
                %>
                <div>
                    <a href="/pages/section.jsp?uuidCourse=<%=uuidCourse%>&&uuidSection=<%=uuidSection%>"><%=name%>
                    </a>
                </div>
                <%}}else {%>
                <h2 class="text-center thin">Пусто</h2>
                <%}%>
                <%} else {%>
                <div class=text-center>
                    <h2 class="thin">Доступ к курсу имеет ограниченное число пользоватей</h2>
                    <p class="text-muted">Для доступа к содержимому курса сделайте запрос.</p>
                </div>
                <%}%>
            </div>
        </div>

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
<script>
    $(function () {
        $("#btn2").click(function () {
            $("#myModal2").modal('show');
        });
    });
</script>
</body>
</html>