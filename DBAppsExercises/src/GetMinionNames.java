import javax.xml.crypto.dsig.spec.XSLTTransformParameterSpec;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class GetMinionNames {
    private static final String GET_MINION_NAMES_QUERY =
            "select m.name, m.age from minions AS m " +
                    "join minions_villains as mv on m.id = mv.minion_id " +
                    "where mv.villain_id = ?";

    private static final String GET_VILLAIN_NAME_QUERY = "select v.name from villains AS v where v.id = ?";

    public static void main(String[] args) throws SQLException {
         Scanner scanner = new Scanner(System.in);

        final Connection connection = Utils.getSQLConnection();

        int villainId = Integer.parseInt(scanner.nextLine());

        final PreparedStatement statementVillainName = connection.prepareStatement(GET_VILLAIN_NAME_QUERY);
        statementVillainName.setInt(1, villainId);
        final ResultSet resultSetVillainName = statementVillainName.executeQuery();


        if(!resultSetVillainName.next()){
            System.out.printf("No villain with ID %d exists in the database.", villainId);
            connection.close();
            return;
        }

        final String villainName = resultSetVillainName.getString(Constants.COLUMN_LABEL_NAME);
        System.out.printf("Villain: %s%n", villainName);

        final PreparedStatement statementMinionNames = connection.prepareStatement(GET_MINION_NAMES_QUERY);
        statementMinionNames.setInt(1, villainId);
        final ResultSet resultSetMinionNames = statementMinionNames.executeQuery();

        int index = 1;
        while (resultSetMinionNames.next()) {
            final String minionName = resultSetMinionNames.getString(Constants.COLUMN_LABEL_NAME);
            final int minionAge = resultSetMinionNames.getInt(Constants.COLUMN_LABEL_AGE);
            System.out.printf("%d. %s %d%n",index, minionName, minionAge);
            index++;
        }
        connection.close();
    }
}
