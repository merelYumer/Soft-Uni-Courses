import entities.Address;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class AddressesWithEmployeeCount {
    private static final String SELECT_ADDRESSES = "select a from Address a order by a.employees.size desc";
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager entityManager = factory.createEntityManager();

        entityManager.getTransaction().begin();

        List<Address> addressList = entityManager.createQuery(SELECT_ADDRESSES, Address.class).setMaxResults(10).getResultList();

        for (Address address : addressList) {
            System.out.printf("%s - %d employees%n", address.getText(), address.getEmployees().size());
        }

        entityManager.getTransaction().commit();
        entityManager.close();
    }
}
