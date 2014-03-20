<%@include file="../constantes.jsp"%>
<script type="text/javascript">
$(function() {
	var tourPages = 5;
	var tourCurrentPage = 1;
	$("#previousPage").click(function() {
		if(tourCurrentPage > 1) {
			$("#pageTour"+tourCurrentPage).effect('slide', { direction: 'right', mode: 'hide' });
			if(tourCurrentPage==tourPages)
				$("#nextPage").removeClass("disabled");
			tourCurrentPage--;
			$("#pageTour"+tourCurrentPage).delay(400).effect('slide', { direction: 'left', mode: 'show' });
		}
		if(tourCurrentPage==1)
			$(this).addClass("disabled")
		$("#currPage").html("Page : " + tourCurrentPage + "/" + tourPages);
	});
	$("#nextPage").click(function() {
		if(tourCurrentPage <= tourPages) {
			$("#pageTour"+tourCurrentPage).effect('slide', { direction: 'left', mode: 'hide' });
			if(tourCurrentPage==1)
				$("#previousPage").removeClass("disabled");
			tourCurrentPage++;
			$("#pageTour"+tourCurrentPage).delay(400).effect('slide', { direction: 'right', mode: 'show' });
		}
		if(tourCurrentPage==tourPages)
			$(this).addClass("disabled");
		$("#currPage").html("Page : " + tourCurrentPage + "/" + tourPages);
	});
	$("#currPage").html("Page : " + tourCurrentPage + "/" + tourPages);
});
</script>
<div class="modal fade" id="tourModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="contactModalLabel">Première visite - Suivez le guide</h4>
			</div>
			<div class="modal-body">
				<div id="pageTour1">
					<div class="perfectCenter">
						<h4><strong>Bienvenue sur MyNeighTool !</strong></h4>
						<hr />
						<span class="glyphicon glyphicon-wrench" style="font-size:32px"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-camera" style="font-size:32px"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-print" style="font-size:32px"></span><br /><br />
					</div>
					<p>Le site va vous permettre d'être en contact avec des gens qui ont des objets à prêter, et ce, proche de chez vous.</p>
					<p>Le site est basé sur la confiance et vous permet d'effectuer l'intégralité des transactions (caution, prêt de l'objet) directement avec l'autre membre du site concerné.</p>
					<p>Pour plus d'informations sur les conditions d'utilisations du site, référez-vous au <a href="#" data-dismiss="modal" data-toggle="modal" data-target="#terms">conditions générales d'utilisation</a> (va fermer cette fenêtre).</p>
				</div>
				<div id="pageTour2" style="display:none;">
					A completer
				</div>
				<div id="pageTour3" style="display:none;">
					A completer
				</div>
				<div id="pageTour4" style="display:none;">
					A completer
				</div>
				<div id="pageTour5" style="display:none;">
					A completer
				</div>
			</div>
			<div class="modal-footer">
				<div class="row">
					<div class="col-md-12">
						<a href="javascript:void(0);" id="previousPage" class="btn btn-info pull-left disabled"><i class="glyphicon glyphicon-chevron-left"></i> Page précédente</a>
						<a href="javascript:void(0);" id="nextPage" class="btn btn-info pull-left">Page suivante <i class="glyphicon glyphicon-chevron-right"></i></a>
						<a href="javascript:void(0);" class="btn btn-default disabled pull-left" id="currPage"></a>
						<button type="button" class="btn btn-default pull-right" data-dismiss="modal">Fermer</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>