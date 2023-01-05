import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cargando Ordenes'),
        ),
        body: const CircularProgressIndicator(
          color: Colors.indigo, 
          ),
    );
  }
}