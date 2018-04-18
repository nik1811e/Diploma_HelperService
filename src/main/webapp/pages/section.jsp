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

    <%--   <%
           CookieUtil cookieUtil = new CookieUtil(request);
           CourseInformation courseInformation = null;

           List<CourseEntity> courseInformationList = null;
           CourseStructureTO courseStructureTO = null;
           List<SectionTO> sectionTOList = null;
           try {
               courseInformation = new CourseInformation(request.getParameter("uuid"));
               courseInformationList = courseInformation.getCourseInformationByUuid();
               sectionTOList = courseStructureTO.getSection();

           } catch (Exception ex) {
               new MailUtil().sendErrorMailForAdmin(getClass().getName() + "\n" + Arrays.toString(ex.getStackTrace()));
           }

       %>--%>

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
                <li class="active"><a href="#">Главная</a></li>
                <li><a href="/pages/catalog.jsp">Мои ресурсы</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">More Pages <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="sidebar-left.html">Left Sidebar</a></li>
                        <li class="active"><a href="sidebar-right.html">Right Sidebar</a></li>
                    </ul>
                </li>
                <li><a href="contact.html">Contact</a></li>
                <li><a class="btn" href="/pages/signin.jsp">Авторизация</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>

<!-- Header -->
<header id="head">
    <div class="container">
        <div class="row">
            <div class="modal-body">
                <form role="form" method="post" action="/resourcehandler">
                    <div class="form-group">
                        <label for="name_resource">Название</label>
                        <input type="text" class="form-control" id="name_resource" name="name_resource" required maxlength="50">
                    </div>
                    <div class="form-group">
                        <label for="link">Ссылка на ресурс</label>
                        <input type="url" class="form-control" id="link" name="link" required maxlength="70">
                    </div>
                    <div class="form-group">
                        <label for="author">Автор</label>
                        <input type="text" class="form-control" id="author" name="author" required maxlength="70">
                    </div>
                    <div class="form-group">
                        <label for="uuid_section">Секция (тестовое поле)</label>
                        <input type="text" class="form-control" id="uuid_section" name="uuid_section" required maxlength="70">
                    </div>
                    <div class="form-group">
                        <label for="uuid_course">Курс (тестовое поле)</label>
                        <input type="text" class="form-control" id="uuid_course" name="uuid_course" required maxlength="70">
                    </div>
                    <div class="form-group">
                        <label for="desc">Описание</label>
                        <textarea class="form-control" type="textarea" name="desc" id="desc"
                                  placeholder="Your Message Here" maxlength="6000" rows="7"></textarea>
                    </div>
                    <button type="submit" class="btn btn-lg btn-success btn-block" id="btnContactUs">Добавить</button>
                </form>
                <div id="success_message" style="width:100%; height:100%; display:none; "><h3>Sent your message
                    successfully!</h3></div>
                <div id="error_message" style="width:100%; height:100%; display:none; "><h3>Error</h3> Sorry there was
                    an error sending your form.
                </div>
            </div>
        </div>
    </div>
</header>
<!-- /Header -->

<!-- Highlights - jumbotron -->
<div class="jumbotron top-space">
    <div class="container">

        <h3 class="text-center thin">Reasons to use this template</h3>

        <div class="row">
            <div class="older">
                <div>
                <a href="#">Test</a>
            </div>
                <div>
                    <a href="#">Test</a>
                </div>
                <div>
                    <a href="#">Test</a>
                </div>
                <div>
                    <a href="#">Test</a>
                </div>
                <div>
                    <a href="#">Test</a>
                </div>

                <%--  <%
                      assert courseInformationList != null;
                      for (int i = 1; i < sectionTOList.size(); i++) {
                          String name = sectionTOList.get(i).getName();
                  %>--%>

                <%-- <%
                     }
                 %>--%>
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
                    <h3 class="widget-title">Contact</h3>
                    <div class="widget-body">
                        <p>+234 23 9873237<br>
                            <a href="mailto:#">some.email@somewhere.com</a><br>
                            <br>
                            234 Hidden Pond Road, Ashland City, TN 37015
                        </p>
                    </div>
                </div>

                <div class="col-md-3 widget">
                    <h3 class="widget-title">Follow me</h3>
                    <div class="widget-body">
                        <p class="follow-me-icons">
                            <a href=""><i class="fa fa-twitter fa-2"></i></a>
                            <a href=""><i class="fa fa-dribbble fa-2"></i></a>
                            <a href=""><i class="fa fa-github fa-2"></i></a>
                            <a href=""><i class="fa fa-facebook fa-2"></i></a>
                        </p>
                    </div>
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
                            <a href="about.html">About</a> |
                            <a href="sidebar-right.html">Sidebar</a> |
                            <a href="contact.html">Contact</a> |
                            <b><a href="signup.html">Sign up</a></b>
                        </p>
                    </div>
                </div>

                <div class="col-md-6 widget">
                    <div class="widget-body">
                        <p class="text-right">
                            Copyright &copy; 2014, Your name. Designed by <a href="http://gettemplate.com/"
                                                                             rel="designer">gettemplate</a>
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
<script src="/resources/userPages/js/template.js"></script>
</body>
</html>


