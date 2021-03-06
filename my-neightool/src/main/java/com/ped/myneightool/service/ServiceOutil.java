package com.ped.myneightool.service;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ped.myneightool.dao.impl.OutilDAOImpl;
import com.ped.myneightool.dao.itf.ItfOutilDAO;
import com.ped.myneightool.dto.OutilsDTO;
import com.ped.myneightool.model.Outil;



@Path("/tool")
public class ServiceOutil {

	private static final Logger LOG = LoggerFactory
			.getLogger(ServiceOutil.class);
	
	private static ItfOutilDAO outilDAO = new OutilDAOImpl();

	/**
	 * Classe répertoriant les services en relation avec les outils	
	 */
	public ServiceOutil() {

	}

	
	/**
	 * Créer un outil
	 * @param o
	 * @return
	 */
	@RolesAllowed({"USER","ADMIN"})
	@POST
	@Path("/create")
	@Consumes({"application/xml","application/json"})
	public Response createOutil(final Outil o) {
		try{
			outilDAO.createOutil(o);
		} catch (Exception e) {
			LOG.error("erreur service /user/create");
			e.printStackTrace();
		}
		
		return Response.ok(o).build();
	}

	/**
	 * Mettre à jour un outil
	 * @param o
	 * @return
	 */
	@RolesAllowed({"USER","ADMIN"})
	@POST
	@Path("/update")
	@Consumes("application/xml")
	public Response updateOutil(final Outil o) {
		outilDAO.updateOutil(o);
		return Response.ok(o).build();
	}
	
	/**
	 * Supprimer un outil
	 * @param id
	 */
	@RolesAllowed({"USER","ADMIN"})
	@GET
	@Path("/delete/{id}")
	public void deleteOutil(@PathParam("id") final int id) {
		final Outil o = outilDAO.findById(id);
		outilDAO.deleteOutil(o);
	}

	/**
	 * Obtenir un outil
	 * @param id
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/{id}")
	@Produces("application/xml")
	public Outil getOutil(@PathParam("id") final int id) {
		final Outil o = outilDAO.findById(id);
		return o;
	}

	/**
	 * Obtenir la liste de tous les outils
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/list")
	@Produces("application/xml")
	public OutilsDTO getAllTools() {
		OutilsDTO outils = new OutilsDTO();
		try {
			outils = outilDAO.findAll();
		} catch (Exception e) {
			LOG.error("erreur service /list");
			e.printStackTrace();
		}
		return outils;

	}
	
	/**
	 * Obtenir la liste de tous les outils par ordre ascendant
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/listAsc")
	@Produces("application/xml")
	public OutilsDTO getAllToolsAscOrder() {
		OutilsDTO outils = new OutilsDTO();
		try {
			outils = outilDAO.findAllAscOrder();
		} catch (Exception e) {
			LOG.error("erreur service /list");
			e.printStackTrace();
		}
		return outils;

	}
	
	/**
	 * Obtenir la liste de tous les outils disponibles
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/list/available")
	@Produces("application/xml")
	public OutilsDTO getAllToolsAvailable() {
		OutilsDTO outils = new OutilsDTO();
		try {
			outils = outilDAO.findAllAvailable();
		} catch (Exception e) {
			LOG.error("erreur service /list/available");
			e.printStackTrace();
		}
		return outils;

	}
	
	/**
	 * Obtenir la liste des outils d'un utilisateur par son ID
	 * @param UtilisateurId
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/user/{id}")
	@Produces({ "application/xml", "application/json" })
	public OutilsDTO findToolsOfUser(@PathParam("id") final int UtilisateurId) {
		OutilsDTO outils = outilDAO.findToolsOfUser(UtilisateurId);
		return outils;
	}
	
	/**
	 * Obtenir la liste des outils disponibles d'un utilisateur par son ID
	 * @param UtilisateurId
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/user/available/{id}")
	@Produces({ "application/xml", "application/json" })
	public OutilsDTO findToolsOfUserAvailable(@PathParam("id") final int UtilisateurId) {
		OutilsDTO outils = outilDAO.findToolsOfUserAvailable(UtilisateurId);
		return outils;
	}
	
	/**
	 * Obtenir une liste d'outil avec une recherche par critères
	 * @param o
	 * @return
	 */
	@RolesAllowed({"USER","ADMIN"})
	@POST
	@Path("/criteria")
	@Produces("application/xml")
	public OutilsDTO getToolsByCriteria(final Outil o) {
		final OutilsDTO outils = outilDAO.findByCriteria(o);
		return outils;
	}
	
	/**
	 * Obtenir une liste d'outil d'une catégorie spécifique par son ID
	 * @param CategorieId
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/categorie/{idCategorie}")
	@Produces("application/xml")
	public OutilsDTO findToolsOfCategory(@PathParam("idCategorie") final int CategorieId) {
		OutilsDTO outils = outilDAO.findToolsOfCategory(CategorieId);
		return outils;
	}
	
	/**
	 * Obtenir une liste d'outil disponible d'une catégorie spécifique par son ID
	 * @param CategorieId
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/categorie/available/{idCategorie}")
	@Produces("application/xml")
	public OutilsDTO findToolsOfCategoryAvailable(@PathParam("idCategorie") final int CategorieId) {
		OutilsDTO outils = outilDAO.findToolsOfCategoryAvailable(CategorieId);
		return outils;
	}
		
}
