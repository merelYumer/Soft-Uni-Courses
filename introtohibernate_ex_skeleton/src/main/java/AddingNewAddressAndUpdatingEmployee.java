import entities.Address;
import entities.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;
import java.util.Scanner;


public class AddingNewAddressAndUpdatingEmployee {
    private static final String SELECT_EMPLOYEE_LAST_NAMES = "select e from Employee e where e.lastName = :ln";
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager entityManager = factory.createEntityManager();

        Scanner scanner = new Scanner(System.in);

        String lastName = scanner.nextLine();

        entityManager.getTransaction().begin();

        Address addAddress = new Address();
        addAddress.setText("Vitoshka 15");
        entityManager.persist(addAddress);

        List<Employee> employeeList = entityManager.createQuery(SELECT_EMPLOYEE_LAST_NAMES, Employee.class).setParameter("ln", lastName).getResultList();

        for (Employee name : employeeList) {
            name.setAddress(addAddress);
        }

        entityManager.getTransaction().commit();
        entityManager.close();
    }
}
