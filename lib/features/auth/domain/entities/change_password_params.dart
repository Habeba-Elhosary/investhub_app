class ChangePasswordParams {
  final String oldPassword;
  final String password;
  final String confirmPassword;

  const ChangePasswordParams({
    required this.oldPassword,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    "current_password": oldPassword,
    "new_password": password,
    "new_password_confirmation": confirmPassword,
  };
}
