import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


public class EmployeesMaximumSalaries {
    private final static String FIND_MAX_SALARY_DEPARTMENTS = "select e.department.name from Employee e group by e.department having max(e.salary) not between 30000 and 70000 order by e.department.id";
    private final static String FIND_MAX_SALARY = "select max(e.salary) from Employee e group by e.department having max(e.salary) not between 30000 and 70000 order by e.department.id";
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager entityManager = factory.createEntityManager();

        entityManager.getTransaction().begin();

        List<String> departmentLists = entityManager.createQuery(FIND_MAX_SALARY_DEPARTMENTS, String.class).getResultList();
        List<BigDecimal> maxSalaryLists = entityManager.createQuery(FIND_MAX_SALARY, BigDecimal.class).getResultList();

        Map<String, BigDecimal> dataMap = new LinkedHashMap<>();
        for (int i = 0; i < departmentLists.size(); i++) {
                dataMap.put(departmentLists.get(i), maxSalaryLists.get(i));
        }

        dataMap.entrySet().stream().forEach(e -> System.out.printf("%s %.2f%n", e.getKey(), e.getValue()));

        entityManager.getTransaction().commit();
        entityManager.close();
    }
}
