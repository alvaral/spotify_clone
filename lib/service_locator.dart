import 'package:get_it/get_it.dart';
import 'package:spotify_clone_flutter/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_clone_flutter/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_clone_flutter/domain/repository/auth/auth_repository.dart';
import 'package:spotify_clone_flutter/domain/usecases/auth/sign_in_use_case.dart';
import 'package:spotify_clone_flutter/domain/usecases/auth/signup_use_case.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Authentication
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase(),
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase(),
  );
}
