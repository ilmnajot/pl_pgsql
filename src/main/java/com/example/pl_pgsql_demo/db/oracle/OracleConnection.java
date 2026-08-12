package com.example.pl_pgsql_demo.db.oracle;


import java.sql.DriverManager;
import java.sql.SQLException;

public class OracleConnection {
        static void main() {
            String host = "jdbc:oracle:thin:@(description=(address=(protocol=tcps)(port=2484)(host=db.freesql.com))(connect_data=(service_name=26ai_un3c1)))";
            String username = "ILMNAJOT2021_SCHEMA_4Z24T";
            String password = "9x5TIX6BLB!SUFZ3IR6CJUXHPSWHK1";
            try {
                DriverManager.getConnection(host, username, password);
                System.out.println("Connected to Oracle database");
            } catch (SQLException e) {
                System.out.println("Failed to connect to Oracle database");
                e.printStackTrace();
            }
        }
}
