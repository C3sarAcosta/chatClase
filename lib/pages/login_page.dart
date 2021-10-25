import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/custom_label.dart';
import 'package:chat/widgets/custom_logo.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CustomLogo(texto: 'Iniciar sesion'),
              _Form(),
              CustomLabel(
                texto: 'Crear Cuenta',
                color: Color.fromRGBO(146, 184, 31, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInput(
          icono: Icons.mail_outline,
          placeHolder: 'Email',
          keyboardType: TextInputType.emailAddress,
          textController: emailCtrl,
        ),
        CustomInput(
          icono: Icons.lock_outline,
          placeHolder: 'Contraseña',
          keyboardType: TextInputType.text,
          textController: passCtrl,
          isPassword: true,
        ),
        ElevatedButton(onPressed: () {}, child: Text('Iniciar'))
      ],
    );
  }
}
