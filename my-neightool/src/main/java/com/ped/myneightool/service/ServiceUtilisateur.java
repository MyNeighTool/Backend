package com.ped.myneightool.service;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ped.myneightool.dao.impl.UtilisateurDAOImpl;
import com.ped.myneightool.dao.itf.ItfUtilisateurDAO;
import com.ped.myneightool.dto.UtilisateursDTO;
import com.ped.myneightool.model.Utilisateur;



@Path("/user")
public class ServiceUtilisateur {

	private static final Logger LOG = LoggerFactory
			.getLogger(ServiceUtilisateur.class);
	
	private static ItfUtilisateurDAO utilisateurDAO = new UtilisateurDAOImpl();
	
	@Context
	private SecurityContext security;

	/**
	 * Classe répertoriant les services en relation avec les utilisateurs
	 */
	public ServiceUtilisateur() {

	}

	/**
	 * Créer un utilisateur
	 * @param u
	 * @return
	 */
	@PermitAll
	@POST
	@Path("/create")
	@Consumes({"application/xml","application/json"})
	public Response createUtilisateur(final Utilisateur u) {
		try{
			utilisateurDAO.createUtilisateur(u);
		} catch (Exception e) {
			LOG.error("erreur service /user/create");
			e.printStackTrace();
		}
		
		return Response.ok(u).build();
	}

	/**
	 * Mettre à jour un utilisateur
	 * @param u
	 * @return
	 */
	@RolesAllowed({"USER","ADMIN"})
	@POST
	@Path("/update")
	@Consumes("application/xml")
	public Response updateUtilisateur(final Utilisateur u) {
		utilisateurDAO.updateUtilisateur(u);
		return Response.ok(u).build();
	}
	
	/**
	 * Supprimer un utilisateur
	 * @param id
	 */
	@RolesAllowed("ADMIN")
	@GET
	@Path("/delete/{id}")
	public void deleteUtilisateur(@PathParam("id") final int id) {
					
		final Utilisateur utilisateur = utilisateurDAO.findById(id);
		utilisateurDAO.deleteUtilisateur(utilisateur);
	}

	/**
	 * Obtenir un utilisateur par son ID
	 * @param id
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/{id}")
	@Produces("application/xml")
	public Utilisateur getUtilisateur(@PathParam("id") final int id) {
		final Utilisateur a = utilisateurDAO.findById(id);
		return a;
	}
	
	/**
	 * Obtenir un utilisateur par son LOGIN
	 * @param login
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/login/{login}")
	@Produces("application/xml")
	public Utilisateur getUtilisateurByLogin(@PathParam("login") final String login) {
		final Utilisateur a = utilisateurDAO.findByLogin(login);
		return a;
	}
	
	/**
	 * Obtenir un utilisateur par son EMAIL
	 * @param email
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/email/{email}")
	@Produces("application/xml")
	public Utilisateur getUtilisateurByEmail(@PathParam("email") final String email) {
		final Utilisateur a = utilisateurDAO.findByEmail(email);
		return a;
	}

	/**
	 * Obtenir la liste des utilisateurs par ordre descendant
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/list")
	@Produces("application/xml")
	public UtilisateursDTO getAllUtilisateursDesc() {
		UtilisateursDTO utilisateurs = new UtilisateursDTO();
		try {
			utilisateurs = utilisateurDAO.findAll();
		} catch (Exception e) {
			LOG.error("erreur service /list");
			e.printStackTrace();
		}
		return utilisateurs;

	}
	
	/**
	 * Obtenir la liste des utilisateurs par ordre ascendant
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/listAsc")
	@Produces("application/xml")
	public UtilisateursDTO getAllUtilisateursAsc() {
		UtilisateursDTO utilisateurs = new UtilisateursDTO();
		try {
			utilisateurs = utilisateurDAO.findAllAsc();
		} catch (Exception e) {
			LOG.error("erreur service /list");
			e.printStackTrace();
		}
		return utilisateurs;

	}
		
}
