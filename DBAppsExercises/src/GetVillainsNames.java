import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetVillainsNames {
    private static final String GET_VILLAINS_NAMES_QUERY =
            "select v.name, count(distinct mv.minion_id) AS count_minions from villains AS v" +
                    " join minions_villains AS mv on v.id = mv.villain_id" +
                    " group by mv.villain_id" +
                    " having count_minions > ?" +
                    " order by count_minions";
    private static final String COLUMN_LABEL_MINIONS_COUNT = "count_minions";

    public static void main(String[] args) throws SQLException {
        final Connection connection = Utils.getSQLConnection();
        final PreparedStatement statement = connection.prepareStatement(GET_VILLAINS_NAMES_QUERY);
        statement.setInt(1, 15);
        final ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            final String villainName = resultSet.getString(Constants.COLUMN_LABEL_NAME);
            final int minionsCount = resultSet.getInt(COLUMN_LABEL_MINIONS_COUNT);
            System.out.printf("%s %d ",villainName, minionsCount);
        }
        connection.close();
    }
}
