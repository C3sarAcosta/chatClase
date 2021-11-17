import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _escribiendo = false;
  final _textCtrl = TextEditingController();
  final _focusNode = FocusNode();
  List<ChatMessage> _messages = [
    ChatMessage(
        texto:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris volutpat, arcu eu feugiat interdum, sem lacus laoreet leo, mollis pellentesque mi nisl at sapien.',
        uid: '123'),
    ChatMessage(
        texto:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris volutpat, arcu eu feugiat interdum, sem lacus laoreet leo, mollis pellentesque mi nisl at sapien.',
        uid: '6353'),
    ChatMessage(
        texto:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris volutpat, arcu eu feugiat interdum, sem lacus laoreet leo, mollis pellentesque mi nisl at sapien.',
        uid: '6353'),
    ChatMessage(
        texto:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris volutpat, arcu eu feugiat interdum, sem lacus laoreet leo, mollis pellentesque mi nisl at sapien.',
        uid: '123'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        title: Row(
          children: [
            CircleAvatar(
              child: Text('JC'),
            ),
            SizedBox(width: 30),
            Text('Jose Chavarria')
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
    final newMessage = ChatMessage(texto: texto, uid: '123');
    _messages.insert(0, newMessage);
    setState(() {});
  }
}
