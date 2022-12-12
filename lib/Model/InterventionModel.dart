import 'dart:convert';
import 'package:employee_management/Model/EmployeeModel.dart';
import 'package:employee_management/Model/MachineModel.dart';
import 'package:employee_management/Model/ClientModel.dart';
import 'package:employee_management/Model/PieceDeReChargeModel.dart';

InterventionModel employeeModelJson(String str) =>
    InterventionModel.fromJson(json.decode(str));

String InterventionModelToJson(InterventionModel data) =>
    json.encode(data.toJson());

class InterventionModel {
  int? id;
  String? date;
  int? duree;
  int? numeroIntervention;
  int? nbDevice;
  String? natureIntervention;
  String? descriptionIntervention;
  String? observation;
  ClientModel? client;
  List<EmployeeModel?>? employees;
  List<MachineModel?>? machines;
  List<PieceDeReChargeModel?>? pieces;

  InterventionModel(
      {this.id,
      this.date,
      this.duree,
      this.numeroIntervention,
      this.nbDevice,
      this.natureIntervention,
      this.descriptionIntervention,
      this.observation,
      this.client,
      this.employees,
      this.machines,
      this.pieces});

  factory InterventionModel.fromJson(Map<String, dynamic> json) =>
      InterventionModel(
        id: json["id"],
        date: json["date"],
        duree: json["duree"],
        numeroIntervention: json["numeroIntervention"],
        nbDevice: json["nbDevice"],
        natureIntervention: json["natureIntervention"],
        descriptionIntervention: json["descriptionIntervention"],
        observation: json["observation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "duree": duree,
        "numeroIntervention": numeroIntervention,
        "nbDevice": nbDevice,
        "natureIntervention": natureIntervention,
        "descriptionIntervention": descriptionIntervention,
        "observation": observation,
      };

  String? get dte => date;
  int? get dur => duree;
  int? get numIntervention => numeroIntervention;
  int? get nbDev => nbDevice;
  String? get natureintervention => natureIntervention;
  String? get descriptIntervention => descriptionIntervention;
  String? get observ => observation;
}
