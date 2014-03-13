<%@include file="../constantes.jsp"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>

<%@ page import="javax.xml.bind.JAXBContext"%>
<%@ page import="javax.xml.bind.Marshaller"%>
<%@ page import="javax.xml.bind.Unmarshaller"%>

<%@ page import="java.io.StringReader"%>
<%@ page import="java.io.StringWriter"%>

<%@ page import="org.jboss.resteasy.client.ClientRequest"%>
<%@ page import="org.jboss.resteasy.client.ClientResponse"%>

<%@ page import="model.Utilisateur"%>

<%@ page import="com.ped.myneightool.model.Outil"%>
<%@ page import="com.ped.myneightool.dto.OutilsDTO"%>

<%
	
%>

<script>
$(function() {
	$(".editBtn").click(function(){
		$("#myModalLabel").html("Modifier une cat�gorie")
		var tmp = $(this).attr('id').split("edit")[1];
		$("#catName").val($("#nameCat"+tmp).html());
		$("#idCat").val(tmp);
		$("#categoryModal").modal('show');
	});
	$("#btnNewCat").click(function(){
		$("#myModalLabel").html("Ajoute une nouvelle cat�gorie")
		$("#catName").val("");
		$("#idCat").val("");
		$("#categoryModal").modal('show');
	});
	
});
</script>

<h3>Liste des cat�gories <span class="pull-right"><a class="btn btn-info" id="btnNewCat"><i class="glyphicon glyphicon-plus"></i> Ajouter une nouvelle cat�gorie</a></span></h3>
<hr />
<table class="table table-hover">
	<thead>
		<tr>
			<th width="10%" class="perfectCenter">Id</th>
			<th width="75%" class="perfectCenter">Nom de la cat�gorie</th>
			<th width="15%" class="perfectCenter">Action</th>
		</tr>
	</thead>
	<tbody>
		<!-- EXEMPLE 1 -->
		<tr class="toPaginate">
			<td class="perfectCenter">1</td>
			<td id="nameCat1" class="perfectCenter">Jardin</td>
			<td class="perfectCenter">
				<div class="btn-group">
					<a id="edit1" class="ttipt btn btn-default editBtn" title="Editer la cat�gorie">
						<span class="glyphicon glyphicon-pencil"></span>
					</a>
					<a href="adminDashboard.jsp?page=adminManageCategories&deleteId=1" class="ttipt btn btn-default" title="Supprimer la cat�gorie">
						<span class="glyphicon glyphicon-remove"></span>
					</a>
				</div>
			</td>
		</tr>
		<!-- FIN EXEMPLE 1 -->
		<!-- EXEMPLE 2 -->
		<tr class="toPaginate">
			<td class="perfectCenter">2</td>
			<td id="nameCat<%=2 %>" class="perfectCenter">Bricolage</td>
			<td class="perfectCenter">
				<div class="btn-group">
					<a id="edit2" class="ttipt btn btn-default editBtn" title="Editer la cat�gorie">
						<span class="glyphicon glyphicon-pencil"></span>
					</a>
					<a href="adminDashboard.jsp?page=adminManageCategories&deleteId=2" class="ttipt btn btn-default" title="Supprimer la cat�gorie">
						<span class="glyphicon glyphicon-remove"></span>
					</a>
				</div>
			</td>
		</tr>
		<!-- FIN EXEMPLE 2 -->
	</tbody>
</table>

<div id="paginator"></div>
<input id="paginatorNbElements" type="hidden" value="10" readonly="readonly" />

<div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel"></h4>
			</div>
			<form method="post" action="adminDashboard.jsp?page=adminManageCategories">
				<div class="modal-body">
					<label for="catName">Nom de la cat�gorie</label><br />
					<input type="text" class="form-control" name="catName" id="catName" placeholder="Nom de la cat�gorie" value="" required />
				</div>
				<div class="modal-footer">
					<input type="hidden" name="idCat" id="idCat" value="" />
					<button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
					<button type="submit" class="btn btn-info">Enregistrer</button>
				</div>
			</form>
		</div>
	</div>
</div>