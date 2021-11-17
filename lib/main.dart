import 'package:chat/routes/routes.dart';
import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Creamos una instancia global de auth_services
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Messenger',
        initialRoute: 'login',
        routes: appRoutes,
      ),
    );
  }
}
