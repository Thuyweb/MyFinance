import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class PhoneOtpService {
  PhoneOtpService._();
  static final PhoneOtpService instance = PhoneOtpService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  int? _resendToken;

  // =====================================================
  // GỬI OTP SMS THẬT
  // =====================================================
  Future<void> sendOtp({
    required String phoneNumber, // +849xxxxxxxx
    required void Function(String verificationId) onCodeSent,
    required void Function(String error) onError,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),

        // Android auto verify (hiếm nhưng hợp lệ)
        verificationCompleted: (PhoneAuthCredential credential) async {
          debugPrint('📱 OTP auto verified');
          await _auth.signInWithCredential(credential);
          await _auth.signOut();
        },

        verificationFailed: (FirebaseAuthException e) {
          debugPrint('❌ OTP send failed: ${e.message}');
          onError(e.message ?? 'OTP verification failed');
        },

        codeSent: (verificationId, resendToken) {
          debugPrint('📨 OTP sent');
          _resendToken = resendToken;
          onCodeSent(verificationId);
        },

        codeAutoRetrievalTimeout: (verificationId) {
          debugPrint('⌛ OTP timeout');
        },

        forceResendingToken: _resendToken,
      );
    } catch (e) {
      onError(e.toString());
    }
  }

  // =====================================================
  // VERIFY OTP USER NHẬP
  // =====================================================
  Future<bool> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);

      // 👉 Không login user → sign out ngay
      await _auth.signOut();

      debugPrint('✅ OTP verified successfully');
      return true;
    } catch (e) {
      debugPrint('❌ OTP verify failed: $e');
      return false;
    }
  }
}
