import entities.Employee;
import entities.Town;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;

public class EmployeesWithSalaryOver50000 {
    private static final String SELECT_EMPLOYEES = "SELECT e.firstName FROM Employee e where e.salary > 50000";
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager entityManager = factory.createEntityManager();

        entityManager.getTransaction().begin();

        Query selectEmployees = entityManager.createQuery(SELECT_EMPLOYEES, String.class);
        List<String> employeeList = selectEmployees.getResultList();

        for (String employee : employeeList) {
            System.out.println(employee);
        }

        entityManager.getTransaction().commit();
        entityManager.close();
    }
}
