import 'dart:developer';

import 'package:mysql1/mysql1.dart';

import '../core/database/database.dart';
import '../core/helpers/cripty_helper.dart';
import '../entities/user.dart';
import '../core/exceptions/email_already_regiter.dart';

class UserRepository {
  Future<void> save(User user) async {
    MySqlConnection? conn;
    try {
      conn = await Database().openConnection();
      final isUserRegister = await conn
          .query('select * from usuario where email = ?', [user.email]);

      if (isUserRegister.isEmpty) {
        await conn.query(''' 
          insert into usuario
          values(?,?,?,?)
        ''', [
          null,
          user.name,
          user.email,
          CriptyHelper.generateSha256Hash(user.password),
        ]);
      } else {
        throw EmailAlreadyRegiter();
      }
    } on MySqlException catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw Exception();
    } finally {
      await conn?.close();
    }
  }
}
