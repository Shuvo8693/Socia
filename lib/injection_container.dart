import 'package:get_it/get_it.dart';
import 'package:socia/features/authentication/data/service/auth_login_service.dart';
import 'package:socia/features/authentication/data/service/auth_register_service.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_bloc.dart';

final di = GetIt.instance;

Future<void> initDi() async {
  /// Authentication
  di.registerFactory<AuthLogInService>(() => AuthLogInService());
  di.registerFactory<AuthRegisterService>(() => AuthRegisterService());
  di.registerFactory<AuthBloc>(() => AuthBloc(
      authRegisterService: di<AuthRegisterService>(),
      authLogInService: di<AuthLogInService>()));
}
