class AppConstants {
  // API URLs
  static const String baseUrl = 'http://127.0.0.1:5000';

  // Endpoints
  static const String sendOtpEndpoint = '/send_otp';
  static const String validateOtpEndpoint = '/validate_otp';

  // Error messages
  static const String emailEmptyError = 'Please enter your email';
  static const String otpEmptyError = 'Please enter both email and OTP';
  static const String otpSentSuccess = 'OTP sent successfully';
  static const String otpValidationSuccess = 'OTP validated successfully';
  static const String networkError = 'Network error occurred, please try again later';

  // UI strings
  static const String emailLabel = 'Email';
  static const String otpLabel = 'OTP';
  static const String sendOtpButton = 'Send OTP';
  static const String validateOtpButton = 'Validate OTP';
  static const String otpStatusSuccess = 'OTP validated successfully!';
}
