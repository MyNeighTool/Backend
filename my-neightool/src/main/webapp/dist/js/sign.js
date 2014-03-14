$(document).ready(function() {
	$(".ttipl").tooltip({placement : "left",container : 'body'});
	$(".ttipr").tooltip({placement : "right",container : 'body'});
	$(".ttipt").tooltip({placement : "top",container : 'body'});
	$(".ttipb").tooltip({placement : "bottom",container : 'body'});

	$("#username").focusout(function() {
		if($("#checkUsername").html()!="")
			$("#checkUsernameDiv").hide();
			$("#checkUsername").html("");
			$("#checkUsername").removeClass("text-success").removeClass("text-danger").removeClass("text-warning");
		if($(this).val()!="") {
			var uname = $(this).val();
			$.ajax({
				url: "plugins/checkUsernameScript.jsp",
			    type: 'POST',
			    data: {name: uname},
			    success: function(data) {
			    	if(data=="1") {
			    		$("#checkUsername").html('<i class="glyphicon glyphicon-ok"></i> Nom d\'utilisateur disponible');
			    		$("#checkUsername").addClass("text-success");
			    		$("#checkUsernameDiv").fadeIn('slow');
			    	} else {
			    		$("#checkUsername").html('<i class="glyphicon glyphicon-remove"></i> Nom d\'utilisateur indisponible');
			    		$("#checkUsername").addClass("text-danger");
			    		$("#checkUsernameDiv").fadeIn('slow');
			    	}
			    }
			});
		} else {
			$("#checkUsername").html('<i class="glyphicon glyphicon-warning-sign"></i> Nom d\'utilisateur vide');
			$("#checkUsername").addClass("text-warning");
			$("#checkUsernameDiv").fadeIn('slow');
		}
	});
	
	$("#signUpBtn").click(function(){
		var name, lastname, username, mail, password, phone, day, month, year, city, tou;
		var now = new Date();
		var submitable = true;
		name = $("#firstname");
		lastname = $("#lastname");
		username = $("#username");
		mail = $("#email");
		password = $("#password");
		phone = $("#telephone");
		day = $("#day");
		month = $("#month");
		year = $("#year");
		city = $("#location");
		tou = $("#tou");
		if(name.val()=="") {
			name.parent().addClass("has-error");
			name.data('bs.tooltip').options.title = 'Veuillez renseigner votre nom';
			name.tooltip('show');
			submitable = false;
		}
		if(lastname.val()=="") {
			lastname.parent().addClass("has-error");
			lastname.data('bs.tooltip').options.title = 'Veuillez renseigner votre pr�nom';
			lastname.tooltip('show');
			submitable = false;
		}
		if(username.val()=="") {
			username.parent().addClass("has-error");
			username.data('bs.tooltip').options.title = 'Choisissez un nom d\'utilisateur valide (lettres et chiffres uniquement)';
			username.tooltip('show');
			submitable = false;
		}
		if(mail.val()=="") {
			mail.parent().addClass("has-error");
			mail.data('bs.tooltip').options.title = 'Veuillez rentrer une adresse email valide';
			mail.tooltip('show');
			submitable = false;
		}
		if(password.val()=="") {
			password.parent().addClass("has-error");
			password.data('bs.tooltip').options.title = 'Le mot de passe doit faire 6 chiffres/lettres/caract�res sp�ciaux';
			password.tooltip('show');
			submitable = false;
		}
		if(phone.val()=="") {
			phone.parent().addClass("has-error");
			phone.data('bs.tooltip').options.title = 'Votre num�ro de t�l�phone doit �tre compos� de 10 chiffres';
			phone.tooltip('show');
			submitable = false;
		}
		if(city.val()=="") {
			city.parent().addClass("has-error");
			city.data('bs.tooltip').options.title = 'Veuillez rentrer le nom de votre ville';
			city.tooltip('show');
			submitable = false;
		}
		var age = now.getFullYear()-year.val();
		if(age < 18) {
			year.parent().addClass("has-error");
			year.data('bs.tooltip').options.title = 'Vous devez avoir au moins 18 ans pour vous inscrire';
			year.tooltip('show');
			submitable = false;
		}
		if(!tou.is(':checked')) {
			tou.parent().addClass("has-error");
			tou.data('bs.tooltip').options.title = 'Vous devez accepter les conditions g�n�rales d\'utilisation';
			tou.tooltip('show');
			submitable = false;
		}
		if(submitable)
			$("#formSignUp").submit();
	});
});