class Addnewgroup {
  String? groupName;
  int? groupId;
  Admin? admin;

  Addnewgroup({this.groupName, this.groupId, this.admin});

  Addnewgroup.fromJson(Map<String, dynamic> json) {
    groupName = json['group_name'];
    groupId = json['group_id'];
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_name'] = this.groupName;
    data['group_id'] = this.groupId;
    if (this.admin != null) {
      data['admin'] = this.admin!.toJson();
    }
    return data;
  }
}

class Admin {
  int? userId;
  String? userName;
  List<String>? userGroups;
  List<String>? groups;


  Admin(
      {this.userId,
        this.userName,
        this.userGroups,
        this.groups,

      });

  Admin.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userGroups = json['user_groups'].cast<String>();
    groups = json['groups'].cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_groups'] = this.userGroups;
    data['groups'] = this.groups;

    return data;
  }
}