import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';

import 'package:inri_admin/global/environment.dart';
import 'package:http/http.dart' as http;

import 'package:inri_admin/models/new_address.dart';
import 'package:inri_admin/service/auth_service.dart';


class AddressService with ChangeNotifier{   
  
  late AuthService authService;
  final List<AddressElement> addresses = <AddressElement>[];
  
  
  late AddressElement selectedAddress;
  bool isLoading = true;
  bool isSaving = false;

  AddressService(){
    getAddresses();
  }   

  Future <List<AddressElement>> getAddresses() async {

    isLoading = true;
    notifyListeners();
   
  final token = await AuthService.getToken();    
  final Map<String, String> headers = {'Content-Type': 'application/json', 'Charset': 'utf-8',  'x-token': token.toString()};
  

  final resp = await http.get(Uri.parse('${Environment.apiUrl }/ubicaciones'), headers: headers);   
  if ( resp.statusCode == 200 ) {

  addresses.clear();  
  final data = jsonDecode(resp.body)["addresses"] as List;  
  final list = List<AddressElement>.from(data.map((x) => AddressElement.fromMap(x)));
  addresses.addAll(list); 
 
 isLoading = false;
 notifyListeners();
 
 return list;    
  
}else{
  return [];
}       
}

Future updateAddress( AddressElement address ) async {

    isSaving = true;
    notifyListeners();

    // ignore: unnecessary_null_comparison
    if ( address.miId == null  ) {
      // Es necesario asignar conductor
      return '';
    } else {
      // No realizar acciones
      await assignDriver( address );
    }

    isSaving = false;
    notifyListeners();

  }


Future<dynamic> assignDriver(AddressElement address) async {

  isSaving = true;
  notifyListeners();  
   
  final token = await  AuthService.getToken();    
  final Map<String, String> headers = {'Content-Type': 'application/json', 'x-token': token.toString()};
  final Map<String, String> client = {'miId': address.miId };  
    
  
  final resp = await http.patch(Uri.parse('${Environment.apiUrl }/booking'), headers: headers, body: jsonEncode(client) );   
  
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