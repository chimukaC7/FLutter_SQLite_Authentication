import 'dart:convert';

User usersFromMap(String str) => User.fromMap(json.decode(str));

String usersToMap(User data) => json.encode(data.toMap());

class User {
  final int? usrId;
  final String? fullName;
  final String? email;
  final String usrName;
  final String password;

  User({
    this.usrId,
    this.fullName,
    this.email,
    required this.usrName,
    required this.password,
  });

  //These json value must be same as your column name in database that we have already defined
  factory User.fromMap(Map<String, dynamic> json) => User(
        usrId: json["usrId"],
        fullName: json["fullName"],
        email: json["email"],
        usrName: json["usrName"],
        password: json["usrPassword"],
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "fullName": fullName,
        "email": email,
        "usrName": usrName,
        "usrPassword": password,
      };
}
