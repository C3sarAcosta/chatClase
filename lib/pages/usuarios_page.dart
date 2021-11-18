import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({Key? key}) : super(key: key);

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  @override
  Widget build(BuildContext context) {
    final usuario = [
      Usuario(
          email: 'cristian.lb@delicias.tecnm.mx',
          nombre: 'Cristian Luevanos',
          uid: '871256381',
          online: true),
      Usuario(
          email: 'mariel.bl@delicias.tecnm.mx',
          nombre: 'Mariel Baeza',
          uid: '736547283',
          online: false),
      Usuario(
          email: 'jose.cm@delicias.tecnm.mx',
          nombre: 'Jose Chavarria',
          uid: '78213581',
          online: false),
      Usuario(
          email: 'Vanessa.bs@delicias.tecnm.mx',
          nombre: 'Vanessa Burrola',
          uid: '5243623',
          online: true),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis contactos'),
        elevation: 1,
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app_outlined),
          onPressed: () {},
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.circle_rounded,
              color: Color.fromRGBO(146, 184, 31, 1),
            ),
          )
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => ListTile(
          title: Text(usuario[i].nombre),
          leading: CircleAvatar(
            child: Text(
              usuario[i].nombre.substring(0, 2),
            ),
          ),
          trailing: Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              color: usuario[i].online
                  ? Color.fromRGBO(146, 184, 31, 1)
                  : Colors.red,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuario.length,
      ),
    );
  }
}
