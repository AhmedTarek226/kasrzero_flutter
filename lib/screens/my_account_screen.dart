import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.getUser();
    return SafeArea(
      child: Scaffold(
          body: currentUser.id != "id"
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text("welcome ${currentUser.userName}"),
                    ElevatedButton(
                        onPressed: (() {
                          Navigator.pushNamed(context, '/my_info');
                        }),
                        child: Text("My info")),
                    ElevatedButton(
                        onPressed: (() {
                          userProvider.logoutUser();
                          Navigator.pushReplacementNamed(context, '/main');
                        }),
                        child: Text("Logout"))
                  ],
                ))
              : Center(
                  child: ElevatedButton(
                  child: Text("Login"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                ))),
    );
  }
}
