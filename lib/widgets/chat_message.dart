import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  //final AnimationController animationCtrl;
  const ChatMessage({Key? key, required this.texto, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Container(
      child:
          this.uid == authService.usuario!.uid ? _myMessage() : _otherMessage(),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(9),
        margin: EdgeInsets.only(bottom: 6, left: 50, right: 6),
        child: Text(
          this.texto,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
            color: Color.fromRGBO(146, 184, 37, 1),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _otherMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(9),
        margin: EdgeInsets.only(bottom: 6, left: 6, right: 50),
        child: Text(
          this.texto,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
            color: Color.fromRGBO(142, 144, 145, 1),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
