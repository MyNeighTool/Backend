<%@page import="com.ped.myneightool.model.SendMailTLS"%>
<%@ page import="javax.xml.bind.JAXBContext"%>
<%@ page import="javax.xml.bind.Marshaller"%>
<%@ page import="javax.xml.bind.Unmarshaller"%>

<%@ page import="java.io.StringReader"%>
<%@ page import="java.io.StringWriter"%>

<%@ page import="org.jboss.resteasy.client.ClientRequest"%>
<%@ page import="org.jboss.resteasy.client.ClientResponse"%>


<%@ page import="com.ped.myneightool.model.Utilisateur"%>
<%@ page import="com.ped.myneightool.model.Connexion"%>
<%@ page import="com.ped.myneightool.model.Adresse"%>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.util.Calendar" %>
<%@include file="../constantes.jsp"%>
<%@include file="../functions.jsp"%>
<%

String userContactName = "Anonyme", userContactId = "Inconnu";

JAXBContext jaxbc=JAXBContext.newInstance(Utilisateur.class);
Utilisateur utilisateurGet = new Utilisateur();
try {
	ClientRequest clientRequest;
	clientRequest = new ClientRequest(siteUrl + "rest/user/" + session.getAttribute("ID"));
	clientRequest.accept("application/xml");
	ClientResponse<String> clientResponse = clientRequest.get(String.class);
	if (clientResponse.getStatus() == 200)
	{
		Unmarshaller un = jaxbc.createUnmarshaller();
		utilisateurGet = (Utilisateur) un.unmarshal(new StringReader(clientResponse.getEntity()));
		userContactName = utilisateurGet.getConnexion().getLogin();
		userContactId = String.valueOf(utilisateurGet.getId());
	}
} catch (Exception e) {
	e.printStackTrace();
}

String reason = "", link = "", msg = "";
if(!request.getParameter("reason").equals("-1") && !request.getParameter("link").equals("")) {
	if(request.getParameter("reason").equals("0")) {
		reason = "Nom de l'objet incorrect";
	}
	if(request.getParameter("reason").equals("1")) {
		reason = "Description de l'objet incorrecte";
	}
	if(request.getParameter("reason").equals("2")) {
		reason = "Photo de l'objet incorrect";
	}
	if(request.getParameter("reason").equals("3")) {
		reason = "Mauvaise catégorie de l'objet";
	}
	if(request.getParameter("reason").equals("4")) {
		reason = "Objet ne respectant pas les conditions d'utilisation";
	}
	link = request.getParameter("link");
	msg = "Un objet a été signaler par l'utilisateur : " + userContactName + " (id : " + userContactId + ").\nRaison évoquée : " + reason + "\nLien vers l'objet : " + link + "\n------------------------------------------\nMessage :\n" + request.getParameter("messageTo");
} else {
	msg = "Un message a été envoyé par l'utilisateur : " + userContactName + " (id : " + userContactId + ").\n------------------------------------------\nMessage :\n" + request.getParameter("messageTo");
}

String sjt = "MyNeighTool Contact - " + request.getParameter("subjectTo");
new SendMailTLS(contactMail,msg,sjt);
%>