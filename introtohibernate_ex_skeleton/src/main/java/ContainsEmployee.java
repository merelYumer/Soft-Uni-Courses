import entities.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;
import java.util.Scanner;


public class ContainsEmployee {
    private static final String SELECT_EMPLOYEES = "SELECT count(e) FROM Employee e where e.firstName = :fn AND e.lastName = :ln";
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager entityManager = factory.createEntityManager();

        Scanner scanner = new Scanner(System.in);
        String[] fullName = scanner.nextLine().split(" ");
        String firstName = fullName[0];
        String lastName = fullName[1];


        entityManager.getTransaction().begin();

        Long result = entityManager.createQuery(SELECT_EMPLOYEES, Long.class)
                .setParameter("fn", firstName)
                .setParameter("ln", lastName)
                .getSingleResult();


        if(result == 0){
            System.out.println("NO");
        }else {
            System.out.println("YES");
        }

        entityManager.getTransaction().commit();
        entityManager.close();
    }
}
