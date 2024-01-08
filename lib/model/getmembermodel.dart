class GetMemberModel {
  List<MembersDTOS>? membersDTOS;

  GetMemberModel({this.membersDTOS});

  GetMemberModel.fromJson(Map<String, dynamic> json) {
    if (json['membersDTOS'] != null) {
      membersDTOS = <MembersDTOS>[];
      json['membersDTOS'].forEach((v) {
        membersDTOS!.add(new MembersDTOS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.membersDTOS != null) {
      data['membersDTOS'] = this.membersDTOS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MembersDTOS {
  int? userId;
  String? userName;

  MembersDTOS({this.userId, this.userName});

  MembersDTOS.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    return data;
  }
}