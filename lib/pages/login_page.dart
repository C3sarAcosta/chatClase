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
              _ImagenLogo(),
              _Form(),
              _Labels(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  const _Labels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Crear Cuenta',
            style: TextStyle(
                color: Color.fromRGBO(146, 184, 31, 1),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 100),
          Text(
            'Tecnologias Moviles II',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(),
        TextField(),
        ElevatedButton(onPressed: () {}, child: Text('Iniciar'))
      ],
    );
  }
}

class _ImagenLogo extends StatelessWidget {
  const _ImagenLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Image(image: AssetImage('assets/XXXVAniversario.png')),
            SizedBox(
              height: 20,
            ),
            Text(
              'Messenger',
              style: TextStyle(fontSize: 35, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
