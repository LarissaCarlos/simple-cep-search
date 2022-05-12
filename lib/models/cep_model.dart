import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class CepModel {
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
  String? ibge;
  String? gia;
  String? ddd;
  String? siafi;
  CepModel({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
      'ibge': ibge,
      'gia': gia,
      'ddd': ddd,
      'siafi': siafi,
    };
  }

  factory CepModel.fromMap(Map<String, dynamic> map) {
    return CepModel(
        cep: map['cep'] ?? "",
        logradouro: map['logradouro'] ?? "",
        complemento: map['complemento'] ?? "",
        localidade: map['localidade'] ?? "",
        uf: map['uf'] ?? "",
        ibge: map['ibge'] ?? "",
        gia: map['gia'] ?? "",
        ddd: map['ddd'] ?? "",
        siafi: map['siafi'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory CepModel.fromJson(String source) =>
      CepModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
