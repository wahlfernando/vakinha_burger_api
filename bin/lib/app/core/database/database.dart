import 'package:dotenv/dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Database {
  Future<MySqlConnection> openConnection() async {
    print(env['databaseHost']);
    final conn = await MySqlConnection.connect(
      ConnectionSettings(
        host: env['DATABASE_HOST'] ?? env['databaseHost'] ?? '',
        port: int.tryParse(env['DATABASE_PORT'] ?? env['databasePort'] ?? '') ??
            3306,
        user: env['DATABASE_USER'] ?? env['databaseUser'],
        password: env['DATABASE_PASSWORD'] ?? env['databasePassword'],
        db: env['DATABASE_NAME'] ?? env['databaseName'],
      ),
    );
    await Future.delayed(Duration(seconds: 1));
    return conn;
  }
}

// class Database {
//   Future<MySqlConnection> openConnection() async {
//     print(env['databeseHost']);
//     final conn = await MySqlConnection.connect(
//       ConnectionSettings(
//         host: env['databeseHost'] ?? '',
//         port: int.tryParse(env['databasePort'] ?? '') ?? 3306,
//         user: env['databaseUser'],
//         password: env['databasePassword'],
//         db: env['databaseName'],
//       ),
//     );
//     await Future.delayed(Duration(seconds: 1));
//     return conn;
//   }
// }
