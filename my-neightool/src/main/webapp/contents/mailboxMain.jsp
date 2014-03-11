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
				"http://localhost:8080/rest/message/list/receiveListByOrder/" + session.getAttribute("ID"));
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
	
	$(".answerBtn").click(function(e) {
		var strTmp = this.id.split("isanswerName");
		$("#userTo").val(strTmp[1]);
		$('#newMessageModal').modal('show');
	});
	
	$('.delMessage').click(function() {
		var idMsg = $(this).attr("id").split("delMsg")[1];
		$.ajax({
		    url: "contents/etatScript.jsp",
		    type: 'POST',
		    data: {id: idMsg, etat: 3},
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
	
	$('.answerBtn').click(function(e) {
		var strTmp = this.id.split("isanswerName");
		$("#idAnswer").val(strTmp[0]);
	}
	
	$('.msg').click(function(e) {
		var idMsg = $(this).attr("id").split("msg")[1];
		e.preventDefault();
		$.ajax({
		    url: "contents/etatScript.jsp",
		    type: 'POST',
		    data: {id: idMsg, etat: 1},
		    success: function() {
		    	$("#unread"+idMsg).removeClass("unread");
		    }
		});
	});	
});
</script>

<style>
	.unread { font-weight: bold; }
	.unread td:first-child, .unread:hover td:first-child { background: #428BCA; }
	.answered td:first-child, .answered:hover td:first-child { background: #3C763D; }
</style>

<div class="row">

	<div class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="dashboard.jsp">Accueil</a></li>
			<li class="active">Boite de r�ception (<span id="nbMessageInbox"><%=messagesDto.size()%></span>/50 messages)</li>
		</ol>
	</div>
	
	<div class="col-md-offset-8 col-md-4">
		<table class="table">
			<thead>
				<tr>
					<th width="15px"></th>
					<th>L�gende</th>
				</tr>
			</thead>
			<tbody>
				<tr class="unread">
					<td></td>
					<td style="font-weight: normal">Message non lu</td>
				</tr>
				<tr class="answered">
					<td></td>
					<td>Message r�pondu</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="col-md-12">
		<div class="table-responsive">
			<table class="table table-hover" id="toReorder">
				<thead>
					<tr>
						<th style="text-align: center;" width="5px"></th>
						<th style="text-align: center;" width="20%">Exp�diteur</th>
						<th style="text-align: center;" width="50%">Sujet</th>
						<th style="text-align: center;" width="15%">Date</th>
						<th style="text-align: center;" width="15%">Actions</th>
					</tr>
				</thead>
				<tbody id="accordion">
				
				
				<%
				if(list) {
					for (Message m : messagesDto.getListeMessages()) { %>
					<% if(m.getEtatDestinataire() == 0){ %>
					<tr style="vertical-align: middle;" class="toPaginate unread" id="unread<%=m.getId()%>">
						<td></td>
						<td class="perfectCenter"><%=m.getEmetteur().getConnexion().getLogin()%></td>
						<td class="perfectCenter"><a
								data-toggle="collapse" data-parent="#accordion"
								href="#collapse<%=m.getId()%>" class="msg" id="msg<%=m.getId()%>"><%=m.getObjet()%></a>
					<% } else if(m.getEtatDestinataire() == 1){ %>
					<tr style="vertical-align: middle;" class="toPaginate" id="unread<%=m.getId()%>">
						<td></td>
						<td class="perfectCenter"><%=m.getEmetteur().getConnexion().getLogin()%></td>
						<td class="perfectCenter"><a
								data-toggle="collapse" data-parent="#accordion"
								href="#collapse<%=m.getId()%>" class="msg" id="msg<%=m.getId()%>"><%=m.getObjet()%></a>
					<% } else if(m.getEtatDestinataire() == 2){ %>
					<tr style="vertical-align: middle;" class="toPaginate answered">
						<td></td>
						<td class="perfectCenter"><%=m.getEmetteur().getConnexion().getLogin()%></td>
						<td class="perfectCenter"><a
								data-toggle="collapse" data-parent="#accordion"
								href="#collapse<%=m.getId()%>"><%=m.getObjet()%></a>
					<% } if(m.getEtatDestinataire() != 3) {	%>
					<div id="collapse<%=m.getId()%>" class="panel-collapse collapse">
								<hr />
								<div style="text-align: justify !important"><%=m.getCorps()%></div>
							</div></td>
						<td class="perfectCenter">
						<%
							String date = df.format(m.getDate());
							out.print(date);
						%>
						</td>
						<td class="perfectCenter">
							<div class="btn-group">
								<a id="<%=m.getId()%>isanswerName<%=m.getEmetteur().getConnexion().getLogin()%>" class="answerBtn ttipt btn btn-default" title="R�pondre � l'exp�diteur">
									<span class="glyphicon glyphicon-envelope"></span>
								</a>
								<a class="ttipt btn btn-default delMessage" id="delMsg<%=m.getId()%>" title="Supprimer le message">
									<span class="glyphicon glyphicon-remove"></span>
								</a>
							</div>
						</td>
					</tr>
			 	<%		}
					}
				} else {	
				%>
				 	<tr class="perfectCenter">
						<td colspan="4">Aucun message re�u</td>
					</tr>
				<% } %>			
				</tbody>
			</table>
		</div>
		
		<div id="paginator"></div>
		<input id="paginatorNbElements" type="hidden" value="10" readonly="readonly" />
	
	</div>
</div>