class Login {
  bool error;
  String msg;
  Data data;
  Login({this.error, this.msg, this.data});
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        error: json['error'],
        msg: json['msg'],
        data: Data.fromJson(json['data']));
  }
}

class Data {
  String level;
  String token;

  Data({this.level, this.token});
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      level: json["level"],
      token: json["accessToken"],
    );
  }
}
