import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:inri_admin/login-ui/input_decorations.dart';
import 'package:inri_admin/providers/login_form_validar.dart';

import 'package:inri_admin/routes/routes.dart';
import 'package:inri_admin/service/auth_service.dart';
import 'package:inri_admin/widgets/card_container.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          
        
        child: Column(

          children: [

            const SizedBox( height: 250),

            CardContainer(
              child: Column(

                children:  [

                  const SizedBox(height: 10,),

                  const Text('Registrarme', style: TextStyle(fontSize: 20)),

                  const SizedBox(height: 25,),

                  ChangeNotifierProvider(
                    create: (_) => LoginFormValidar(),
                    child:  const _LoginForm(),
                    
                    )
                  
                 
                  
                
                ],
              )
            ),
            const SizedBox(height: 50),
            TextButton(onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.2))
            ),
             child: const Text('Tengo una Cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
            )
            
          
          ],
        ),
        )
      )
            
      );
    
  }
}
class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  
  final nameCtrl  = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final loginFormValidar = Provider.of<LoginFormValidar>(context);
    final authService = Provider.of<AuthService>(context);

    return Form(

      key: loginFormValidar.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,

     child: Column(

       children: [
         TextFormField(
           autocorrect: false,
           keyboardType: TextInputType.text,                     
           decoration: InputDecorations.authInputDecoration(
             hintText: 'exequiel',
             labelText: 'nombre',
             prefixIcon: Icons.person_pin_sharp,      

           ),
           controller: nameCtrl,            
           ),
         
         const SizedBox(height: 30),
         
         TextFormField(
           autocorrect: false,
           keyboardType: TextInputType.emailAddress,            
           decoration: InputDecorations.authInputDecoration(
             hintText: 'exequiel7@gmail.com',
             labelText: 'email',
             prefixIcon: Icons.alternate_email_rounded,
           ),

           onChanged: (value) => loginFormValidar.email,
             validator:(value){
               String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = RegExp(pattern);
                  
                  return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
             },
             controller: emailCtrl,             
           ),
         
         const SizedBox(height: 30),
         
         TextFormField(
           autocorrect: false,
           obscureText: true,
           keyboardType: TextInputType.emailAddress,            
           decoration: InputDecorations.authInputDecoration(
             hintText: '********',
             labelText: 'password',
             prefixIcon: Icons.lock_outline
           ),
           onChanged: (value) => loginFormValidar.password,
            validator: ( value ) {

                  return ( value != null && value.length >= 8 ) 
                    ? null
                    : 'La contraseña debe de ser de 8 caracteres';                                    
                  
              },
              controller: passCtrl, 
         ),
         const SizedBox(height: 30,),
         
         MaterialButton(
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
           disabledColor: Colors.grey,
           elevation: 0,
           color: Colors.purple,
           onPressed:  authService.autenticando ? null : () async {

             final registroOk = await authService.register(nameCtrl.text.toString(), emailCtrl.text.toString(), passCtrl.text.toString());
                
          if ( registroOk == true && mounted ) {                           
            
          Navigator.pushReplacementNamed(context, 'home');

          }
            
        },
           child: Container(
             padding: const EdgeInsets.symmetric(horizontal:  80, vertical: 15),
             child: Text(
               loginFormValidar.isLoading? 'Espere'
               : 'Registrar',
               style: const TextStyle(color: Colors.white),
             ),
           )          
      )
      ],
     ) 
    );
  }
}