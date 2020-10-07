class User {
  String username;
  String name;
  String password;
  String email;

  User({this.username, this.name, this.password, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'] as String,
        name: json['name'] as String,
        password: json['password'] as String,
        email: json['email'] as String);
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "username": username,
      "name": name,
      "password": password,
      "email": email
    };
    return map;
  }

  @override
  String toString() => "$username";
}
