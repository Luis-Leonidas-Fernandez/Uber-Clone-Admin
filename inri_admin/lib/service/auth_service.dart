import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';


import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:inri_admin/global/environment.dart';
import 'package:inri_admin/models/login.dart';
import 'package:inri_admin/models/usuario.dart';


class AuthService with ChangeNotifier {

late Usuario usuario;
bool _autenticando = false;
//crear storage
final _storage = const FlutterSecureStorage();


//determina la autenticacion

bool get autenticando => _autenticando;
set autenticando( bool valor ) {
  _autenticando = valor;

  notifyListeners();
} 

// Getters del token de forma estática
 static Future<String?> getToken() async {    
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }  

//delete token
  Future<void> deleteToken() async {
    // ignore: prefer_const_constructors
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  } 


//Registro de Usuario
Future register(String nombre, String email, String password ) async {

    _autenticando = true;

    final data = {'nombre': nombre,'email': email,'password': password};    
    final body = jsonEncode(data);
    final headers = {'Content-Type': 'application/json'};

    final resp = await http.post(Uri.parse('${Environment.apiUrl }/login/new'), body: body, headers: headers);       
    
    _autenticando = false;

    if ( resp.statusCode == 200 ) {
    
    final loginResponse = loginResponseFromJson( resp.body );
    usuario = loginResponse.usuario;
    await _guardarToken(loginResponse.token);

    return true;
    
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  }

  Future<bool> isLoggedIn(String token) async {
    
    final token  = await _storage.read(key: 'token');
    
    final Map<String, String> headers = {'Content-Type': 'application/json', 'x-token': token.toString()};
  
    
    final resp = await http.get( Uri.parse('${Environment.apiUrl }/login/renew'),   headers: headers);

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);
     
      return true;
    } else {
      logout();
      return false;
    }

  }

  Future<bool> login( String email, String password ) async {
    
    _autenticando = true;

    final data = {'email': email, 'password': password};
    final headers = {'Content-Type': 'application/json'};    
    final body = jsonEncode(data);

    final resp = await http.post(Uri.parse('${ Environment.apiUrl }/login'), body: body, headers: headers  );

    _autenticando = false;

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);      
      
      return true;
    } else {
      return false;
    }
  } 
  
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
     encryptedSharedPreferences: false,
   );

   // ignore: unused_element
   IOSOptions _getIOSOptions() => const IOSOptions(
    
   );
  

  Future _guardarToken( String token ) async {
    return await _storage.write(key: 'token', value: token, aOptions: _getAndroidOptions() );
  }     
  
  Future logout() async {
    await _storage.delete(key: 'token');
  }  
  
}