import 'package:flutter/material.dart'; 
import 'package:inri_admin/models/new_address.dart';

class AddressFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddressElement address;

  AddressFormProvider( this.address ); 


  bool isValidForm() {
    
    debugPrint( address.miId );
    /* debugPrint( address.estado.toString() );
    debugPrint( address.ubicacion.toString() );
    debugPrint( address.createdAt.toIso8601String() );
    debugPrint( address.updatedAt.toIso8601String() );     */

    return formKey.currentState?.validate() ?? false;
  }

}