import 'package:flutter/material.dart';
import 'package:inri_admin/providers/driver_form_provider.dart';
import 'package:inri_admin/service/addresses_service.dart';


import 'package:inri_admin/service/drivers_service.dart';
import 'package:provider/provider.dart';


class UpdateDriverPage extends StatelessWidget {
  const UpdateDriverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final driverService = Provider.of<DriverService>(context);   
    final addressService = Provider.of<AddressService>(context);

    return ChangeNotifierProvider(
      create: (_) => DriverFormProvider(driverService.selectedDriver),
      child: _DriverPageBody(driverService: driverService, addressService: addressService ),
    );
    
  }
}

class _DriverPageBody extends StatelessWidget {
  const _DriverPageBody({
    Key? key,
    required this.driverService,
    required this.addressService,    
  }) : super(key: key);

  final DriverService driverService;  
  final AddressService addressService;
  @override
  Widget build(BuildContext context) {

    final driverForm = Provider.of<DriverFormProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(235, 244, 245, 248),
      appBar: AppBar(
        title: const Center(child: Text('Eliminar Conductor asignado')),        
        
        ),
      body:  SingleChildScrollView(
        child: Column(

          children: [
            const SizedBox( height: 298),
            _DriverForm(),
            
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        splashColor: Colors.purple,
        tooltip: 'Pedido',
        onPressed: driverService.isSaving
        ? null 
        : () async {
          if (!driverForm.isValidFormDriver()) return;
          await driverService.updateDriver(driverForm.driver);
          await addressService.getAddresses();
          
          
        },
        child: const Icon(Icons.auto_delete)

        ),
      );
  }
}

class _DriverForm extends StatelessWidget {

@override
Widget build(BuildContext context){
  final driverForm = Provider.of<DriverFormProvider>(context);
  final driver     = driverForm.driver;


  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      margin: const EdgeInsets.only( top: 60, bottom: 70 ),
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Form(
        key:  driverForm.formDriverKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height:  10),
            TextFormField(
              textAlign: TextAlign.center,
              initialValue: driver.id.toString(),
              style: const TextStyle(color: Colors.white),            
            ),          
            
          ],
        ),
        )
    ),
  );
}

BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.indigo,
    borderRadius:const  BorderRadius.only( bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0,5),
        blurRadius: 5
      )
    ]
  );

}