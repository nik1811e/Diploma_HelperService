<%--suppress ALL --%>
<%@ page import="course.pojo.ResourceTO" %>
<%@ page import="course.pojo.SectionTO" %>
<%@ page import="course.resources.ResourceInformation" %>
<%@ page import="course.sections.SectionInformation" %>
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

    <%
        CookieUtil cookieUtil = new CookieUtil(request);
        String urlRedirect = "/pages/signin.jsp";
        ResourceTO resource = null;
        List<SectionTO> sections = null;
        String uuidCourse = null;
        String uuidSection = null;
        String uuidResource = null;
        SectionTO sectionInformations = null;
        if (cookieUtil.isFindCookie()) {
            uuidCourse = String.valueOf(request.getParameter("uuidCourse")).trim();
            uuidSection = String.valueOf(request.getParameter("uuidSection")).trim();
            uuidResource = String.valueOf(request.getParameter("uuidResource")).trim();
            sections = new SectionInformation().getCourseSection(uuidCourse);
/*
            sectionInformations = new SectionInformation().getSectionInformation(uuidCourse, uuidSection);
*/
            try {
                resource = new ResourceInformation().getResourceInformation(uuidCourse, uuidSection, uuidResource);
            } catch (Exception ex) {
                new MailUtil().sendErrorMailForAdmin(getClass().getName() + "\n" + Arrays.toString(ex.getStackTrace()));
            }
        } else {
            response.sendRedirect(urlRedirect);
        }
        assert resource != null;
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
                <li><a href="/pages/catalog.jsp">Мои ресурсы</a></li>
                <li class="dropdown">
                    <a href="/pages/users.jsp" class="dropdown-toggle" data-toggle="dropdown">Пользователи<b
                            class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/pages/users.jsp">Список пользователей</a></li>
                        <li><a href="/pages/followings.jsp">Мои подписки</a></li>
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
        <li><a href="catalog.jsp?uuidAuth=<%=request.getParameter("uuidAuth")%>">Ресурсы</a></li>
        <li><a href="course.jsp?uuidAuth=<%=request.getParameter("uuidAuth")%>&&uuidCourse=<%=uuidCourse%>"><%=MethodUtil.getCourseNameByUuid(uuidCourse)%>
        </a></li>
        <li>
            <a href="section.jsp?uuidAuth=<%=request.getParameter("uuidAuth")%>&&uuidCourse=<%=uuidCourse%>&&uuidSection=<%=uuidSection%>"><%=new MethodUtil().getSectionNameByUuid(uuidCourse, uuidSection)%>
            </a>
        </li>
        <li class="active"><%=resource.getName()%>
        </li>
    </ol>
    <div class="text-center">
        <br> <br>
        <h2 class="thin">Информация ресурса</h2>
        <table class="table table-dark">
            <thead>
            <tr>
                <th scope="col">Название</th>
                <th scope="col">Ссылка</th>
                <th scope="col">Автор</th>
                <th scope="col">Описание</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><%=resource.getName()%>
                </td>
                <td><a href="<%=resource.getLink()%>" style="text-decoration: none"><%=resource.getLink()%>
                </a></td>
                <td><%=resource.getAuthor()%>
                </td>
                <td><%=resource.getDescriptionResource()%>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <%if (cookieUtil.getUserUuidFromToken().equals(request.getParameter("uuidAuth"))) {%>
    <p><a href="#myModal2" id="btn2" class="btn btn-primary">Сделать копию ссылки</a></p>
    <div id="myModal2" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" style="color: #3A3A3A">Копирование ссылки</h4>
                </div>
                <div class="modal-body">
                    <form role="form" method="post" action="/resourcehandler">
                        <input type="hidden" name="uuidCourse" value="<%=request.getParameter("uuidCourse")%>">
                        <div class="form-group">
                            <input type="text" class="form-control" id="name_resource" name="name_resource"
                                   required
                                   maxlength="50" placeholder="Название" value="<%=resource.getName()%>">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" name="link" required
                                   maxlength="50"
                                   value="<%=resource.getLink()%>">
                        </div>
                        <div class="form-group">
                            <h4 style="color: #3A3A3A">Из</h4> <input type="text" class="form-control"
                                                                      id="currentSection"
                                                                      name="currentSection"
                                                                      required
                                                                      maxlength="50"
                                                                      value="<%=new MethodUtil().getSectionNameByUuid(uuidCourse,resource.getUuidSection())%>"
                                                                      disabled>
                        </div>
                        <div class="form-group">
                            <h4 style="color: #3A3A3A">В</h4> <select class="form-control" id="uuidSection"
                                                                      name="uuidSection">
                            <option value="" disabled selected>Выберите раздел</option>
                            <%
                                assert sections != null;
                                for (int i = 0; i < sections.size(); i++) {
                                    String uuid = sections.get(i).getUuidSection();
                                    String name = sections.get(i).getName();
                                    if (!uuid.equals(uuidSection)) {
                            %>
                            <option value="<%=uuid%>"><%=name%>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                        </div>
                        <input type="hidden" class="form-control" id="author" name="author"
                               value="<%=resource.getAuthor()%>">
                        <input type="hidden" id="id_category" name="id_category"
                               value="<%=resource.getCategory_link()%>">
                        <input class="form-control" type="hidden" name="desc" id="desc"
                               value="<%=resource.getDescriptionResource()%>">
                        <button type="submit" class="btn btn-lg btn-success btn-block" id="btnContactUs">
                            Добавить
                        </button>
                    </form>
                </div>

            </div>
        </div>
    </div>

    <p><a href="#myModal1" id="btn1" class="btn btn-primary">Удалить ресурс</a></p>
    <div id="myModal1" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" style="color: #3A3A3A">Вы действительно хотите удалить?</h4>
                </div>
                <div class="modal-body">
                    <form role="form" method="post" action="/resourceremoving">
                        <input type="hidden" name="uuidSectionDel" value="<%=uuidSection%>">
                        <input type="hidden" name="uuidCourseDel" value="<%=uuidCourse%>">
                        <input type="hidden" name="uuidResourceDel" value="<%=uuidResource%>">
                        <button type="submit" class="btn btn-lg btn-success btn-block" id="btnContactUs">
                            Удалить
                        </button>
                    </form>
                </div>

            </div>
        </div>
    </div>
    <%}%>
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
<script>
    $(function () {
        $("#btn1").click(function () {
            $("#myModal1").modal('show');
        });
    });
</script>
</body>
</html>
