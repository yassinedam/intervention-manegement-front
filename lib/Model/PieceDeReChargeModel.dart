import 'dart:convert';

PieceDeReChargeModel employeeModelJson(String str) =>
    PieceDeReChargeModel.fromJson(json.decode(str));

String PieceDeReChargeModelToJson(PieceDeReChargeModel data) =>
    json.encode(data.toJson());

class PieceDeReChargeModel {
  String? code;
  String? designation;
  int? qte;
  double? prix;
  double? remise;
  double? tVA;
  double? totalHT;

  PieceDeReChargeModel(
      {this.code,
      this.designation,
      this.qte,
      this.prix,
      this.tVA,
      this.remise,
      this.totalHT});

  factory PieceDeReChargeModel.fromJson(Map<String, dynamic> json) =>
      PieceDeReChargeModel(
        code: json["code"],
        designation: json["designation"],
        qte: json["qte"],
        prix: json["prix"],
        tVA: json["tVA"],
        remise: json["remise"],
        totalHT: json["totalHT"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "designation": designation,
        'qte': qte,
        "prix": prix,
        "tVA": tVA,
        "remise": remise,
        "totalHT": totalHT,
      };

  String? get cde => code;
  String? get designat => designation;
  int? get qtE => qte;
  double? get prx => prix;
  double? get tva => tVA;
  double? get rms => remise;
  double? get total => totalHT;
}
