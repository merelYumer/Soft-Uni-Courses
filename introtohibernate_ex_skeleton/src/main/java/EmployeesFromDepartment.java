import entities.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;

public class EmployeesFromDepartment {
    private static final String SELECT_EMPLOYEES = "select e from Employee e where e.department.name = :dt order by e.salary, e.id";
    public static void main(String[] args) {

        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager entityManager = factory.createEntityManager();

        entityManager.getTransaction().begin();

        String department = "Research and Development";
        List<Employee> employeeList = entityManager.createQuery(SELECT_EMPLOYEES, Employee.class).setParameter("dt", department).getResultList();

        for (Employee employee : employeeList) {
            System.out.printf("%s %s from Research and Development - $%.2f%n", employee.getFirstName(), employee.getLastName(), employee.getSalary());
        }

        entityManager.getTransaction().commit();
        entityManager.close();

    }
}
