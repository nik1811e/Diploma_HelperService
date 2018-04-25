<%--suppress ALL --%>
<%@ page import="course.courses.CourseInformation" %>
<%@ page import="course.courses.RequestInformation" %>
<%@ page import="course.pojo.RequestTO" %>
<%@ page import="course.pojo.SectionTO" %>
<%@ page import="course.sections.SectionInformation" %>
<%@ page import="entity.CourseEntity" %>
<%@ page import="util.CookieUtil" %>
<%@ page import="util.MailUtil" %>
<%@ page import="util.MethodUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>

    <title>Helper service | Course</title>
    <link rel="shortcut icon" href="/resources/userPages/images/gt_favicon.png">

    <link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
    <link rel="stylesheet" href="/resources/userPages/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/userPages/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/userPages/css/list.css">

    <link rel="stylesheet" href="/resources/userPages/css/bootstrap-theme.css" media="screen">
    <link rel="stylesheet" href="/resources/userPages/css/main.css">
    <link rel="stylesheet" href="/resources/userPages/css/style1.css">
    <link rel="stylesheet" href="/resources/userPages/css/style_common.css">

    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'/>
    <script src="/resources/userPages/js/html5shiv.js"></script>
    <script src="/resources/userPages/js/respond.min.js"></script>

    <%
        CookieUtil cookieUtil = new CookieUtil(request);
        String urlRedirect = "/pages/signin.jsp";

        String uuidCourse = String.valueOf(request.getParameter("uuidCourse")).trim();
        List<CourseEntity> courseInformationList = null;
        List<SectionTO> sectionTOList = null;
        List<RequestTO> requests = new ArrayList<>();
        boolean exist = false;
        if (cookieUtil.isFindCookie()) {
            try {
                requests = new RequestInformation().getRequets(request.getParameter("uuidAuth"));
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
                <li><a href="/pages/catalog.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Ресурсы</a></li>
                <li class="dropdown">
                    <a href="/pages/users.jsp" class="dropdown-toggle" data-toggle="dropdown">Пользователи<b
                            class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/pages/users.jsp">Список пользователей</a></li>
                        <li><a href="/pages/followings.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Мои
                            подписки</a></li>
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

<!-- Header -->
<!-- /Header -->
<header id="head">
    <div class="container">
        <div class="row">
            <h1 style="color: #ffffff;">Бесплатный сервис хранения ссылок и закладок!</h1>
            <%if(cookieUtil.getUserUuidFromToken().equals(request.getParameter("uuidAuth"))){%>
            <p><a href="#myModal2" id="btn2" class="btn btn-primary">Добавить раздел</a></p>
            <div id="myModal2" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" style="color: #3A3A3A">Добавление раздела</h4>
                        </div>
                        <div class="modal-body">
                            <form role="form" method="post" action="/sectionhandler">
                                <input type="hidden" name="uuidAuth" value="<%=request.getParameter("uuidAuth")%>">

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
                                <button type="submit" class="btn btn-lg btn-success btn-block" id="btnAddSection">
                                    Добавить
                                </button>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
            <%}%>
        </div>
    </div>
</header>

<div class="container">
    <ol class="breadcrumb">
        <li><a href="index.jsp">Главная</a></li>
        <li><a href="catalog.jsp?uuidAuth=<%=request.getParameter("uuidAuth")%>">Каталог</a></li>
        <li class="active"><%=courseInformationList.get(0).getNameCourse()%>
        </li>
    </ol>
    <div class="text-center">
        <br> <br>
        <h2 class="thin">Информация курса</h2><br>
        <table class="table table-striped table-inverse">
            <thead>
            <tr>
                <th>Название</th>
                <th>Статус</th>
                <th>Катерория</th>
            </tr>
            </thead>
            <%
                assert courseInformationList != null;
                if (courseInformationList.size() != 0) {
            %>
            <tbody>
            <tr>
                <td><%=courseInformationList.get(0).getNameCourse()%>
                </td>
                <td><%=courseInformationList.get(0).getStatus()%>
                </td>
                <td><%=MethodUtil.getNameCourseCategoryByid(courseInformationList.get(0).getCategory())%>
                </td>
            </tr>
            </tbody>
            <%
                }
            %>
        </table>
    </div>
</div>

<!-- Highlights - jumbotron -->
<div class="jumbotron top-space">
    <div class="container">

        <h3 class="text-center thin">Разделы курса</h3>
        <div class="row">
            <%
                if (MethodUtil.checkAccess(
                        courseInformationList.get(0).getStatus(),
                        courseInformationList.get(0).getAuthById(),
                        cookieUtil.getUserUuidFromToken(),
                        uuidCourse)
                        ) {
                    if (!sectionTOList.isEmpty()) {
                        assert sectionTOList != null;
                        for (int i = 0; i < sectionTOList.size(); i++) {
                            String uuidSection = sectionTOList.get(i).getUuidSection();
                            String name = sectionTOList.get(i).getName();
                            int count = sectionTOList.get(i).getResource().size();
            %>
            <div class="col-md-3 col-sm-6 highlight">
                <div class="view view-first" style="background-image: url('/resources/userPages/images/courseimg.jpg')">
                    <%-- <img src="/resources/userPages/images/courseimg.jpg"/>--%>
                    <span style="color: #999999; font-size: 15px"><%=name%></span>
                    <div class="mask">
                        <h2><%=new MethodUtil().getCourseNameByUuid(sectionTOList.get(i).getUuidCourse())%>
                        </h2>
                        <p>Ссылок : <%=count%>
                        </p>
                        <a href="/pages/section.jsp?uuidAuth=<%=request.getParameter("uuidAuth")%>&&uuidCourse=<%=uuidCourse%>&&uuidSection=<%=uuidSection%>"
                           class="info">Открыть раздел</a>
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <h2 class="text-center thin">Пусто</h2>
            <%}%>
            <%} else {%>
            <div class=text-center>
                <h2 class="thin">Доступ к курсу имеет ограниченное число пользоватей</h2>
                <p class="text-muted">Для доступа к содержимому курса сделайте запрос.</p>
            </div>
            <%
                for (RequestTO reqst : requests) {
                    if (reqst.getUuidAuth().equals(cookieUtil.getUserUuidFromToken()) &&
                            reqst.getUuidCourse().equals(courseInformationList.get(0).getUuid())) {
                        exist = true;
                    }
                }
            %>
            <%if (!exist) {%>
            <form action="/courserequest" method="post">
                <input type="hidden" name="uuidCourseReq" value="<%=uuidCourse%>">
                <input type="hidden" name="uuidAuthReq" value="<%=cookieUtil.getUserUuidFromToken()%>">
                <input type="hidden" name="uuidAuthOwner" value="<%=request.getParameter("uuidAuth")%>">
                <button type="submit" class="btn btn-sm btn-warning btn-block" id="btnRequest">
                    Запросить курс
                </button>
            </form>
            <%}else{%>
            <h2 class="text-center thin">Запрос в обработке</h2>
            <%}}%>
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