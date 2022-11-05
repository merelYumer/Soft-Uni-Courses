import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class ChangeTownNamesCasing {
    final static String UPDATE_TOWN_NAMES_QUERY = "update towns t set name = upper(name) where t.country = ?";
    final static String SELECT_ALL_UPDATED_TOWNS_QUERY = "select name from towns where country = ?";

    public static void main(String[] args) throws SQLException {
        final Connection connection = Utils.getSQLConnection();
        Scanner scanner = new Scanner(System.in);

        String countryName = scanner.nextLine();
        List<String> townNames = new ArrayList<>();

        PreparedStatement preparedStatementUpdateTownNames = connection.prepareStatement(UPDATE_TOWN_NAMES_QUERY);
        preparedStatementUpdateTownNames.setString(1, countryName);
        int updatedTownCount = preparedStatementUpdateTownNames.executeUpdate();

        if(updatedTownCount == 0){
            System.out.println("No town names were affected.");
            return;
        }
        System.out.printf("%d town names were affected.%n", updatedTownCount);

        final PreparedStatement preparedStatementGetUpdatedTownNames = connection.prepareStatement(SELECT_ALL_UPDATED_TOWNS_QUERY);
        preparedStatementGetUpdatedTownNames.setString(1, countryName);
        final ResultSet resultGetUpdatedTownNames = preparedStatementGetUpdatedTownNames.executeQuery();

        while (resultGetUpdatedTownNames.next()){
            townNames.add(resultGetUpdatedTownNames.getString(Constants.COLUMN_LABEL_NAME));
        }
        System.out.println(townNames);
    }
}
