
import 'package:flutter/material.dart';


import 'package:inri_admin/routes/routes.dart';

import 'package:inri_admin/service/addresses_service.dart';

import 'package:inri_admin/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  
  
const HomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    
    
    final addressService = Provider.of<AddressService>(context);       
    
    if( addressService.isLoading) return const LoadingPage(); 
     
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(235, 244, 245, 248),
      appBar: AppBar(
        title: const Center(child: Text('Nuevos Pedidos')),
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.indigo,
        splashColor: Colors.purple,
        tooltip: 'Pedido',
        child: const Icon(Icons.arrow_forward_ios),
        onPressed:      
         () async {   
          Navigator.pushReplacementNamed(context, 'driver');
        }

        ),
         
        
        
      body:ListView(
        children: [
         
          ListView.builder(
            itemCount: addressService.addresses.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () async {
          addressService.selectedAddress = addressService.addresses[index].copy();
                 
          Navigator.pushNamed(context, 'address');          
            
          },

            child: AddressCard(
                address: addressService.addresses[index]
          ), 
          )
         ),
        ]        
      ),
      
    );
     
  }   
  
}