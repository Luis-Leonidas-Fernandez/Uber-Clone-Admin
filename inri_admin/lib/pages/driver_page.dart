import 'package:flutter/material.dart';

import 'package:inri_admin/routes/routes.dart';
import 'package:inri_admin/service/drivers_service.dart';

import 'package:inri_admin/widgets/widgets.dart';
import 'package:provider/provider.dart';


class DriverPage extends StatelessWidget {
  
const DriverPage({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {


    final driverService = Provider.of<DriverService>(context);        
    
    if( driverService.load) return const LoadPage(); 

    
    return Scaffold(
      backgroundColor: const Color.fromARGB(235, 244, 245, 248),
      appBar: AppBar(
        title: const Center(child: Text('Conductores Conectados')),        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.blue,
        splashColor: Colors.purple,        
        child: const Icon(Icons.arrow_back_ios_new),
        onPressed:      
         () async {   
          Navigator.pushReplacementNamed(context, 'home');
        }

        ),
      body:ListView(
        children: [
         
          ListView.builder(
            itemCount: driverService.drivers.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () async {
          driverService.selectedDriver = driverService.drivers[index].copy();       
          Navigator.pushNamed(context, 'updatedriver');          
            
          },

            child: DriverCard(
                driver: driverService.drivers[index]
          ), 
          )
         ),
        ]        
      ),
    ); 
  }   
  
}