import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testings/models/change.dart';
import 'package:testings/screens/auth/auth_wrapper.dart';
import 'package:testings/services/auth.dart';
import 'package:testings/services/db.dart';
import 'package:testings/services/razorpay.dart';

class SurgeApp extends StatelessWidget {
  const SurgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(value: AuthService().user, initialData: null),
        StreamProvider.value(value: Db().listenToMessages, initialData: null),
        ChangeNotifierProvider(create: (_) => BoolChange()),
        ProxyProvider0<RP>(update: (_, __) => RP(context)),
      ],
      child: MaterialApp(
        title: 'Surge',
        home: AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
