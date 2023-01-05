// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:inri_admin/models/driver.dart';


class DriverCard extends StatelessWidget {

  final Driver driver;

  const DriverCard({
  Key? key, required this.driver
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 40),
        width: double.infinity,        
        height: 250,
        decoration: _cardBorders(),
        child: Stack(
          
          children: [
            _DriverDetails(
              id: driver.id,
              apellidoDriver: driver.apellido,              
              nombreDriver: driver.nombre,              
              vehiculoDriver: driver.vehiculo,
              modeloDriver: driver.modelo,
              patenteDriver: driver.patente,
              online: driver.online,
              orderDriver: driver.order,
              viajesDriver: driver.viajes,
              idAddress: driver.idAddress,
              time: driver.time
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
        offset: Offset(0,8),
        blurRadius: 10
      )
    ]
  );

}

class _DriverDetails extends StatelessWidget {

    final String  id;    
    final String  nombreDriver;
    final String  apellidoDriver; 
    final String  vehiculoDriver;
    final String  modeloDriver;
    final String  patenteDriver;
    final bool online;
    final String orderDriver;
    final int viajesDriver;
    final List<dynamic>? idAddress;
    final DateTime? time; 
  
  


  const _DriverDetails({
    
  required this.id,
  required this.nombreDriver,
  required this.apellidoDriver,
  required this.vehiculoDriver,
  required this.modeloDriver,
  required this.patenteDriver,
  required this.online,
  required this.orderDriver,
  required this.viajesDriver,
  this.idAddress,
  required this.time
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
              apellidoDriver.toUpperCase(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,              
             overflow: TextOverflow.ellipsis,
            ),
            Text(
              nombreDriver.toUpperCase(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              vehiculoDriver.toUpperCase(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              modeloDriver.toUpperCase(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              patenteDriver.toUpperCase(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              online.toString().toUpperCase(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              orderDriver.toUpperCase(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              viajesDriver.toString(),
              style: const TextStyle( fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              idAddress!.toString(),
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