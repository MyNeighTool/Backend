<%@include file="constantes.jsp" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>


<%@ page import="javax.xml.bind.JAXBContext"%>
<%@ page import="javax.xml.bind.Marshaller"%>
<%@ page import="javax.xml.bind.Unmarshaller"%>

<%@ page import="java.io.StringReader"%>
<%@ page import="java.io.StringWriter"%>

<%@ page import="org.jboss.resteasy.client.ClientRequest"%>
<%@ page import="org.jboss.resteasy.client.ClientResponse"%>


<%@ page import="model.Utilisateur"%>
<%@ page import="model.Connexion"%>
<%@ page import="model.Adresse"%>




<%
boolean actionValid = false;
String messageType = "";
String messageValue = "";
if(request.getParameter("attemp") != null){
	actionValid = true;
	if(request.getParameter("signIn") != null) {
		System.out.println("CONNECTION EN COURS");
		/*Contexte*/
		JAXBContext jaxbc=JAXBContext.newInstance(Connexion.class);
		
		/*On cr�� une tentative de connexion avec les logins et mdp entr�s*/
		final Connexion connexion = new Connexion(request.getParameter("login_username"),request.getParameter("login_password"));
		
		System.out.println(request.getParameter("login_username")+" "+request.getParameter("login_password"));
		/*On s�rialise*/
		final Marshaller marshaller = jaxbc.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_ENCODING, "UTF-8");
		final java.io.StringWriter sw = new StringWriter();
		marshaller.marshal(connexion, sw);
		
		/*On envoie la requete au webservice*/
		final ClientRequest clientRequest = new ClientRequest("http://localhost:8080/rest/connection/try");
		clientRequest.body("application/xml", sw.toString());
		
		/*on r�cup�re la r�ponse de la requete*/
		final ClientResponse<String> clientResponse = clientRequest.post(String.class);
		System.out.println("\n\n"+clientResponse.getEntity()+"\n\n");
				
		if (clientResponse.getStatus() == 200) {
			
				//Si on r�cup�re un ID
				try {
					Integer.parseInt(clientResponse.getEntity());
					
					messageType = "success";
					messageValue = "Connexion r�ussie";
					
				
					//Sinon c'est que les identifiants sont mauvais
				} catch (NumberFormatException e){
					messageValue = "Echec de la connexion, login ou mot de passe incorrect";
					messageType = "danger";
				}		
		}
		else
		{
			messageValue = "Probl�me de connexion, ressayez plus tard";
			messageType = "danger";
		}
	} else if(request.getParameter("signUp") != null) {
		
		
		//on a besoin du contexte si on veut serialiser/d�s�rialiser avec jaxb
		JAXBContext jaxbc=JAXBContext.newInstance(Utilisateur.class);
		
		System.out.println("LAT : "+request.getParameter("lat"));
		
		//ici on va cr�er l'utilisateur avec les donn�es rentr�s dans le formulaire
		final Adresse adresse = new Adresse(request.getParameter("location"), 0, 0);
		final Connexion connexion = new Connexion(request.getParameter("username"),request.getParameter("password"));
		String dateNaissance = request.getParameter("day")+"/"+request.getParameter("month")+"/"+request.getParameter("year");
		final Utilisateur user = new Utilisateur(request.getParameter("lastname"),request.getParameter("firstname"),connexion,request.getParameter("email"),request.getParameter("telephone"),adresse,dateNaissance);
		
		
		//ici il faut s�rialiser l'utilisateur
		final Marshaller marshaller = jaxbc.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_ENCODING, "UTF-8");
		final java.io.StringWriter sw = new StringWriter();
		marshaller.marshal(user, sw);
		
		
		//ici on envois la requete au webservice createUtilisateur
		final ClientRequest clientRequest = new ClientRequest("http://localhost:8080/rest/user/create");
		clientRequest.body("application/xml", user );
		
		
		//ici on va r�cuperer la r�ponse de la requete
		final ClientResponse<String> clientResponse = clientRequest.post(String.class);
		//test affichage
		System.out.println("\n\n"+clientResponse.getEntity()+"\n\n");
		if (clientResponse.getStatus() == 200) { // si la r�ponse est valide !
			// on d�s�rialiser la r�ponse si on veut v�rifier que l'objet retourner
			// est bien celui qu'on a voulu cr�er , pas obligatoire
			final Unmarshaller un = jaxbc.createUnmarshaller();
			final Object object = (Object) un.unmarshal(new StringReader(clientResponse.getEntity()));
			// et ici on peut v�rifier que c'est bien le bonne objet
			messageValue = "Vous avez bien �t� enregistr�";
			messageType = "success";
		} else {
			messageValue = "Une erreur est survenue";
			messageType = "danger";
		}
		
		// on affiche ces messages qu'une fois la reponse de la requete valide
		
		
	} else {
		messageType = "danger";
		messageValue = "Il semble y avoir une erreur lors de votre connexion/inscription.";
	}
}
%>
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
	
	    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	    <script src="./dist/js/bootstrap.min.js"></script>
	    <script src="./dist/js/config.js"></script>
	    <script src="./dist/js/maps.js"></script>
	
	    <!-- Just for debugging purposes. Don't actually copy this line! -->
	    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
	
	    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	    <!--[if lt IE 9]>
	      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
		<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAsO96nmOiM5A5mef1oNv4PZoETDWvfJ88&sensor=false"></script>
		<style type="text/css">#map-canvas{height:600px !important;}</style>
	</head>
	
	<body onload="initialize()">
		<div class="navbar navbar-inverse navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href=""><% out.print(siteName); %></a>
				</div>
				<div class="navbar-collapse collapse">
					<form action="index.jsp?attemp=1" method="POST" class="navbar-form navbar-right">
						<div class="form-group">
							<input type="text" placeholder="Nom d'utilisateur" id="login_username" name="login_username" class="form-control" required>
						</div>
						<div class="form-group">
							<input type="password" placeholder="Mot de passe" id="login_password" name="login_password" class="form-control" required>
						</div>
						<input type="hidden" name="signIn" id="signIn">
						<button type="submit" class="btn btn-success">Connexion</button>
					</form>
				</div>
				<!--/.navbar-collapse -->
			</div>
		</div>
	
		<div class="jumbotron">
			<div class="container">
				<%
				if(actionValid) {
					out.println("<div class='row'><div class='col-md-12' style='margin-top:-20px'>");
					out.println("<div class='alert alert-" + messageType + "'>" + messageValue + "</div>");
					out.println("</div></div>");
				}
				%>
				<div class="row">
					<div class="col-md-6 img-rounded" id="map-canvas" style="background-color:#DDD; margin-left:20px;"></div>
					<div class="col-md-1"></div>
					<div class="col-md-5 img-rounded" style="background-color:#DDD !important; margin-left:60px !important">
						<h3>Cr�ez un compte gratuitement</h3>
						<h4>Echangez d�s maintenant pr�s de chez vous !</h4>
						<hr />
					<form action="index.jsp?attemp=1" method="POST">
						<div class="row">
							<div class="col-md-6">
								<input type="text" placeholder="Nom" id="firstname"
									name="firstname" class="form-control" required="required" />
							</div>
							<div class="col-md-6">
								<input type="text" placeholder="Pr�nom" id="lastname"
									name="lastname" class="form-control" required="required" />
							</div>
							<div class="col-md-12">
								<br /> <input type="text" placeholder="Nom d'utilisateur"
									id="username" name="username" class="form-control"
									required="required" /> <br /> <input type="email"
									placeholder="Adresse email" id="email" name="email"
									class="form-control" required="required" /> <br /> <input
									type="password" placeholder="Mot de passe" id="password"
									name="password" class="form-control" required="required" />
							</div>
							<br />
							<div class="col-md-6">
							<br />
								<input type="text" placeholder="Num�ro de t�l�phone"
									id="telephone" name="telephone" class="form-control"
									required="required" />
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<br /> Date de naissance :
							</div>
							<div class="col-md-4">
								<select class="form-control" id="day" name="day">
									<%
										for (int i = 1; i <= 31; i++) {
											out.println("<option value='" + i + "'>" + i + "</option>");
										}
									%>
								</select>
							</div>
							<div class="col-md-4">
								<select class="form-control" id="month" name="month">
									<%
										String[] arrMois = { "Janvier", "Fevrier", "Mars", "Avril", "Mai",
												"Juin", "Juillet", "Aout", "Septembre", "Octobre",
												"Novembre", "Decembre" };
										for (String m : arrMois) {
											out.println("<option value='" + m + "'>" + m + "</option>");
										}
									%>
								</select>
							</div>
							<div class="col-md-4">
								<select class="form-control" id="year" name="year">
									<%
										int yyyy = Calendar.getInstance().get(Calendar.YEAR);
										for (int i = 1900; i < yyyy; i++) {
											out.println("<option value='" + yyyy + "'>" + i + "</option>");
										}
										out.println("<option selected='selected'>" + yyyy + "</option>");
									%>
								</select> <br />
							</div>
							<div class="col-lg-12">
								<div class="input-group">
									<input type="text"
										placeholder="Adresse compl�te (Rue, Ville, Pays, Code Postal)"
										id="location" name="location" class="form-control"
										required="required"> <span class="input-group-btn">
										<button class="btn btn-default" type="button"
											data-toggle="tooltip" data-placement="top"
											title="V�rifier la carte" onclick="codeAddress()">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span> <span class="input-group-btn">
										<button class="btn btn-default" type="button"
											data-toggle="tooltip" data-placement="top"
											title="Me trouver sur la carte" onclick="codeLatLng(null)">
											<span class="glyphicon glyphicon-screenshot"></span>
										</button>
									</span> <span class="input-group-btn">
										<button class="btn btn-default" type="button"
											data-toggle="tooltip" data-placement="top"
											title="R�cup�rer la position sur la carte"
											onclick="getMyMarker()">
											<span class="glyphicon glyphicon-pushpin"></span>
										</button>
									</span>
								</div>
								<hr />
								<label class="checkbox"><input type="checkbox"
									name="checkbox" required> J'ai lu et j'accepte les <a
									href="#">Conditions g�n�rales d'utilisation</a></label> <br />
									<input type="hidden" name="signUp" id="signUp"> 
									<input type="hidden" value="" name="lat" id="lat"> 
									<input type="hidden" value="" name="long" id="long"> 
									<input type="submit" value="Inscription" class="pull-right btn btn-info btn-lg"> 
									<br />
								<br />
								<br />
							</div>
						</div>
					</form>
				</div>
				</div>
			</div>
		</div>
	
<%@include file="template/footer.jsp" %>
