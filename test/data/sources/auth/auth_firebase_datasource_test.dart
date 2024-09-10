import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:spotify_clone_flutter/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_flutter/data/models/auth/sign_in_user_req.dart';
import 'package:spotify_clone_flutter/data/sources/auth/auth_firebase_datasource.dart';

import '../../../mocks.dart';
import '../../../setup.dart';

void main() {
  late AuthFirebaseDatasourceImpl authDatasource;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockCollectionReference mockCollectionReference;
  late MockDocumentReference mockDocumentReference;
  late MockUserCredential mockUserCredential;
  late MockDocumentSnapshot mockDocumentSnapshot;
  late MockUser mockUser;

  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  setUp(() async {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();

    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockUserCredential = MockUserCredential();
    mockDocumentSnapshot = MockDocumentSnapshot();

    mockUser = MockUser();

    // Configurar FirebaseFirestore.collection para devolver mockCollectionReference
    when(() => mockFirebaseFirestore.collection(any()))
        .thenReturn(mockCollectionReference);

    // Configurar CollectionReference.doc para devolver mockDocumentReference
    when(() => mockCollectionReference.doc(any()))
        .thenReturn(mockDocumentReference);

    // Configurar DocumentReference.set para hacer algo (por ejemplo, devolver Future<void>)
    when(() => mockDocumentReference.set(any()))
        .thenAnswer((_) async => Future.value());

    // Configurar DocumentReference.get para devolver mockDocumentSnapshot
    when(() => mockDocumentReference.get())
        .thenAnswer((_) async => mockDocumentSnapshot);

    // Configurar DocumentSnapshot.data para devolver un mapa con datos
    when(() => mockDocumentSnapshot.data()).thenReturn({
      'name': 'Test User',
      'email': 'test@example.com',
    });

    // Configurar mockUser para devolver un UID y un email válidos
    when(() => mockUser.uid).thenReturn('12345');
    when(() => mockUser.email).thenReturn('test@example.com');

    // Configurar mockUserCredential para devolver mockUser
    when(() => mockUserCredential.user).thenReturn(mockUser);

    authDatasource = AuthFirebaseDatasourceImpl(
      firebaseAuth: mockFirebaseAuth,
      firebaseFirestore: mockFirebaseFirestore,
    );

    // Registrar los mocks
    registerFallbackValue(Uri());
  });

  group('AuthFirebaseDatasourceImpl', () {
    group('signUp', () {
      final createUserReq = CreateUserReq(
        email: 'test@example.com',
        password: 'password123',
        fullName: 'Test User',
      );

      test('should return Right when signUp is successful', () async {
        // Arrange
        when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => mockUserCredential);

        // Act
        final result = await authDatasource.signUp(createUserReq);

        // Assert
        expect(result, equals(const Right('Signup was Succesfull')));

        // Verificar las llamadas a los métodos mockeados
        verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: createUserReq.email,
              password: createUserReq.password,
            )).called(1);

        verify(() => mockFirebaseFirestore.collection('Users')).called(1);
        verify(() => mockCollectionReference.doc('12345')).called(1);
        verify(() => mockDocumentReference.set({
              'name': createUserReq.fullName,
              'email': createUserReq.email,
            })).called(1);
      });

      test(
          'should return Left with message when signUp fails with weak-password',
          () async {
        when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(FirebaseAuthException(code: 'weak-password'));

        final result = await authDatasource.signUp(createUserReq);

        expect(result, equals(const Left('The password provided is too weak')));
      });

      test(
          'should return Left with message when signUp fails with email-already-in-use',
          () async {
        when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

        final result = await authDatasource.signUp(createUserReq);

        expect(result,
            equals(const Left('An account already exists with that email.')));
      });
    });

    group('signIn', () {
      final signInUserReq = SignInUserReq(
        email: 'test@example.com',
        password: 'password123',
      );

      test('should return Right when signIn is successful', () async {
        when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => mockUserCredential);

        final result = await authDatasource.signIn(signInUserReq);

        expect(result, equals(const Right('SignIn was Succesfull')));
      });

      test(
          'should return Left with message when signIn fails with invalid-email',
          () async {
        when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(FirebaseAuthException(code: 'invalid-email'));

        final result = await authDatasource.signIn(signInUserReq);

        expect(result, equals(Left('The email provided is invalid.')));
      });

      test(
          'should return Left with message when signIn fails with invalid-credential',
          () async {
        when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(FirebaseAuthException(code: 'invalid-credential'));

        final result = await authDatasource.signIn(signInUserReq);

        expect(
            result, equals(const Left('The credentials provided are wrong.')));
      });
    });

    group('getUser', () {
      test('should return Right with UserEntity when getUser is successful',
          () async {
        // Arrange
        when(() => mockFirebaseFirestore.collection('Users'))
            .thenReturn(mockCollectionReference);
        when(() => mockCollectionReference.doc('12345'))
            .thenReturn(mockDocumentReference);

        // Act
        final result = await authDatasource.getUser();

        // Assert
        expect(result.isRight(), true);

        // Verificar que se llamen los métodos correctos
        verify(() => mockFirebaseFirestore.collection('Users')).called(1);
        verify(() => mockDocumentReference.get()).called(1);
        verify(() => mockDocumentSnapshot.data()).called(1);
      });
      test('should return Left with error message when getUser fails',
          () async {
        when(() => mockFirebaseFirestore.collection('Users').doc(any()).get())
            .thenThrow(Exception());

        final result = await authDatasource.getUser();

        expect(result, equals(const Left('An error occurred')));
      });
      test('should return Left with error message when getUser fails',
          () async {
        when(() => mockFirebaseFirestore.collection('Users').doc(any()).get())
            .thenThrow(Exception());

        final result = await authDatasource.getUser();

        expect(result, equals(const Left('An error occurred')));
      });
    });
  });
}
