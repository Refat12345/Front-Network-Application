class LogModel {
  List<Logs>? logs;

  LogModel({this.logs});

  LogModel.fromJson(Map<String, dynamic> json) {
    if (json['logs'] != null) {
      logs = <Logs>[];
      json['logs'].forEach((v) {
        logs!.add(new Logs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.logs != null) {
      data['logs'] = this.logs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Logs {
  int? logId;
  int? userId;
  String? operation;
  int? affectedId;
  String? result;

  Logs({this.logId, this.userId, this.operation, this.affectedId, this.result});

  Logs.fromJson(Map<String, dynamic> json) {
    logId = json['logId'];
    userId = json['userId'];
    operation = json['operation'];
    affectedId = json['affectedId'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logId'] = this.logId;
    data['userId'] = this.userId;
    data['operation'] = this.operation;
    data['affectedId'] = this.affectedId;
    data['result'] = this.result;
    return data;
  }
}