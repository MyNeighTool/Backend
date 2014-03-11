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

<%@ page import="model.Message"%>
<%@ page import="dto.MessagesDTO"%>


<%
	boolean actionValid = false;
	String messageType = "";
	String messageValue = "";
	boolean list=false;

	actionValid = true;

	//on a besoin du contexte si on veut serialiser/d�s�rialiser avec jaxb
	final JAXBContext jaxbc = JAXBContext.newInstance(MessagesDTO.class,Message.class);

	// Le DTO des outils permettant de r�cup�rer la liste d'outils
	MessagesDTO messagesDto = new MessagesDTO();


	//ici on va r�cuperer la r�ponse de la requete
	try {	
		ClientRequest requestMessages;
		requestMessages = new ClientRequest(
				"http://localhost:8080/rest/message/list/sendListByOrder/" + session.getAttribute("ID"));
		requestMessages.accept("application/xml");
		ClientResponse<String> responseMessages = requestMessages
				.get(String.class);
		if (responseMessages.getStatus() == 200) {
			Unmarshaller un2 = jaxbc.createUnmarshaller();
			messagesDto = (MessagesDTO) un2.unmarshal(new StringReader(
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

<script>
$(function(){
var nbMessages = <%=messagesDto.size()%>;

	$('.delMessage').click(function() {		
		var idMsg = $(this).attr("id").split("delMsg")[1];
		
		$.ajax({
		    url: "contents/etatScript.jsp",
		    type: 'POST',
		    data: {id: idMsg, etat: 1, page: 2},
		    success: function() {
		    	$(this).tooltip('hide');
				$(this).closest('tr').fadeOut(400, function() {
					nbMessages--;
					$("#nbMessageInbox").html(nbMessages);
					$(this).html("<td colspan='4' class='perfectCenter alert-success'>Message supprim� avec succ�s</td>").fadeIn(400).delay(1000).fadeOut(400, function() {
						$(this).remove();
						if($("#paginatorNbElements").length>0) {
							changePage(previousPage,$("#paginatorNbElements").val());
							recalculateNbPage();
						}
					});
		    	});
			}
		});
	});
});
</script>

<ol class="breadcrumb">
	<li><a href="dashboard.jsp">Accueil</a></li>
	<li class="active">Boite d'envoi (<span id="nbMessageInbox"><%=messagesDto.size()%></span>/50 messages)</li>
</ol>

<div class="table-responsive">
	<table class="table table-hover">
		<thead>
			<tr>
				<th style="text-align: center;" width="20">Destinataire</th>
				<th style="text-align: center;" width="55%">Sujet</th>
				<th style="text-align: center;" width="15%">Date</th>
				<th style="text-align: center;" width="15%">Actions</th>
			</tr>
		</thead>
		<tbody id="accordion">		
		<% if(list)
			{
				for (Message m : messagesDto.getListeMessages()) { 
					if(m.getEtatEmetteur() == 0)
					{%>
					<tr style="vertical-align: middle;" class="toPaginate">
					<td class="perfectCenter"><%=m.getDestinataire().getConnexion().getLogin()%></td>
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
							<a class="ttipt btn btn-default delMessage" id="delMsg<%=m.getId()%>" title="Supprimer le message"><span class="glyphicon glyphicon-remove"></span></a>
						</div>
					</td>
				</tr>
	 	<%			}
				}
		
			}else{
			%>
		 	<tr class="perfectCenter">
					<td colspan="4">Aucun message envoy�</td>
			</tr>
			<% } %>
		</tbody>
	</table>
</div>

<div id="paginator"></div>
<input id="paginatorNbElements" type="hidden" value="10" readonly="readonly" />