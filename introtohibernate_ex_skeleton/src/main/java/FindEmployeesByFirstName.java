import entities.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;
import java.util.Scanner;

public class FindEmployeesByFirstName {
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager entityManager = factory.createEntityManager();
        Scanner scanner = new Scanner(System.in);

        String input = scanner.nextLine();
        String pattern = input + "%";

        entityManager.getTransaction().begin();

        List<Employee> employeeList = entityManager.createQuery("select e from Employee e where e.firstName like :pt", Employee.class)
                .setParameter("pt", pattern).getResultList();

        for (Employee employee : employeeList) {
            System.out.printf("%s %s - %s - ($%.2f)%n", employee.getFirstName(), employee.getLastName(), employee.getJobTitle(), employee.getSalary());
        }

        entityManager.getTransaction().commit();
        entityManager.close();

    }
}
