import entities.Town;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;

public class ChangeCasing {
    private static final String SELECT_TOWN_NAMES = "Select t from Town t";

    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager entityManager = factory.createEntityManager();
        entityManager.getTransaction().begin();

        Query selectTowns = entityManager.createQuery(SELECT_TOWN_NAMES, Town.class);
        List<Town> townList = selectTowns.getResultList();

        for (Town town : townList) {
            String name = town.getName();
            if(name.length() <= 5){
                town.setName(name.toUpperCase());
                entityManager.persist(town);
            }
        }


        entityManager.getTransaction().commit();
        entityManager.close();

    }
}
