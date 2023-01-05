// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:inri_admin/models/new_address.dart';

class AddressCard extends StatelessWidget {

  final AddressElement address;

  const AddressCard({
  Key? key, required this.address
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 50, bottom: 50),
        width: double.infinity,
        height: 180,
        decoration: _cardBorders(),
        child: Stack(
          
          children: [
            _AddressDetails(
              idCliente: address.miId,
              idConductor: address.idDriver?? '',
              estado: address.estado,
              direccion: address.ubicacion,
              creado: address.createdAt,
              modificado: address.updatedAt,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,10),
        blurRadius: 15
      )
    ]
  );

}

class _AddressDetails extends StatelessWidget {

  final String idCliente;
  final String idConductor;
  final bool estado;
  final List<double> direccion;
  final DateTime creado;
  final DateTime modificado;



  const _AddressDetails({
  required this.idCliente,
  required this.idConductor,
  required this.estado,
  required this.direccion,
  required this.creado,
  required this.modificado
  }); 

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        color: Colors.indigo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              idCliente,
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Text(
              estado.toString(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Text(
              direccion.toString(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Text(
              creado.toIso8601String(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Text(
              modificado.toIso8601String(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),     
      ),
    );
  }
}