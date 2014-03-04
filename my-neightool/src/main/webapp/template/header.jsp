<%@include file="../constantes.jsp" %>
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<meta name="description" content="">
    	<meta name="author" content="">
		<link rel="icon" type="image/png" href="./dist/img/favicon.png" />
	
	    <title><% out.print(siteName); %></title>
	
	    <!-- Bootstrap core CSS -->
	    <link href="./dist/css/bootstrap.min.css" rel="stylesheet">
	    <link href="./dist/css/jumbotron.css" rel="stylesheet">
	
		<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.12/angular.js"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.12/angular-animate.js"></script>
	    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	    <script src="./dist/js/bootstrap.min.js"></script>
	    <script src="./dist/js/config.js"></script>
	    <script type="text/javascript">
			$(document).ready(function() {
		    	$(".ttipl").tooltip({placement: "left",container: 'body'});
		    	$(".ttipr").tooltip({placement: "right",container: 'body'});
		    	$(".ttipt").tooltip({placement: "top",container: 'body'});
		    	$(".ttipb").tooltip({placement: "bottom",container: 'body'});
		    });
	    </script>
	
	    <!-- Just for debugging purposes. Don't actually copy this line! -->
	    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
	    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	    <!--[if lt IE 9]>
	      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
		<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAsO96nmOiM5A5mef1oNv4PZoETDWvfJ88&sensor=false"></script>
	</head>
	
	<body>
		<div class="navbar navbar-default navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="dashboard.jsp"><% out.print(siteName); %></a>
				</div>
				<div class="navbar-collapse collapse">
					<form class="navbar-form navbar-left" method="GET" action="dashboard.jsp?page=search">
						<div class="input-group">
							<input type="text" id="searchField" class="form-control" placeholder="Rechercher">
							<span class="input-group-btn">
								<button class="btn btn-default ttipb" type="submit" data-toggle="tooltip" title="Lancer la recherche""><span class="glyphicon glyphicon-search"></span></button>
								<button class="btn btn-default ttipb" type="button" data-toggle="tooltip" title="Recherche avanc�e" href="dashboard.jsp?page=search"><span class="glyphicon glyphicon-plus"></span></button>
							</span>
						</div>
					</form>
					<ul class="nav navbar-nav navbar-right" style="margin-right:2px;">
	        			<li><a href="dashboard.jsp">Accueil</a></li>
	        			<li><a href="dashboard.jsp?page=manageItems">Mes objets</a></li>
	        			<li><a href="dashboard.jsp?page=mailbox">Mes messages <span class="badge">0</span></a></li>
        				<li><a href="dashboard.jsp?page=account">Mon compte</a></li>
        				<li><a href="index.jsp?attemp=0">D�connexion</a></li>
					</ul>
				</div>
			</div>
		</div>