class Regis {
  bool error;
  String msg;
  Regis({this.error, this.msg});
  factory Regis.fromJson(Map<String, dynamic> json) {
    return Regis(
        error: json['error'],
        msg: json['msg']
    );
  }
}