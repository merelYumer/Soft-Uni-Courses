import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class AddMinion {
    private static final String GET_VILLAIN_ID_QUERY = "select v.id from villains AS v where v.name = ?";
    private static final String GET_TOWN_ID_QUERY = "select id from towns where name = ?";
    private static final String GET_ADDED_TOWN_ID_QUERY = "select id from towns order by id DESC limit 1";
    private static final String GET_ADDED_VILLAIN_ID_QUERY = "select id from villains order by id DESC limit 1";
    private static final String GET_ADDED_MINION_ID_QUERY = "select id from minions order by id DESC limit 1";
    private static final String ADD_VILLAIN_QUERY = "insert into villains(name, evilness_factor) values(?, 'evil')";
    private static final String ADD_TOWN_QUERY = "insert into towns(name) values(?)";
    private static final String ADD_MINION_QUERY = "insert into minions(name, age, town_id) values(?, ?, ?)";
    private static final String ADD_MINION_VILLAIN_QUERY = "insert into minions_villains(minion_id, villain_id) values (?, ?)";

    public static void main(String[] args) throws SQLException {
        Scanner scanner = new Scanner(System.in);
        final Connection connection = Utils.getSQLConnection();

        String[] minionInput = scanner.nextLine().split(" ");
        String[] villainInput = scanner.nextLine().split(" ");

        String minionName = minionInput[1];
        int minionAge = Integer.parseInt(minionInput[2]);
        String minionTown = minionInput[3];
        String villainName = villainInput[1];

        final PreparedStatement statementTownId = connection.prepareStatement(GET_TOWN_ID_QUERY);
        statementTownId.setString(1, minionTown);
        final ResultSet resultGetTownName = statementTownId.executeQuery();

        int townId = 0;
        if(resultGetTownName.next()){
            townId = resultGetTownName.getInt(Constants.COLUMN_LABEL_ID);
        }else{
            final PreparedStatement statementAddTown = connection.prepareStatement(ADD_TOWN_QUERY);
            statementAddTown.setString(1, minionTown);
            statementAddTown.executeUpdate();

            final PreparedStatement statementGetAddedTownId = connection.prepareStatement(GET_ADDED_TOWN_ID_QUERY);
            final ResultSet resultGetAddedTownId = statementGetAddedTownId.executeQuery();
            resultGetAddedTownId.next();
            townId = resultGetAddedTownId.getInt(Constants.COLUMN_LABEL_ID);
            System.out.printf("Town %s was added to the database.%n", minionTown);
        }

        final PreparedStatement statementVillainId = connection.prepareStatement(GET_VILLAIN_ID_QUERY);
        statementVillainId.setString(1, villainName);
        final ResultSet resultGetVillainName = statementVillainId.executeQuery();
        resultGetVillainName.next();
        int villainId = 0;
        if(resultGetVillainName.next()) {
            villainId = resultGetVillainName.getInt(Constants.COLUMN_LABEL_ID);
        }else{
            final PreparedStatement statementAddVillain = connection.prepareStatement(ADD_VILLAIN_QUERY);
            statementAddVillain.setString(1, villainName);
            statementAddVillain.executeUpdate();

            final PreparedStatement statementGetAddedVillainId = connection.prepareStatement(GET_ADDED_VILLAIN_ID_QUERY);
            final ResultSet resultGetAddedVillainId = statementGetAddedVillainId.executeQuery();
            resultGetAddedVillainId.next();
            villainId = resultGetAddedVillainId.getInt(Constants.COLUMN_LABEL_ID);
            System.out.printf("Villain %s was added to the database.%n", villainName);
        }

            final PreparedStatement statementAddMinion = connection.prepareStatement(ADD_MINION_QUERY);
            statementAddMinion.setString(1, minionName);
            statementAddMinion.setInt(2, minionAge);
            statementAddMinion.setInt(3, townId);
            statementAddMinion.executeUpdate();

            final PreparedStatement statementGetAddedMinionId = connection.prepareStatement(GET_ADDED_MINION_ID_QUERY);
            final ResultSet resultGetAddedMinionId = statementGetAddedMinionId.executeQuery();
            resultGetAddedMinionId.next();
            int minionId = resultGetAddedMinionId.getInt(Constants.COLUMN_LABEL_ID);

            final PreparedStatement statementAddMinionVillain = connection.prepareStatement(ADD_MINION_VILLAIN_QUERY);
            statementAddMinionVillain.setInt(1, minionId);
            statementAddMinionVillain.setInt(2, villainId);
            statementAddMinionVillain.executeUpdate();

            System.out.printf("Successfully added %s to be minion of %s.", minionName, villainName);

            connection.close();
        }

    }

