import 'package:flutter/material.dart';


import 'package:inri_admin/service/addresses_service.dart';
import 'package:inri_admin/service/drivers_service.dart';


import 'package:provider/provider.dart';
import 'package:inri_admin/routes/routes.dart';
import 'package:inri_admin/service/auth_service.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => AddressService()),
        ChangeNotifierProvider(create: (_) => DriverService()),           
          
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'admin inri',
        initialRoute: 'login',
        routes: {
          'login'   : (BuildContext context) => const LoginPage(),
          'register': (BuildContext context) => const RegisterPage(),
          'session': (BuildContext context) => const SessionPage(),
          'home': (BuildContext context) => const HomePage(),
          'address': (BuildContext context) => const AddressPage(),
          'driver': (BuildContext context) => const DriverPage(),
          'updatedriver': (BuildContext context) => const UpdateDriverPage(),
        },
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme:const AppBarTheme(
            elevation: 0,
            color: Colors.indigo
          )
        ),
      ),
    );
  }
}
