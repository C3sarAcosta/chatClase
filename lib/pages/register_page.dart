import 'package:chat/helpers/mostrarAlerta.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/widgets/custom_button.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/custom_label.dart';
import 'package:chat/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40, 1),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            //Toda la pantalla
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                CustomLogo(texto: 'Registrar'),
                _Form(),
                CustomLabel(
                  texto: 'Crear Cuenta',
                  color: Color.fromRGBO(146, 184, 31, 1),
                  ruta: 'login',
                ),
              ],
            ),
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
  final nombreCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Column(
      children: [
        CustomInput(
          icono: Icons.people_outline,
          placeHolder: 'Nombre',
          keyboardType: TextInputType.text,
          textController: nombreCtrl,
        ),
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
        CustomButton(
          texto: 'Registrar',
          onPressed: authService.autenticando
              ? () => {}
              : () async {
                  /*print(emailCtrl.text);
              print(passCtrl.text);
              print(nombreCtrl.text);*/
                  final registro = await authService.register(
                    nombreCtrl.text,
                    emailCtrl.text,
                    passCtrl.text,
                  );
                  if (registro == true) {
                    Navigator.pushReplacementNamed(context, 'usuarios');
                  } else {
                    mostrarAlerta(context, 'Registro Incorrecto', registro);
                  }
                },
        ),
      ],
    );
  }
}
