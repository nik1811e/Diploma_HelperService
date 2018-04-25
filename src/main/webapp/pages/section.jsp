<%--suppress ALL --%>
<%@ page import="course.sections.SectionInformation" %>
<%@ page import="course.resources.ResourceInformation" %>
<%@ page import="course.pojo.ResourceTO" %>
<%@ page import="course.pojo.SectionTO" %>
<%@ page import="entity.ResourceCategoryEntity" %>
<%@ page import="util.MethodUtil" %>
<%@ page import="util.CookieUtil" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>

    <title>Helper service | Section</title>

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

        List<ResourceTO> resourceTOList = null;
        List<ResourceCategoryEntity> resourceCategoryList = null;
        String uuidCourse = String.valueOf(request.getParameter("uuidCourse").trim());
        String uuidSection = String.valueOf(request.getParameter("uuidSection")).trim();
        SectionTO sectionInformation = new SectionInformation().getSectionInformation(uuidCourse, uuidSection);
        if (cookieUtil.isFindCookie()) {
            resourceTOList = new ResourceInformation().getSectionResource(String.valueOf(request.getParameter("uuidSection").trim()),
                    uuidCourse);
            resourceCategoryList = MethodUtil.getResourceCategory();
        } else {
            response.sendRedirect(urlRedirect);
        }
        assert resourceTOList != null;
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
                        <li><a href="/pages/followings.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Мои подписки</a></li>
                    </ul>
                </li>
                <li><a href="/pages/requests.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Запросы</a></li>

                <%if(!cookieUtil.isFindCookie()){%>
                <li><a class="btn" href="/pages/signin.jsp">Авторизация</a></li>
                <%}else{%>
                <li><a class="btn" href="/pages/profile.jsp?uuidAuth=<%=cookieUtil.getUserUuidFromToken()%>">Профиль</a></li>
                <%}%>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>

<!-- Header -->
<header id="head">
    <div class="container">
        <div class="row">
            <h1 style="color: #ffffff;">Бесплатный сервис хранения ссылок и закладок!</h1>
            <%if(cookieUtil.getUserUuidFromToken().equals(request.getParameter("uuidAuth"))){%>
            <p><a href="#myModal2" id="btn2" class="btn btn-primary">Открыть окно добавления ссылки</a></p>
            <div id="myModal2" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" style="color: #3A3A3A">Добавление ссылки</h4>
                        </div>
                        <div class="modal-body">
                            <form role="form" method="post" action="/resourcehandler">
                                <input type="hidden" name="uuidAuth" value="<%=request.getParameter("uuidAuth")%>">

                                <input type="hidden" name="uuidCourse" value="<%=request.getParameter("uuidCourse")%>">
                                <input type="hidden" name="uuidSection"
                                       value="<%=request.getParameter("uuidSection")%>">
                                <div class="form-group">
                                    <input type="text" class="form-control" id="name_resource" name="name_resource"
                                           required
                                           maxlength="50" placeholder="Название">
                                </div>
                                <div class="form-group">
                                    <input type="url"
                                           pattern="_(^|[\s.:;?\-\]<\(])(https?://[-\w;/?:@&=+$\|\_.!~*\|'()\[\]%#,☺]+[\w/#](\(\))?)(?=$|[\s',\|\(\).:;?\-\[\]>\)])_i"
                                           class="form-control" id="link" name="link" required maxlength="70"
                                           placeholder="Ссылка на ресурс">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" id="author" name="author" required
                                           maxlength="70" placeholder="Автор ресурса">
                                </div>
                                <div class="form-group">
                                    <select class="form-control" id="id_category" name="id_category">
                                        <option value="" disabled selected>Выберите категорию</option>
                                        <%
                                            assert resourceCategoryList != null;
                                            for (int i = 0; i < resourceCategoryList.size(); i++) {
                                                int id = resourceCategoryList.get(i).getId();
                                                String name = resourceCategoryList.get(i).getName();

                                        %>
                                        <option value="<%=id%>"><%=name%>
                                        </option>
                                        <%}%>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <textarea class="form-control" type="textarea" name="desc" id="desc"
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
            <%}%>
        </div>
    </div>
</header>
<!-- /Header -->
<div class="container">
    <ol class="breadcrumb">
        <li><a href="index.jsp">Главная</a></li>
        <li><a href="catalog.jsp?uuidAuth=<%=request.getParameter("uuidAuth")%>">Каталог</a></li>
        <li><a href="course.jsp?uuidAuth=<%=request.getParameter("uuidAuth")%>&&uuidCourse=<%=uuidCourse%>"><%=MethodUtil.getCourseNameByUuid(uuidCourse)%>
        </a></li>
        <li class="active"><%=sectionInformation.getName()%>
        </li>
    </ol>
    <div class="text-center">
        <br> <br>
        <h2 class="thin">The best place to tell people why they are here</h2>
        <p class="text-muted">
            The difference between involvement and commitment is like an eggs-and-ham breakfast:<br>
            the chicken was involved; the pig was committed.
        </p>
    </div>
</div>
<!-- Highlights - jumbotron -->
<div class="jumbotron top-space">
    <div class="container">
        <h3 class="text-center thin">Ресурсы раздела</h3>
        <div class="row">
            <%
                if (!resourceTOList.isEmpty()) {
                    assert resourceTOList != null;
                    for (ResourceTO aResourceTOList : resourceTOList) {
                        String uuidResource = aResourceTOList.getUuidResource();
                        String name = aResourceTOList.getName();
            %>
            <div class="col-md-3 col-sm-6 highlight">
                <div class="view view-first" style="background-image: url('/resources/userPages/images/courseimg.jpg')">
                    <%-- <img src="/resources/userPages/images/courseimg.jpg"/>--%>
                    <span style="color: #999999; font-size: 15px"><%=name%></span>
                    <div class="mask">
                        <h2><%=new MethodUtil().getNameResourceCategoryByid(aResourceTOList.getCategory_link())%>
                        </h2>
                        <p>
                          Автор: <%=aResourceTOList.getAuthor()%>
                        </p>
                        <a href="/pages/resource.jsp?uuidAuth=<%=request.getParameter("uuidAuth")%>&&uuidCourse=<%=uuidCourse%>&&uuidSection=<%=uuidSection%>&&uuidResource=<%=uuidResource%>" class="info">Открыть раздел</a>
                    </div>
                </div>
            </div>
            <%}}else {%>
            <h2 class="text-center thin">Пусто</h2>
            <%}%>
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


