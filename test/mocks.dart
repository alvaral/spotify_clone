// ignore_for_file: subtype_of_sealed_class

import 'package:firebase_core/firebase_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Mock de FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Mock de FirebaseFirestore
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// Mock de UserCredential
class MockUserCredential extends Mock implements UserCredential {}

// Mock de DocumentSnapshot con Map<String, dynamic>
class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

// Mock para Firebase app (Firebase Core)
class MockFirebase extends Mock implements Firebase {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockUser extends Mock implements User {}
