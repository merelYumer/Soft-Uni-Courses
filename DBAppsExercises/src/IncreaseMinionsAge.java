import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class IncreaseMinionsAge {
    private static final String UPDATE_MINIONS_AGE = "update minions m set m.`age` = m.`age` + 1 where m.id = ?";
    private static final String UPDATE_MINIONS_NAMES = "update minions m set m.`name` = lower(m.`name`) where m.id = ?";
    private static final String SELECT_ALL_MINIONS = "select name, age from minions";

    public static void main(String[] args) throws SQLException {
        Scanner scanner = new Scanner(System.in);
        final Connection connection = Utils.getSQLConnection();

        String[] idToUpdate = scanner.nextLine().split(" ");
        for (int i = 0; i < idToUpdate.length; i++) {
            int idNumber = Integer.parseInt(idToUpdate[i]);

            PreparedStatement preparedStatementUpdateMinionsAge = connection.prepareStatement(UPDATE_MINIONS_AGE);
            preparedStatementUpdateMinionsAge.setInt(1, idNumber);
            preparedStatementUpdateMinionsAge.executeUpdate();

            PreparedStatement preparedStatementUpdateMinionsNames = connection.prepareStatement(UPDATE_MINIONS_NAMES);
            preparedStatementUpdateMinionsNames.setInt(1, idNumber);
            preparedStatementUpdateMinionsNames.executeUpdate();
        }

        final PreparedStatement preparedStatementSelectAllMinions = connection.prepareStatement(SELECT_ALL_MINIONS);
        final ResultSet resultGetAllMinions = preparedStatementSelectAllMinions.executeQuery();

        while (resultGetAllMinions.next()) {
            System.out.printf("%s %d%n", resultGetAllMinions.getString(Constants.COLUMN_LABEL_NAME), resultGetAllMinions.getInt(Constants.COLUMN_LABEL_AGE));
        }

    }
}
