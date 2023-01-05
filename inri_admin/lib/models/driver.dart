// To parse this JSON data, do
//
//     final drivers = driversFromMap(jsonString);

import 'dart:convert';

class Drivers {
    Drivers({
        required this.drivers,
    });

    List<Driver> drivers;

    factory Drivers.fromJson(String str) => Drivers.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Drivers.fromMap(Map<String, dynamic> json) => Drivers(
        drivers: List<Driver>.from(json["drivers"].map((x) => Driver.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "drivers": List<dynamic>.from(drivers.map((x) => x.toMap())),
    };
}

class Driver {
    Driver({
        required this.id,
        this.email,
        required this.nombre,
        required this.apellido,
        this.nacimiento,
        this.domicilio,
        required this.vehiculo,
        required this.modelo,
        required this.patente,
        this.licencia,
        required this.online,
        required this.role,
        required this.order,
        required this.viajes,
        this.idAddress,
        this.time,
    });

    String id;
    String? email;
    String nombre;
    String apellido;
    String? nacimiento;
    String? domicilio;
    String vehiculo;
    String modelo;
    String patente;
    String? licencia;
    bool online;
    String role;
    String order;
    int viajes;
    List<dynamic>? idAddress;
    DateTime? time;

    factory Driver.fromJson(String str) => Driver.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Driver.fromMap(Map<String, dynamic> json) => Driver(
        id: json["_id"],
        email: json["email"]?? '',
        nombre: json["nombre"],
        apellido: json["apellido"],
        nacimiento: json["nacimiento"]?? '',
        domicilio: json["domicilio"]?? '',
        vehiculo: json["vehiculo"],
        modelo: json["modelo"],
        patente: json["patente"],
        licencia: json["licencia"]?? '',
        online: json["online"],
        role: json["role"],
        order: json["order"],
        viajes: json["viajes"],
        idAddress: List<dynamic>.from(json["idAddress"]!.map((x) => x)),
        time: DateTime.parse(json["time"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "email": email ?? '',
        "nombre": nombre,
        "apellido": apellido,
        "nacimiento": nacimiento ?? '',
        "domicilio": domicilio ?? '',
        "vehiculo": vehiculo,
        "modelo": modelo,
        "patente": patente,
        "licencia": licencia ?? '',
        "online": online,
        "role": role,
        "order": order,
        "viajes": viajes,
        "idAddress": List<dynamic>.from(idAddress!.map((x) => x)),
        "time": time!.toIso8601String(),
    };

    Driver copy() =>  Driver(
        id: id,
        email: email,
        nombre: nombre,
        apellido: apellido,
        nacimiento: nacimiento,
        domicilio: domicilio,
        vehiculo: vehiculo,
        modelo: modelo,
        patente: patente,
        licencia: licencia,
        online: online,
        role: role,
        order: order,
        viajes: viajes,
        idAddress: idAddress,
        time: time,
    );
}
