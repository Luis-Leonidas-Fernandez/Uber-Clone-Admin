import 'package:flutter/material.dart';
import 'package:inri_admin/models/driver.dart'; 

class DriverFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formDriverKey = GlobalKey<FormState>();

  Driver driver;

  DriverFormProvider( this.driver ); 


  bool isValidFormDriver() {
    
    debugPrint( driver.id );
    /* debugPrint( address.estado.toString() );
    debugPrint( address.ubicacion.toString() );
    debugPrint( address.createdAt.toIso8601String() );
    debugPrint( address.updatedAt.toIso8601String() );     */

    return formDriverKey.currentState?.validate() ?? false;
  }

}