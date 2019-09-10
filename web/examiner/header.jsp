<!DOCTYPE html>
<html>
<head>
        <title>Examiner</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">        
        <!--bootstrap css--> 
        <link rel="stylesheet" type="text/css" href="../ui_css/bootstrap.min.css"/>
        <!--jquery-->
        <script src="../ui_js/jquery.min.js"></script>
        <!--bootstrap js-->
        <script src="../ui_js/bootstrap.min.js"></script>        
        <!--custom css-->
        <link rel="stylesheet" type="text/css" href="../ui_css/ui_css.css">
        <!-- Font Awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
<!-- Material Design Bootstrap -->
<link href="./../ui_css/mdb.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-primary animated bounceInDown" style="z-index: 1000">
  <a class="navbar-brand text-white" href="home.jsp">Hello <%=session.getAttribute("username")%></a>
  <button class="navbar-toggler text-white" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link text-white" href="home.jsp">Home<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="addstudent.jsp">Student<span class="sr-only"></span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="view_report.jsp">View report</a>
      </li>      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Profile
        </a>
        <div class="dropdown-menu animated bounceIn" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Update profile</a>
          <a class="dropdown-item" href="#">Reset password</a>
          <div class="dropdown-divider"></div>
            <form class="dropdown-item form-inline my-2 my-lg-0" action="../logout.jsp">
              <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Logout</button>
            </form>          
        </div>
      </li>
    </ul>
  </div>
</nav>