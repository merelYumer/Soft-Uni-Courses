import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class IncreaseAgeStoredProcedure {
    private static final String CALL_PROCEDURE = "call minions_db.usp_get_older(?)";
    private static final String SELECT_ALL_MINIONS = "select name, age from minions where id = ?";

    public static void main(String[] args) throws SQLException {
        Scanner scanner = new Scanner(System.in);
        final Connection connection = Utils.getSQLConnection();

        int idNumber = Integer.parseInt(scanner.nextLine());

        PreparedStatement preparedStatementUpdateMinionsAge = connection.prepareStatement(CALL_PROCEDURE);
        preparedStatementUpdateMinionsAge.setInt(1, idNumber);
        preparedStatementUpdateMinionsAge.executeUpdate();

        final PreparedStatement preparedStatementSelectAllMinions = connection.prepareStatement(SELECT_ALL_MINIONS);
        preparedStatementSelectAllMinions.setInt(1, idNumber);
        final ResultSet resultGetAllMinions = preparedStatementSelectAllMinions.executeQuery();
        resultGetAllMinions.next();
        System.out.printf("%s %d%n", resultGetAllMinions.getString(Constants.COLUMN_LABEL_NAME), resultGetAllMinions.getInt(Constants.COLUMN_LABEL_AGE));
    }
}
