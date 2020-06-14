class Info {
  bool error;
  String msg;
  DataInfo data;
  Info({this.error, this.msg, this.data});
  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      error: json['error'],
      msg: json['msg'],
      data: DataInfo.fromJson(json['data']),
    );
  }
}

class DataInfo {
  String username;
  String name;
  String level;
  List<TokenList> tokenList;
  DataInfo({this.username, this.name, this.level, this.tokenList});
  factory DataInfo.fromJson(Map<String, dynamic> json) {
    return DataInfo(
      username: json["username"],
      name: json["name"],
      level: json["level"],
      tokenList: List<TokenList>.from(json["token"].map((tokenlist) {
        return TokenList.fromJson(tokenlist);
      })),
    );
  }
}

class TokenList {
  String token;
  String createAt;
  TokenList({this.token, this.createAt});
  factory TokenList.fromJson(Map<String, dynamic> json) {
    return TokenList(token: json["token"], createAt: json["create_at"]);
  }
}
