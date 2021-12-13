import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({Key? key}) : super(key: key);

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  final _refreshController = RefreshController(initialRefresh: false);
  final usuariosService = new UsuariosService();
  TextStyle styleTexto = TextStyle(color: Colors.black);
  List<Usuario> usuarios = [];

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context, listen: true);
    final infoUsuario = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        title: Text(infoUsuario!.nombre),
        elevation: 1,
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app_outlined),
          onPressed: () {
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
              padding: EdgeInsets.only(right: 20),
              child: (socketService.serverStatus == ServerStatus.Online)
                  ? Icon(Icons.circle_rounded,
                      color: Color.fromRGBO(146, 184, 31, 1))
                  : Icon(Icons.circle_rounded, color: Colors.red))
        ],
      ),
      body: Container(
        color: Color.fromRGBO(40, 40, 40, 1),
        child: SmartRefresher(
          controller: _refreshController,
          child: _listViewUsuarios(),
          enablePullDown: true,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check_outlined,
              color: Color.fromRGBO(146, 184, 31, 1),
            ),
            waterDropColor: Color.fromRGBO(146, 184, 31, 1),
          ),
          onRefresh: _cargarUsuarios,
        ),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre, style: styleTexto),
      subtitle: Text(usuario.email, style: styleTexto),
      leading: CircleAvatar(
        child: Text(
          usuario.nombre.substring(0, 2),
          style: styleTexto,
        ),
      ),
      trailing: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
            color:
                usuario.online ? Color.fromRGBO(146, 184, 31, 1) : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioDestino = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _cargarUsuarios() async {
    this.usuarios = await usuariosService.getUsuarios();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
