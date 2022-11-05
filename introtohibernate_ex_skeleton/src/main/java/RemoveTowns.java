import entities.Address;
import entities.Employee;
import entities.Town;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;
import java.util.Scanner;

public class RemoveTowns {
    private static final String SELECT_TOWN = "SELECT t FROM Town t WHERE t.name = :tName";
    private static final String SELECT_ADDRESSES_BY_TOWN_NAME = "SELECT a FROM Address AS a WHERE a.town.name = :tName";
    private final static String PRINT_FORMAT = "%d address%s in %s deleted%n";
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager entityManager = factory.createEntityManager();
        Scanner scanner = new Scanner(System.in);

        String name = scanner.nextLine();

        entityManager.getTransaction().begin();

        Town town = entityManager.createQuery(SELECT_TOWN, Town.class)
                .setParameter("tName", name).getSingleResult();

        List<Address> addresses = entityManager
                .createQuery(SELECT_ADDRESSES_BY_TOWN_NAME, Address.class)
                .setParameter("tName", name)
                .getResultList();

        addresses.forEach(address -> {
            for (Employee employee : address.getEmployees()) {
                employee.setAddress(null);
            }
            address.setTown(null);
            entityManager.remove(address);
        });

        entityManager.remove(town);

        entityManager.getTransaction().commit();

        System.out.printf(PRINT_FORMAT,
                addresses.size(),
                addresses.size() != 1 ? "es" : "",
                town.getName());

        entityManager.close();
    }
}
