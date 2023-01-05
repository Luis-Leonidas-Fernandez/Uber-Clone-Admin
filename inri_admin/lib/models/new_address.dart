// To parse required this JSON data, do
//
//     final address = addressFromMap(jsonString);

import 'dart:convert';

class Address {
    Address({
        required this.addresses,
    });

    List<AddressElement> addresses;

    factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Address.fromMap(Map<String, dynamic> json) => Address(
        addresses: List<AddressElement>.from(json["addresses"].map((x) => AddressElement.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "addresses": List<dynamic>.from(addresses.map((x) => x.toMap())),
    };
}

class AddressElement {
    AddressElement({
        required this.miId,
        required this.estado,
        required this.ubicacion,
        required this.createdAt,
        required this.updatedAt,
        this.idDriver,        
    });

    String miId;
    bool estado;
    List<double> ubicacion;
    DateTime createdAt;
    DateTime updatedAt;
    String? idDriver;   
    

    factory AddressElement.fromJson(String str) => AddressElement.fromMap(json.decode(str));

    dynamic toJson() => json.encode(toMap());

    factory AddressElement.fromMap(Map<String, dynamic> json) => AddressElement(
        miId: json["miId"],
        estado: json["estado"],
        ubicacion: List<double>.from(json["ubicacion"].map((x) => x.toDouble())),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        idDriver: json["idDriver"] ?? '',        
    );

    Map<String, dynamic> toMap() => {
        "miId": miId,
        "estado": estado,
        "ubicacion": List<dynamic>.from(ubicacion.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "idDriver": idDriver ?? '',
        
    };

    AddressElement copy() =>  AddressElement(
      miId: miId,
      estado: estado,
      ubicacion: ubicacion,
      createdAt: createdAt,
      updatedAt: updatedAt,
      idDriver: idDriver,
    );

  indexWhere(bool Function(dynamic element) param0) {}
}
