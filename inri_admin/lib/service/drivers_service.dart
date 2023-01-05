import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inri_admin/global/environment.dart';

import 'package:http/http.dart' as http;
import 'package:inri_admin/models/driver.dart';
import 'package:inri_admin/service/auth_service.dart';


class DriverService with ChangeNotifier{     
  
  late AuthService authService;
  final List<Driver> drivers = <Driver>[];
  
  
  late Driver selectedDriver;
  bool load = true;
  bool isSaving = false;

  DriverService (){
    getDrivers();
  }   

  Future <List<Driver>> getDrivers() async {

    load = true;
    notifyListeners();
       
  final token = await AuthService.getToken();    
  final Map<String, String> headers = {'Content-Type': 'application/json', 'Charset': 'utf-8', 'x-token': token.toString() };
  

  final resp = await http.get(Uri.parse('${Environment.apiUrl }/drivers'), headers: headers);   
  if ( resp.statusCode == 200 ) {

  drivers.clear();  
  final data = jsonDecode(resp.body)["drivers"] as List;  
  final list = List<Driver>.from(data.map((x) => Driver.fromMap(x)));
  drivers.addAll(list); 
 
 load = false;
 notifyListeners();
 
 return list;    
  
}else{
  return [];
}       
}

 Future updateDriver( Driver driver ) async {

    isSaving = true;
    notifyListeners();

    // ignore: unnecessary_null_comparison
    if ( driver == null  ) {
      // Es necesario asignar conductor
      return '';
    } else {
      // No realizar acciones
      await deleteDriver( driver );
    }

    isSaving = false;
    notifyListeners();

  }


Future<dynamic> deleteDriver(Driver driver) async {

  isSaving = true;
  notifyListeners();  
   
  final token = await  AuthService.getToken();    
  final Map<String, String> headers = {'Content-Type': 'application/json', 'x-token': token.toString()};
  final Map<String, String> idConductor = {'idDriver': driver.id };  
    
  
  final resp = await http.put(Uri.parse('${Environment.apiUrl }/booking/remove'),
  headers: headers, body: jsonEncode(idConductor) );   
  
  if ( resp.statusCode == 200 ) {

  final Map<String, dynamic> data = jsonDecode(resp.body);
  //address.miId = data['miId'];  
  
  /* final index = addresses.indexWhere((element) => element.miId == address.miId );    
  addresses[index] = address;
  addresses.remove(address);  */

 
 isSaving = false;
 notifyListeners();
 
 return data;    
  
}else{
  return '';
}       
}   

} 