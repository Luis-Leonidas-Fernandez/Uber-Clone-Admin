import 'package:flutter/material.dart';
import 'package:inri_admin/providers/address_form_provider.dart';
import 'package:inri_admin/service/addresses_service.dart';
import 'package:provider/provider.dart';


class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final addressService = Provider.of<AddressService>(context);   
    

    return ChangeNotifierProvider(
      create: (_) => AddressFormProvider(addressService.selectedAddress),
      child: _AddressPageBody(addressService: addressService ),
    );
    
  }
}

class _AddressPageBody extends StatelessWidget {
  const _AddressPageBody({
    Key? key,
    required this.addressService,    
  }) : super(key: key);

  final AddressService addressService;
  
  bool get mounted => true;  

  @override
  Widget build(BuildContext context) {

    final addressForm = Provider.of<AddressFormProvider>(context);

    return Scaffold(
       backgroundColor: const Color.fromARGB(235, 244, 245, 248),
      appBar: AppBar(
        title: const Center(child: Text('Asignar Conductor')),        
        
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async { 
              
              await addressService.getAddresses();
              if(!mounted) return;  
              Navigator.of(context).pop();
        },
              );
          } 
          ),
        
        
        ),
      
      
        
      body:  SingleChildScrollView(
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            
            const SizedBox(height: 300),
            _AddressForm(),
            
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        splashColor: Colors.purple,
        tooltip: 'Pedido',
        onPressed: addressService.isSaving
        ? null 
        : () async {
          if (!addressForm.isValidForm()) return;
          await addressService.updateAddress(addressForm.address);
          await addressService.getAddresses();
        },
        child: const Icon(Icons.car_rental_rounded)

        ),
      );
  }
}

class _AddressForm extends StatelessWidget {

@override
Widget build(BuildContext context){
  final addressForm = Provider.of<AddressFormProvider>(context);
  final address     = addressForm.address;


  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      margin: const EdgeInsets.only( top: 60, bottom: 70 ),
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Form(
        key:  addressForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height:  10),
            TextFormField(
              textAlign: TextAlign.center,
              initialValue: address.miId.toString(),
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