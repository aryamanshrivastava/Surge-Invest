import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:testings/models/users.dart';
import 'package:testings/screens/auth/login.dart';

import 'BottomNavigation.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authState = Provider.of<UserModel?>(context);
    return _authState == null ? LoginScreen() : BottomBar();
  }
}