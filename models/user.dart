class User {
  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.pass,
      this.url = ""});
  final String name, email, pass, url;
  final int id;

  String get getName {
    return this.name;
  }

  String get getEmail {
    return this.email;
  }

  String get getPassword {
    return this.pass;
  }

  Map<String, dynamic> get toJson {
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "pass": this.pass,
      "url": this.url
    };
  }
}

User toUser(List<dynamic> item) {
  // print(item);
  return User(
      id: item[0] as int,
      name: item[1].toString(),
      email: item[2].toString(),
      pass: item[3].toString(),
      url: item[4].toString());
}
