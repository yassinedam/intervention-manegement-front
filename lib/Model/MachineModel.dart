import 'dart:convert';

MachineModel employeeModelJson(String str) =>
    MachineModel.fromJson(json.decode(str));

String MachineModelToJson(MachineModel data) => json.encode(data.toJson());

class MachineModel {
  String? code;
  String? designation;
  int? qteDisp;
  int? qteStock;
  int? qteEnInstance;

  MachineModel({
    this.code,
    this.designation,
    this.qteDisp,
    this.qteStock,
    this.qteEnInstance,
  });

  factory MachineModel.fromJson(Map<String, dynamic> json) => MachineModel(
        code: json["code"],
        designation: json["designation"],
        qteDisp: json["qteDisp"],
        qteStock: json["qteStock"],
        qteEnInstance: json["qteEnInstance"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "designation": designation,
        'qteDisp': qteDisp,
        "qteStock": qteStock,
        "qteEnInstance": qteEnInstance,
      };

  String? get cde => code;
  String? get designat => designation;
  int? get qtedisp => qteDisp;
  int? get qtestock => qteStock;
  int? get qteeninstance => qteEnInstance;
}
