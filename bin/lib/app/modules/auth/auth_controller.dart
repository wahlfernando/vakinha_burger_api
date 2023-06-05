import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/exceptions/email_already_regiter.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

part 'auth_controller.g.dart';

class AuthController {
  final _userRepository = UserRepository();

  @Route.post('/register')
  Future<Response> find(Request request) async {
    try {
      final userRq = User.fromJson(await request.readAsString());
      await _userRepository.save(userRq);

      return Response(
        200,
        headers: {
          'content-type': 'application/json',
        },
      );
    } on EmailAlreadyRegiter catch (e, s) {
      log(
        e.toString(),
      );
      log(
        s.toString(),
      );
      return Response(
        400,
        body: jsonEncode(
          {'error': 'E-mail ja utilizado por outro usuário'},
        ),
        headers: {'content-type': 'application/json'},
      );
    } catch (e, s) {
      log(
        e.toString(),
      );
      log(
        s.toString(),
      );
      return Response.internalServerError();
    }
  }

  Router get router => _$AuthControllerRouter(this);
}
