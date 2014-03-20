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

import com.ped.myneightool.dao.impl.CategorieDAOImpl;
import com.ped.myneightool.dao.itf.ItfCategorieDAO;
import com.ped.myneightool.dto.CategoriesDTO;
import com.ped.myneightool.model.Categorie;


@Path("/categorie")
public class ServiceCategorie {

	private static final Logger LOG = LoggerFactory
			.getLogger(ServiceCategorie.class);
	
	private static ItfCategorieDAO categorieDAO = new CategorieDAOImpl();

	/**
	 * Classe répertoriant les services en relation avec les catégories
	 */
	public ServiceCategorie() {

	}

	/**
	 * Créer une catégorie
	 * @param c
	 * @return
	 */
	@RolesAllowed("ADMIN")
	@POST
	@Path("/create")
	@Consumes({"application/xml","application/json"})
	public Response createCategorie(final Categorie c) {
		try{
			categorieDAO.createCategorie(c);
		} catch (Exception e) {
			LOG.error("erreur service /categorie/create");
			e.printStackTrace();
		}
		
		return Response.ok(c).build();
	}
	
	/**
	 * Supprimer une catégorie
	 * @param id
	 */
	@RolesAllowed("ADMIN")
	@GET
	@Path("/delete/{id}")
	public void deleteCategorie(@PathParam("id") final int id) {
		final Categorie categorie = categorieDAO.findById(id);
		categorieDAO.deleteCategorie(categorie);
	}
	
	/**
	 * Mettre à jour une catégorie
	 * @param c
	 * @return
	 */
	@RolesAllowed("ADMIN")
	@POST
	@Path("/update")
	@Consumes("application/xml")
	public Response updateCategorie(final Categorie c) {
		categorieDAO.updateCategorie(c);
		return Response.ok(c).build();
	}

	/**
	 * Obtenir une catégorie par son ID
	 * @param id
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/{id}")
	@Produces("application/xml")
	public Categorie getCategorie(@PathParam("id") final int id) {
		final Categorie c = categorieDAO.findById(id);
		return c;
	}
	
	/**
	 * Obtenir une catégorie par son NOM
	 * @param name
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/name/{name}")
	@Produces("application/xml")
	public Categorie getCategorieByName(@PathParam("name") final String name) {
		final Categorie c = categorieDAO.findByName(name);
		return c;
	}
	
	/**
	 * Obtenir la liste de toutes les catégories
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/list")
	@Produces("application/xml")
	public CategoriesDTO getAllCategories() {
		CategoriesDTO categories = new CategoriesDTO();
		
		try {
			categories = categorieDAO.findAll();
		} catch (Exception e) {
			LOG.error("erreur service /list");
			e.printStackTrace();
		}
		return categories;

	}
	
	/**
	 * Obtenir la liste des catégories par ordre ascendant
	 * @return
	 */
	@PermitAll
	@GET
	@Path("/listAsc")
	@Produces("application/xml")
	public CategoriesDTO getAllCategoriesByOrderAsc() {
		CategoriesDTO categories = new CategoriesDTO();
		
		try {
			categories = categorieDAO.findAllByOrderAsc();
		} catch (Exception e) {
			LOG.error("erreur service /list");
			e.printStackTrace();
		}
		return categories;

	}
	
}
