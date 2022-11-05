import entities.Employee;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.Scanner;

public class GetEmployeeWithProject {
    private static final String SELECT_EMPLOYEE = "select e from Employee e where e.id = :id";
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager entityManager = factory.createEntityManager();
        Scanner scanner = new Scanner(System.in);

        int id = Integer.parseInt(scanner.nextLine());

        entityManager.getTransaction().begin();

        String employee = entityManager.createQuery(SELECT_EMPLOYEE, Employee.class).setParameter("id", id).getSingleResult().toString();
        System.out.println(employee);

        entityManager.getTransaction().commit();
        entityManager.close();
    }
}
