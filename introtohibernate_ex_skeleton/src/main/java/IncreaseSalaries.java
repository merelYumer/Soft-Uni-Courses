import entities.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class IncreaseSalaries {
    private static final String UPDATE_SALARY = "update Employee e set e.salary = e.salary * 1.12 where e.department.id in(1, 2, 4, 11)";
    private static final String SELECT_EMPLOYEES = "select e from Employee e where e.department.id in(1, 2, 4, 11)";
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager entityManager = factory.createEntityManager();

        entityManager.getTransaction().begin();

        entityManager.createQuery(UPDATE_SALARY).executeUpdate();

        List<Employee> employeeList = entityManager.createQuery(SELECT_EMPLOYEES, Employee.class).getResultList();
        for (Employee employee : employeeList) {
            System.out.printf("%s %s ($%.2f)%n", employee.getFirstName(), employee.getLastName(), employee.getSalary());
        }


        entityManager.getTransaction().commit();
        entityManager.close();

    }
}
