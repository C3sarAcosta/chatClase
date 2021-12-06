import 'package:chat/helpers/mostrarAlerta.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/custom_button.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/custom_label.dart';
import 'package:chat/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40, 1),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            //Toda la pantalla
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              children: [
                CustomLogo(texto: 'Iniciar sesion'),
                _Form(),
                CustomLabel(
                  texto: 'Crear Cuenta',
                  color: Color.fromRGBO(146, 184, 31, 1),
                  ruta: 'register',
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
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: true);
    final socketService = Provider.of<SocketService>(context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
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
          CustomButton(
            texto: 'Ingresar',
            onPressed: authService.autenticando
                ? () => {}
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginRes =
                        await authService.login(emailCtrl.text, passCtrl.text);
                    if (loginRes) {
                      //Navigator.pushNamed(context, 'usuarios');
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      //Mostrar alerta
                      mostrarAlerta(context, 'Error en el login',
                          'Credemnciales incorrectas');
                    }
                  },
          )
        ],
      ),
    );
  }
}
