import 'package:chat/models/mensajes_response.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _escribiendo = false;
  final _textCtrl = TextEditingController();
  final _focusNode = FocusNode();
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;
  List<ChatMessage> _messages = [];
  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);
    this.socketService.socket.on('mensaje-personal', _escucharMensaje);
    _cargarHistorial(this.chatService.usuarioDestino!.uid);
  }

  void _cargarHistorial(String usuarioId) async {
    List<Mensaje> chat = await this.chatService.getChat(usuarioId);
    final historial = chat.map((e) => ChatMessage(texto: e.mensaje, uid: e.de));
    setState(() {
      _messages.insertAll(0, historial);
    });
  }

  void _escucharMensaje(dynamic payload) {
    print(payload['mensaje']);
    ChatMessage message =
        new ChatMessage(texto: payload['mensaje'], uid: payload['de']);
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context, listen: true);
    final usuarioDestino = chatService.usuarioDestino;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        title: Row(
          children: [
            CircleAvatar(
                child: Text(
              usuarioDestino!.nombre.substring(0, 2),
              style: TextStyle(fontSize: 12, color: Colors.white),
            )),
            SizedBox(width: 30),
            Text(usuarioDestino.nombre)
          ],
        ),
      ),
      body: Container(
        color: Color.fromRGBO(55, 55, 55, 1),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) => _messages[i],
                itemCount: _messages.length,
                reverse: true,
              ),
            ),
            Divider(),
            Container(
              color: Color.fromRGBO(40, 40, 40, 1),
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return (Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textCtrl,
              onChanged: (texto) {
                setState(() {
                  texto.trim().length > 0
                      ? _escribiendo = true
                      : _escribiendo = false;
                });
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration.collapsed(
                hintText: 'Enviar',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Container(
            child: IconTheme(
              data: IconThemeData(color: Color.fromRGBO(146, 184, 31, 1)),
              child: IconButton(
                icon: Icon(Icons.send_outlined),
                onPressed:
                    _escribiendo ? () => _handleSubmit(_textCtrl.text) : null,
              ),
            ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    _focusNode.requestFocus();
    _textCtrl.clear();
    final newMessage = ChatMessage(texto: texto, uid: authService.usuario!.uid);
    _messages.insert(0, newMessage);
    setState(() {
      this.socketService.emit('mensaje-personal', {
        'de': this.authService.usuario!.uid,
        'para': this.chatService.usuarioDestino!.uid,
        'mensaje': texto
      });
    });
  }

  @override
  void dispose() {
    this.socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}
