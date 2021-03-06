package com.ped.myneightool;

import java.io.StringWriter;
import java.util.Date;
import java.util.Iterator;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;

import org.jboss.resteasy.client.ClientRequest;
import org.jboss.resteasy.client.ClientResponse;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.slf4j.LoggerFactory;

import com.ped.myneightool.dto.OutilsDTO;
import com.ped.myneightool.model.Adresse;
import com.ped.myneightool.model.Categorie;
import com.ped.myneightool.model.Connexion;
import com.ped.myneightool.model.Outil;
import com.ped.myneightool.model.Utilisateur;


public class TestOutil {
	
	private static final org.slf4j.Logger LOG = LoggerFactory
			.getLogger(TestOutil.class);

	
	private static JAXBContext jaxbc;
	private static ClientRequestBuilder crb;
	private static Utilisateur utilisateurAdmin;
	private static String chemin;
	
	//create the date
	private static Date myDate = new Date();

	@BeforeClass
	public static void setUp() throws Exception {
		jaxbc=JAXBContext.newInstance(	Outil.class, 
										OutilsDTO.class,
										Utilisateur.class,
										Connexion.class);
		crb= new ClientRequestBuilder(jaxbc);
		chemin = "http://localhost:8080/uploads/img/";
		
		myDate.setDate(myDate.getDate() + 10);
		
		try {
			final Connexion connexion = new Connexion("adminCategorieOutil",CryptHandler.encodedPw("admin"));
			final Adresse adresse = new Adresse("27 Avenue de la Gare","33240","Saint-André-de-Cubzac","France",(float)-0.440313,(float)44.992559);
			final Date birthDate = new Date(0);
			
			final Utilisateur utilisateur= new Utilisateur("Gaston","Doumergue",connexion,"adminCategorieOutil@myneightool.com","0000000000",adresse,birthDate);
			utilisateur.setRole("ADMIN");
			utilisateurAdmin = (Utilisateur) crb.httpRequestXMLBody(utilisateur,"user/create");
									
					
		} catch (final RuntimeException re) {
			LOG.error("echec de creation de l'utilisateur", re);
			throw re;
		}		
	}
		
	/**
	 * test unitaire création d'Outil
	 */
	@Test
	public void testCreateOutil() {
		try {
			
			
			//Elements nécéssaires à un outil (cat, utilisateur, date)
			final Categorie cat1= new Categorie("Nouvelles Technologies");
			final Categorie cat= (Categorie) crb.httpRequestXMLBodyCategorie(cat1, "categorie/create",utilisateurAdmin);			
			
			final Adresse adresse = new Adresse("5 Rue César Campinchi","20200","Bastia","France", (float) 9.448434, (float) 42.697971);
			final Date birthDate = new Date();
			Connexion co = new Connexion("login1",CryptHandler.encodedPw("pass1"));
			final Utilisateur utilisateur= new Utilisateur("Alexandre","Millerand",co,"mail@mail.com","0101010101",adresse,birthDate);
			final Utilisateur utilisateurPost= (Utilisateur) crb.httpRequestXMLBody(utilisateur, "user/create");
			
			final Date debutT = new Date(0);
			final Date finT = new Date();
			
		
			//test unitaire création d'Outil
			Outil outil= new Outil(utilisateurPost,"Télévision","regarder la télé",true,cat,10, new Date(0), myDate,chemin+"télé.jpeg");
			Outil outilPost=(Outil) crb.httpRequestXMLBody(outil, "tool/create");
			Assert.assertNotSame(outilPost,null);
			
			//test unitaire création d'Outil avec dates de dispo
			outil= new Outil(utilisateurPost,"Ordinateur","savoir clicker",true,cat,20,debutT,finT,chemin+"portable.jpg");
			outilPost=(Outil) crb.httpRequestXMLBody(outil, "tool/create");
			Assert.assertNotSame(outilPost,null);
			
		} catch (final RuntimeException re) {
			LOG.error("echec de creation de l'outil", re);
			throw re;
		}
	}
	


	/**
	 * test unitaire mis à jour d'outil
	 */
	@Test
	public final void testUpdateTool() {
		try {
			
			final Categorie cat1= new Categorie("Piscine");
			final Categorie cat= (Categorie) crb.httpRequestXMLBodyCategorie(cat1, "categorie/create",utilisateurAdmin);
			
			
			final Adresse adresse = new Adresse("1-13 Rue Edgar Degas","33700","Mérignac","France", (float) -0.667294, (float) 44.828056);
			final Date birthDate = new Date();
			Connexion co = new Connexion("login2",CryptHandler.encodedPw("pass2"));
			final Utilisateur utilisateur= new Utilisateur("Paul","Deschanel",co,"mail2@mail.com","0101010101",adresse,birthDate);
			final Utilisateur utilisateurPost = (Utilisateur) crb.httpRequestXMLBody(utilisateur,"user/create");
			
			
			final Outil outil= new Outil(utilisateurPost,"AspirateurPiscineUPDATE","savoir aspirer",true,cat,30, new Date(0), myDate,chemin+"piscine.jpg");
			final Outil outilPost=(Outil) crb.httpRequestXMLBody(outil, "tool/create");
			
			String str ="MEGA AspirateurPiscine UPDATE";
			outilPost.setNom(str);
			
			final Outil outilPost2 = (Outil) crb.httpRequestXMLBody(outilPost,"tool/update");						
			
			Assert.assertTrue(str.equals(outilPost2.getNom()));

		} catch (final RuntimeException re) {
			LOG.error("echec de mis a jour de l'outil", re);
			throw re;
		}
	}

	
	
	/**
	 * test unitaire obtenir un tool
	 */
	
	@Test
	public final void testGetOutil() {

		try{
			final Categorie cat1= new Categorie("Cuisine");
			final Categorie cat= (Categorie) crb.httpRequestXMLBodyCategorie(cat1, "categorie/create",utilisateurAdmin);
			
			final Adresse adresse = new Adresse("1 Quai Louis XVIII","33000","Bordeaux","France", (float) -0.570027, (float) 44.842573);
			final Date birthDate = new Date();
			Connexion co = new Connexion("login3",CryptHandler.encodedPw("pass3"));
			final Utilisateur utilisateur= new Utilisateur("Raymond","Poincare",co,"mail3@mail.com","0101010101",adresse,birthDate);
			final Utilisateur utilisateurPost= (Utilisateur) crb.httpRequestXMLBody(utilisateur, "user/create");
			
			final Outil outil= new Outil(utilisateurPost,"CasserolleGet","savoir cuisiner",true,cat,56, new Date(0), myDate,chemin+"casserolle.jpg");
			final Outil outilPost=(Outil) crb.httpRequestXMLBody(outil, "tool/create");
			
			
			LOG.info("");
			LOG.info("");
			LOG.info(outilPost.getId()+" "+outilPost.getNom()+" "+outilPost.getCategorie().getNom());	
			int i = outilPost.getId();
			LOG.info("");
			LOG.info("");
			LOG.info("id: "+i);
			LOG.info("");
			LOG.info("");
			
			final Outil outilGet = (Outil) crb.httpGetRequest("tool", i);
			LOG.info(outilGet.getId()+" "+outilGet.getNom()+" "+outilGet.getCategorie());
			LOG.info("");
			LOG.info("");
			Assert.assertNotSame(outilGet, null);
			LOG.info("");
			LOG.info("");
			
		}
		catch(final RuntimeException r){
			LOG.error("testGetTool failed",r);
			throw r;
		}
	}
	
	
	/**
	 * test unitaire suppresion d'Outil
	 */
	@Test
	public void testDeleteOutil() {
		try {
			final Categorie cat1= new Categorie("Salon");
			final Categorie cat= (Categorie) crb.httpRequestXMLBodyCategorie(cat1, "categorie/create",utilisateurAdmin);
			
			final Adresse adresse = new Adresse("91 Rue François de Sourdis","33000","Bordeaux","France", (float) -0.587491, (float) 44.831347);
			final Date birthDate = new Date();
			Connexion co = new Connexion("login4",CryptHandler.encodedPw("pass4"));
			final Utilisateur utilisateur= new Utilisateur("Armand","Fallieres",co,"mail4@mail.com","0404040404",adresse,birthDate);
			final Utilisateur utilisateurPost= (Utilisateur) crb.httpRequestXMLBody(utilisateur, "user/create");
			
			
			final Outil outil= new Outil(utilisateurPost,"TélévisionDelete","savoir regarder la télé, outil a supprimer",true,cat,2, new Date(0), new Date());
			final Outil outilPost=(Outil) crb.httpRequestXMLBody(outil, "tool/create");
			
			int i = outilPost.getId();
			
			crb.httpGetRequest("tool/delete", i,utilisateurPost);
			
			try{
				final Outil outilGet = (Outil) crb.httpGetRequest("tool", i);
				Assert.assertSame(outilGet, null);
			}
			catch(final RuntimeException r){
				LOG.error("testDeleteOeuvre failed",r);
				throw r;
			}
			
			
			
		} catch (final RuntimeException re) {
			LOG.error("echec de creation de l'outil", re);
			throw re;
		}
	}
	
	/**
	 * test unitaire pour obtenir la liste des Outils
	 */
	@Test
	public final void testGetAllOutils() {
		try{
			
			OutilsDTO dto =(OutilsDTO) crb.httpGetRequestWithoutArgument("tool/list");
			
			LOG.info("\n\n\n");
			LOG.info("taille liste Outils:" +dto.size());
			LOG.info("\n\n\n");
			
			LOG.info("liste des outils:\n");
			
			Iterator<Outil> ito=dto.getListeOutils().iterator();
			while(ito.hasNext()){
				
				final Outil Outil = ito.next();
				LOG.info(Outil.getId()+" "+Outil.getNom()+" "+Outil.getCategorie()+" "+Outil.getDescription());
				
			}
			
			
			Assert.assertTrue( dto.getListeOutils().size() >= 0);
			LOG.info("\n\n\n");
		}
		catch(final RuntimeException r){
			LOG.error("getAllOutils failed",r);
			throw r;
		}
	}
	
	/**
	 * test unitaire pour obtenir la liste des Outils disponible
	 */
	@Test
	public final void testGetAllOutilsAvailable() {
		try{
			
			final Categorie cat1= new Categorie("Voiture");
			final Categorie cat= (Categorie) crb.httpRequestXMLBodyCategorie(cat1, "categorie/create",utilisateurAdmin);
			
			final Adresse adresse = new Adresse("733 Cours de la Liberation","33400","Talence","France", (float) -0.602624, (float) 44.796637);
			final Date birthDate = new Date();
			Connexion co = new Connexion("login5",CryptHandler.encodedPw("pass5"));
			final Utilisateur utilisateur= new Utilisateur("Emile","Loubet",co,"mail5@mail.com","0505050555",adresse,birthDate);
			final Utilisateur utilisateurPost= (Utilisateur) crb.httpRequestXMLBody(utilisateur, "user/create");
			
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"Cric","savoir cric mais cric pas disponible",false,cat,15, new Date(0), myDate,chemin+"cric.jpg"), "tool/create");
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"Pneu","savoir mettre un pneu mais pneu disponible",true,cat,150, new Date(0), myDate,chemin+"pneu.jpg"), "tool/create");
			
			OutilsDTO dto =(OutilsDTO) crb.httpGetRequestWithoutArgument("tool/list/available");
			
			LOG.info("\n\n\n");
			LOG.info("taille liste Outils disponible:" +dto.size());
			LOG.info("\n\n\n");
			
			LOG.info("liste des outils disponible:\n");
			
			Iterator<Outil> ito=dto.getListeOutils().iterator();
			while(ito.hasNext()){
				
				final Outil Outil = ito.next();
				LOG.info(Outil.getId()+" "+Outil.getNom()+" "+Outil.getCategorie()+" "+Outil.getDescription());
				
			}
			
			
			Assert.assertTrue( dto.getListeOutils().size() >= 0);
			LOG.info("\n\n\n");
		}
		catch(final RuntimeException r){
			LOG.error("getAllOutilsAvailable failed",r);
			throw r;
		}
	}
	
	
	/**
	 * test unitaire pour obtenir la liste des Outils d'un utilisateur en particulier
	 */
	@Test
	public final void testGetAllOutilsFromUser() {
		try{
			
			final Categorie cat1= new Categorie("Autre");
			final Categorie cat= (Categorie) crb.httpRequestXMLBodyCategorie(cat1, "categorie/create",utilisateurAdmin);
			
			final Adresse adresse = new Adresse("Université Montesquieu - Bordeaux IV","33400","Talence","France", (float) -0.600572, (float) 44.806564);
			final Date birthDate = new Date();
			Connexion co = new Connexion("login6",CryptHandler.encodedPw("pass6"));
			final Utilisateur utilisateur= new Utilisateur("Felix","Faure",co,"mail6@mail.com","6666666666",adresse,birthDate);
			final Utilisateur utilisateurPost= (Utilisateur) crb.httpRequestXMLBody(utilisateur, "user/create");
			
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"Autre1","savoir autre1",true,cat,44, new Date(0), myDate,chemin+"outils.jpg"), "tool/create");
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"Autre2","savoir autre2",true,cat,99, new Date(0), myDate,chemin+"outils.jpg"), "tool/create");
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"Autre3","savoir autre3",false,cat,66, new Date(0), myDate,chemin+"outils.jpg"), "tool/create");
			
			
			int i = utilisateurPost.getId();
			OutilsDTO dto =(OutilsDTO) crb.httpGetRequest("tool/user",i );
			
			LOG.info("\n\n\n");
			LOG.info("taille liste Outils:" +dto.size());
			LOG.info("\n\n\n");
			
			LOG.info("liste des outils:\n");
			
			Iterator<Outil> ito=dto.getListeOutils().iterator();
			while(ito.hasNext()){
				
				final Outil Outil = ito.next();
				LOG.info(Outil.getId()+" "+Outil.getNom()+" "+Outil.getCategorie()+" "+Outil.getDescription());
				
			}
			
			
			Assert.assertTrue( dto.getListeOutils().size() >= 0);
			LOG.info("\n\n\n");
		}
		catch(final RuntimeException r){
			LOG.error("getAllOutils failed",r);
			throw r;
		}
	}
	
	/**
	 * test unitaire pour obtenir la liste des Outils DISPONIBLE d'un utilisateur en particulier
	 */
	@Test
	public final void testGetAllOutilsAvailableFromUser() {
		try{
			
			final Categorie cat1= new Categorie("Professionnels");
			final Categorie cat= (Categorie) crb.httpRequestXMLBodyCategorie(cat1, "categorie/create",utilisateurAdmin);
			
			final Adresse adresse = new Adresse("691-735 Avenue du Las","33127","Saint-Jean-D'Illac","France", (float) -0.787779, (float) 44.808193);
			final Date birthDate = new Date(0);
			Connexion co = new Connexion("login8",CryptHandler.encodedPw("pass8"));
			final Utilisateur utilisateur= new Utilisateur("Jean","Casimir-Perier",co,"mail8@mail.com","8888888888",adresse,birthDate);
			final Utilisateur utilisateurPost= (Utilisateur) crb.httpRequestXMLBody(utilisateur, "user/create");
			
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"OutilPro1","savoir être pro",true,cat,88, new Date(0), myDate,chemin+"outils.jpg"), "tool/create");
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"OutilPro2","savoir être pro",true,cat,56, new Date(0), myDate,chemin+"outils.jpg"), "tool/create");
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"OutilPro3","savoir être pro",false,cat,22, new Date(0), myDate,chemin+"outils.jpg"), "tool/create");
			
			
			int i = utilisateurPost.getId();
			OutilsDTO dto =(OutilsDTO) crb.httpGetRequest("tool/user/available",i );
			
			LOG.info("\n\n\n");
			LOG.info("taille liste Outils:" +dto.size());
			LOG.info("\n\n\n");
			
			LOG.info("liste des outils:\n");
			
			Iterator<Outil> ito=dto.getListeOutils().iterator();
			while(ito.hasNext()){
				
				final Outil Outil = ito.next();
				LOG.info(Outil.getId()+" "+Outil.getNom()+" "+Outil.getCategorie()+" "+Outil.getDescription());
				
			}
			
			
			Assert.assertTrue( dto.getListeOutils().size() > 0);
			LOG.info("\n\n\n");
		}
		catch(final RuntimeException r){
			LOG.error("getAllOutils failed",r);
			throw r;
		}
	}
	
	/**
	 * test unitaire de l'API Criteria pour recherche d'outils
	 */
	@Test
	public final void testAPICriteria() throws Exception {

		try {

			Categorie cat1= new Categorie("Plomberie");
			Categorie cat= (Categorie) crb.httpRequestXMLBodyCategorie(cat1, "categorie/create",utilisateurAdmin);
			
			final Adresse adresse = new Adresse("9 Allée des Fleurs","33320","Eysines","France", (float) -0.636744, (float) 44.865434);
			final Date birthDate = new Date(0);
			Connexion co = new Connexion("login9",CryptHandler.encodedPw("pass9"));
			final Utilisateur utilisateur= new Utilisateur("Marie-François-Sadi","Carnot",co,"mail9@mail.com","9999999999",adresse,birthDate);
			final Utilisateur utilisateurPost= (Utilisateur) crb.httpRequestXMLBody(utilisateur, "user/create");
			Assert.assertNotSame(utilisateurPost, null);
			
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"Plummeau","savoir plummer",true,cat,54, new Date(0), myDate,chemin+"plumeau.jpg"), "tool/create");
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"Tournevis","savoir tournevisser",false,cat,56, new Date(0), myDate,chemin+"tournevis.jpg"), "tool/create");
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"Clé molette","savoir clé molette",true,cat,35, new Date(0), myDate,chemin+"clémolette.jpg"), "tool/create");


			cat1= new Categorie("Toiture");
			Categorie cat3= (Categorie) crb.httpRequestXMLBodyCategorie(cat1, "categorie/create",utilisateurAdmin);
			
			cat1= new Categorie("BTP");
			Categorie cat2= (Categorie) crb.httpRequestXMLBodyCategorie(cat1, "categorie/create",utilisateurAdmin);
			
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"Tuile","savoir tuiller",false,cat3,55, new Date(0), myDate,chemin+"tuile.jpg"), "tool/create");
			crb.httpRequestXMLBody(new Outil(utilisateurPost,"Remorque","savoir remorquer",true,cat2,59, new Date(0), myDate,chemin+"remorque.jpg"), "tool/create");
			
			final Outil o = new Outil();
			o.setCategorie(cat);
			o.setDisponible(true);
			
			final Marshaller marshaller = jaxbc.createMarshaller();
			marshaller.setProperty(Marshaller.JAXB_ENCODING, "UTF-8");
			final java.io.StringWriter sw = new StringWriter();
			marshaller.marshal(o, sw);

			final ClientRequest request = new ClientRequest(
					"http://localhost:8080/rest/tool/criteria");
			request.body("application/xml", sw.toString());
			final ClientResponse<String> response = request.post(String.class);

			if (response.getStatus() == 200) {
				LOG.info(response.getEntity());
				Assert.assertTrue(!response.getEntity().isEmpty());
			}
			

		} catch (final RuntimeException re) {
			LOG.error("criteria failed", re);
			throw re;
		}
	}
	
	/**
	 * test unitaire pour obtenir la liste des Outils d'une catégorie en particulier
	 */
	@Test
	public final void testGetAllOutilsFromCategory() {
		try{
			final Categorie categorie = new Categorie("Jardin");
			final Categorie categoriePost = (Categorie) crb.httpRequestXMLBodyCategorie(categorie, "categorie/create",utilisateurAdmin);
			
			Utilisateur user1= new Utilisateur("Jules", "Grevy", new Connexion("loginTestOutil",CryptHandler.encodedPw( "pwd")), "test@test", "0505050505", new Adresse(), new Date());
			Utilisateur user= (Utilisateur) crb.httpRequestXMLBody(user1, "user/create");
			
			crb.httpRequestXMLBody(new Outil(user,"Rateau","savoir ratisser",true,categoriePost,1, new Date(0), myDate,chemin+"rateau.jpg"), "tool/create");
			crb.httpRequestXMLBody(new Outil(user,"Pelle","savoir pelleter",true,categoriePost,2, new Date(0), myDate,chemin+"pelle.jpg"), "tool/create");
			crb.httpRequestXMLBody(new Outil(user,"Tronçonneuse","savoir tronçonner",false,categoriePost,3, new Date(0), myDate,chemin+"tronconneuse.jpg"), "tool/create");

			int i = categoriePost.getId();
			OutilsDTO dto =(OutilsDTO) crb.httpGetRequest("tool/categorie",i );
			
			LOG.info("\n\n\n");
			LOG.info("taille liste Outils:" +dto.size());
			LOG.info("\n\n\n");
			
			LOG.info("liste des outils:\n");
			
			Iterator<Outil> ito=dto.getListeOutils().iterator();
			while(ito.hasNext()){
				
				final Outil Outil = ito.next();
				LOG.info(Outil.getId()+" "+Outil.getNom()+" "+Outil.getCategorie()+" "+Outil.getDescription());
				
			}			
			
			Assert.assertTrue( dto.getListeOutils().size() == 3);
			LOG.info("\n\n\n");
		}
		catch(final RuntimeException r){
			LOG.error("getAllOutils failed",r);
			throw r;
		}
	}
	
}
