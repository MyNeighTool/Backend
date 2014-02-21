<%@include file="../constantes.jsp"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.sql.Timestamp"%>

<%@ page import="javax.xml.bind.JAXBContext"%>
<%@ page import="javax.xml.bind.Marshaller"%>
<%@ page import="javax.xml.bind.Unmarshaller"%>

<%@ page import="java.io.StringReader"%>
<%@ page import="java.io.StringWriter"%>

<%@ page import="org.jboss.resteasy.client.ClientRequest"%>
<%@ page import="org.jboss.resteasy.client.ClientResponse"%>

<%@ page import="model.Utilisateur"%>

<%@ page import="com.ped.myneightool.model.Message"%>
<%@ page import="com.ped.myneightool.dto.Messages"%>


<%
	boolean actionValid = false;
	String messageType = "";
	String messageValue = "";
	boolean list=false;

	actionValid = true;

	//on a besoin du contexte si on veut serialiser/d�s�rialiser avec jaxb
	final JAXBContext jaxbc = JAXBContext.newInstance(Messages.class);

	// Le DTO des outils permettant de r�cup�rer la liste d'outils
	Messages messagesDto = new Messages();

	//ici on va r�cuperer la r�ponse de la requete
	try {
		ClientRequest requestMessages;
		requestMessages = new ClientRequest(
				"http://localhost:8080/rest/message/list/receiveListByOrder/" + session.getAttribute("ID"));
		requestMessages.accept("application/xml");
		ClientResponse<String> responseMessages = requestMessages
				.get(String.class);
		if (responseMessages.getStatus() == 200) {
			Unmarshaller un2 = jaxbc.createUnmarshaller();
			messagesDto = (Messages) un2.unmarshal(new StringReader(
					responseMessages.getEntity()));
			if(messagesDto.size()>0)
			{
				list=true;
			}
			else
			{
				list=false;	
			}
			
			messageValue = "La liste a bien �t� r�cup�r�e";
			messageType = "success";
		} else {
			messageValue = "Une erreur est survenue";
			messageType = "danger";
		}
	} catch (Exception e) {
		e.printStackTrace();
	}

//Conversion des dates
DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		
%>


<ol class="breadcrumb">
	<li><a href="dashboard.jsp">Accueil</a></li>
	<li class="active">Boite de r�ception (<%=messagesDto.size()%> messages)</li>
</ol>

<div class="table-responsive">
	<table class="table table-hover">
		<thead>
			<tr>
				<th style="text-align: center;" width="20">Exp�diteur</th>
				<th style="text-align: center;" width="55%">Sujet</th>
				<th style="text-align: center;" width="15%">Date</th>
				<th style="text-align: center;" width="15%">Actions</th>
			</tr>
		</thead>
		<tbody id="accordion">
		
		
		<% if(list)
			{
				for (Message m : messagesDto.getListeMessages()) { %>
				<tr style="vertical-align: middle;">
				<td class="perfectCenter"><%=m.getEmetteur().getConnexion().getLogin()%></td>
				<td class="perfectCenter"><strong><a
						data-toggle="collapse" data-parent="#accordion"
						href="#collapse<%=m.getId()%>"><%=m.getObjet()%></a></strong>
					<div id="collapse<%=m.getId()%>" class="panel-collapse collapse">
						<hr />
						<div style="text-align: justify !important"><%=m.getCorps()%></div>
					</div></td>
				<td class="perfectCenter">
				<% String date = df.format(m.getDate());
				out.print(date);
				%>				
				</td>
				<td class="perfectCenter">
					<div class="btn-group">
						<button type="button" class="btn btn-default">
							<span class="glyphicon glyphicon-envelope"></span>
						</button>
						<button type="button" class="btn btn-default">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
					</div>
				</td>
			</tr>
	 	<%		}
			}else{		System.out.print("toto");	
			%>
		 	<tr class="perfectCenter">
					<td colspan="4">Aucun message re�u</td>
			</tr>
			<% } %>
					
		</tbody>
	</table>
</div>

<div class="row">
	<div class="col-md-12" style="text-align: center;">
		<ul class="pagination">
			<li><a href="#">&laquo;</a></li>
			<li><a href="#">1</a></li>
			<li><a href="#">&raquo;</a></li>
		</ul>
	</div>
</div>