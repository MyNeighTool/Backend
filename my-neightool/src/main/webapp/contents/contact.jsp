<%@include file="../constantes.jsp"%>
<script type="text/javascript">
$(function() {
	$('#sendMessage').click(function(e) {
		var ok = true;
		if($('#subjectOfMessage').val()=="") {
			$('#subjectOfMessage').data('bs.tooltip').options.title = "Vous devez rentrer un sujet";
			$('#subjectOfMessage').tooltip('show');
			ok = false;
		}
		if($('#bodyOfMessage').val()=="") {
			$('#bodyOfMessage').data('bs.tooltip').options.title = "Vous devez rentrer un message";
			$('#bodyOfMessage').tooltip('show');
			ok = false;
		}
		if(ok) {
			e.preventDefault();
	    	$("#sendWait").hide();
	    	$("#sendProgress").show();
	    	$("#sendMessage").hide();
	    	$("#closeBtn").hide();
			$.ajax({
			    url: "<%=pluginFolder%>contactScript.jsp",
			    type: 'POST',
			    data: {subjectTo: $("#subjectOfMessage").val(), messageTo: $("#bodyOfMessage").val(), reason: $("#reason").val(), link: $("#linkTo").val()},
			    success: function(data){
			    	$("#sendProgress").hide();
			    	$("#sendSuccess").show();
			    	$("#closeBtn").show();
			    }
			});
		}
	});
});
</script>
<div class="modal fade" id="contact" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="contactModalLabel">Nous contacter</h4>
			</div>
			<form method="POST"id="contactForm" name="contactForm" class="form-horizontal">
				<div id="sendSuccess" class="modal-body" style="display:none">
					<div class="alert alert-success perfectCenter">Message envoy� avec succ�s !</div>
				</div>
				<div id="sendProgress" class="modal-body" style="display:none">
					<div class="perfectCenter">
						<a href="#" class="btn btn-default disabled">Message en cours d'envoi. Merci de patienter...</a>
					</div>
				</div>
				<div id="sendWait" class="modal-body">
					<p id="pMsg">Un probl�me sur le site ? Une remarque ? N'h�sitez pas � nous contacter !</p><br />
					<div class="form-group">
						<label for="subjectTo" class="col-sm-3 control-label">Sujet</label>
						<div class="col-sm-9">
							<input type="text" class="form-control ttipr" value="" name="subjectTo" id="subjectOfMessage" placeholder="Sujet du message" required/>
						</div>
					</div>
					<div id="reasonDiv" class="form-group" style="display:none;">
						<label for="subjectTo" class="col-sm-3 control-label">Raison</label>
						<div class="col-sm-9">
							<select class="form-control" id="reason" name="reason">
								<option value="-1" selected="selected">S�lectionnez une raison</option>
								<option value="0">Nom de l'objet incorrect</option>
								<option value="1">Description de l'objet incorrecte</option>
								<option value="2">Photo de l'objet incorrect</option>
								<option value="3">Mauvaise cat�gorie de l'objet</option>
								<option value="4">Objet ne respectant pas les conditions d'utilisation</option>
							</select>
						</div>
						<input type="hidden" id="linkTo" value="" />
					</div>
					<div class="form-group">
						<label for="messageTo" class="col-sm-3 control-label">Message</label>
						<div class="col-sm-9">
							<textarea class="form-control ttipr" rows="10" name="messageTo" id="bodyOfMessage" placeholder="Entrez votre message" required></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="sendMessage" class="btn btn-info"><span class="glyphicon glyphicon-send"></span> Envoyer</button>
					<button type="button" id="closeBtn" class="btn btn-default" data-dismiss="modal">Fermer</button>
				</div>
			</form>
		</div>
	</div>
</div>