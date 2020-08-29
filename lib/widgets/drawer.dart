import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// importing service....
import '../services/auth/services.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Consumer<UserAuth>(
            builder: (context, auth, _) => Container(
              child: Text(
                "Hi, ${auth.name}",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<UserAuth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
