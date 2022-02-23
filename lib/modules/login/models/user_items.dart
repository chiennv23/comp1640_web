class UserItem {
  String userName, password;

  UserItem({this.userName, this.password});

  factory UserItem.fromJson(Map<String, dynamic> json) {
    return UserItem(userName: json['UserName'], password: json['PassWord']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserName'] = userName;
    data['PassWord'] = password;
    return data;
  }
}
