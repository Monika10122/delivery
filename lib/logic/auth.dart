import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? verificationId;
  bool? verificationSent;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signUpWithPhoneNumberAndPassword({
    required String phoneNumber,
    required String password,
    bool? verificationSent,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
        },
        verificationFailed: (FirebaseAuthException e) {
          // Обробка помилок під час верифікації номеру телефону
          throw e;
        },
        codeSent: (String verificationId, int? resendToken) {
          // Збереження `verificationId` в класі
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
        },
      );
      //реєструємо користувача
      this.verificationSent = verificationSent;
    } on FirebaseAuthException catch (e) {
      // Обробка помилок реєстрації за допомогою номеру телефону та паролю
      throw e;
    }
  }

  Future<void> signInWithPhoneNumberAndPassword({
    required String phoneNumber,
    required String smsCode,
  }) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId ?? '', //код верифікації
        smsCode: smsCode, // SMS-код, який користувач вводить
      );

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // Обробка помилок входу за допомогою SMS-підтвердження
      throw e;
    }
  }
}
