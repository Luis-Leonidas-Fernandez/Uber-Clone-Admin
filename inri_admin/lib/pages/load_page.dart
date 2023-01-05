import 'package:flutter/material.dart';

class LoadPage extends StatelessWidget {
  const LoadPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Cargando Conductores')),
        ),
        body: const CircularProgressIndicator(
          color: Colors.indigo, 
          ),
    );
  }
}