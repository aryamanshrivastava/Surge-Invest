import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testings/screens/auth/auth_wrapper.dart';
import 'package:testings/services/auth.dart';

class SurgeApp extends StatelessWidget {
  const SurgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(value: AuthService().user, initialData: null)
      ],
      child: MaterialApp(
        title: 'Surge',
        home: AuthWrapper(),
      ),
    );
  }
}
