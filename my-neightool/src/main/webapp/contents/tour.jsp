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
				<h4 class="modal-title" id="contactModalLabel">Premi�re visite - Suivez le guide</h4>
			</div>
			<div class="modal-body">
				<div id="pageTour1">
					<div class="perfectCenter">
						<h4><strong>Bienvenue sur MyNeighTool !</strong></h4>
						<hr />
						<span class="glyphicon glyphicon-wrench" style="font-size:32px"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-camera" style="font-size:32px"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-print" style="font-size:32px"></span><br /><br />
					</div>
					<p>Le site va vous permettre d'�tre en contact avec des gens qui ont des objets � pr�ter, et ce, proche de chez vous.</p>
					<p>Le site est bas� sur la confiance et vous permet d'effectuer l'int�gralit� des transactions (caution, pr�t de l'objet) directement avec l'autre membre du site concern�.</p>
					<p>Pour plus d'informations sur les conditions d'utilisations du site, r�f�rez-vous au <a href="#" data-dismiss="modal" data-toggle="modal" data-target="#terms">conditions g�n�rales d'utilisation</a> (va fermer cette fen�tre).</p>
				</div>
				<div id="pageTour2" style="display:none;">
					<div class="perfectCenter">
						<h4><strong>Ajouter votre premier objet !</strong></h4>
						<hr />
					</div>
						<p>Suivez ces �tapes :</p>
						<ol>
							<li>
								Cliquez sur le menu du haut "Mes Objets".					
							</li> 
							<li>
								Puis sur "+ Ajouter un objet" dans le menu lat�ral qui vient d'apparaitre.<br/><br/>
								<img src="./dist/img/lateralAjoutObjet.png" style="width:auto;height:120px;"><br/>
							</li> 
							<li>
								Remplissez tous les champs du formulaire qui vient d'apparaitre.					
							</li> 
						</ol>
				</div>
				<div id="pageTour3" style="display:none;">
					<div class="perfectCenter">
						<h4><strong>Communiquez !</strong></h4>
						<hr />
					</div>
					<p>Suivez ces �tapes :</p>
						<ol>
							<li>
								Cliquez sur le menu du haut "Mes Messages".					
							</li> 
							<li>
								Puis sur "Nouveau Message" dans le menu lat�ral qui vient d'apparaitre.<br/><br/>
								<img src="./dist/img/lateralAjoutMessage.png" style="width:auto;height:120px;"><br/>
							</li> 
							<li>
								Rentrez le nom d'utilisateur de votre destinataire, un objet et un message dans le formulaire qui vient d'apparaitre.					
							</li> 
						</ol>
				</div>
				<div id="pageTour4" style="display:none;">
					<div class="perfectCenter">
						<h4><strong>Recherchez !</strong></h4>
						<hr />
					</div>
					<p>Suivez ces �tapes :</p>
						<ol>
							<li>
								Cliquez sur le champ "Rechercher", dans la barre du haut, tapez votre recherche puis appuyez sur la touche "Entr�e". Pour faire une recherche d�taill�e, cliquez dans la barre de recherche puis sur le bouton "Recherche d�taill�e".<br/><br/>
								<img src="./dist/img/barreRecherche.png" style="width:auto;height:120px;"><br/>								
							</li> 
							<li>
								Vous pouvez ensuite cumuler jusqu'� quatre crit�res de recherche d�taill� : par nom, cat�gorie, distance et caution.<br/><br/>
								<img src="./dist/img/crit�reRecherche.png" style="width:auto;height:200px;"><br/>
							</li> 
							<li>
								L'affichage des r�sultats peut se faire sous deux formes :	par liste ou sur la carte.				
							</li> 
						</ol>
				</div>
				<div id="pageTour5" style="display:none;">
					<div class="perfectCenter">
						<h4><strong>Empruntez !</strong></h4>
						<hr />
					</div>
					<p>Suivez ces �tapes :</p>
					<ol>
							<li>
								En bas � doite de chaque objet se trouve un bouton pour demander un emprunt. 
								<img src="./dist/img/DemanderEmprunt.png" style="width:auto;height:40px;"><br/>								
							</li> 
							<li>
								Avant de cliquer sur celui-�i, vous pouvez regarder sur la fiche de l'objet les dates possibles ainsi que les r�servations d�j� programm�es.
								<img src="./dist/img/listeDispos.png" style="width:auto;height:100px;"><br/>
							</li> 
							<li>
								La demande se fait en deux temps, premi�rement avec le bouton de v�rification de la date d'emprunt, deuxi�ment avec celui de validation.
								<img src="./dist/img/formulaireDemande.png" style="width:auto;height:200px;">
							</li> 
					</ol>
				</div>
			</div>
			<div class="modal-footer">
				<div class="row">
					<div class="col-md-12">
						<a href="javascript:void(0);" id="previousPage" class="btn btn-info pull-left disabled"><i class="glyphicon glyphicon-chevron-left"></i> Page pr�c�dente</a>
						<a href="javascript:void(0);" id="nextPage" class="btn btn-info pull-left">Page suivante <i class="glyphicon glyphicon-chevron-right"></i></a>
						<a href="javascript:void(0);" class="btn btn-default disabled pull-left" id="currPage"></a>
						<button type="button" class="btn btn-default pull-right" data-dismiss="modal">Fermer</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>