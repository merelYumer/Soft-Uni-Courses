import java.io.StringReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class RemoveVillain {
    private static final String DELETE_VILLAIN_BY_ID = "delete from villains where id = ?";
    private static final String GET_VILLAIN_NAME_BY_ID = "select name from villains where id = ?";
    private static final String DELETE_MINIONS_VILLAINS_BY_VILLAIN_ID = "delete from minions_villains where villain_id = ?";

    public static void main(String[] args) throws SQLException {
        final Connection connection = Utils.getSQLConnection();
        Scanner scanner = new Scanner(System.in);

        int villainId = Integer.parseInt(scanner.nextLine());

        final PreparedStatement preparedStatementGetNameDeletedVillain = connection.prepareStatement(GET_VILLAIN_NAME_BY_ID);
        preparedStatementGetNameDeletedVillain.setInt(1, villainId);
        final ResultSet resultGetDeletedVillainName = preparedStatementGetNameDeletedVillain.executeQuery();

        if(!resultGetDeletedVillainName.next()){
            System.out.println("No such villain was found");
            return;
        }

        connection.setAutoCommit(false);
        try {


            PreparedStatement preparedStatementDeleteVillainInMinionsVillains = connection.prepareStatement(DELETE_MINIONS_VILLAINS_BY_VILLAIN_ID);
            preparedStatementDeleteVillainInMinionsVillains.setInt(1, villainId);
            int deletedMinionsCount = preparedStatementDeleteVillainInMinionsVillains.executeUpdate();

            PreparedStatement preparedStatementDeleteVillain = connection.prepareStatement(DELETE_VILLAIN_BY_ID);
            preparedStatementDeleteVillain.setInt(1, villainId);
            preparedStatementDeleteVillain.executeUpdate();

            connection.commit();

            String deletedVillainName = resultGetDeletedVillainName.getString(Constants.COLUMN_LABEL_NAME);
            System.out.printf("%s was deleted%n", deletedVillainName);
            System.out.printf("%d minions released", deletedMinionsCount);
        }catch (SQLException e){
            e.printStackTrace();
            connection.rollback();
        }
        connection.close();
    }
}
