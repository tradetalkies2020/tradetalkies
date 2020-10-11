import 'package:fireauth/services/auth/services.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:fireauth/widgets/textformfield.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Password extends StatefulWidget {
  Password({
    Key key,
  }) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool _isLoading = false;

  final _newPasswordController = TextEditingController();
  final _oldpasswordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  Future<void> _submit() async {
    final String oldPassword = _oldpasswordController.text;
    final String password = _newPasswordController.text;
    final String conf_password = _confirmpasswordController.text;

    if(oldPassword==''||password==''||conf_password==''){
Toast.show(
          "Please fill al the fields",
          context,
          duration: Toast.LENGTH_LONG,
        );
    }
    else{
      if (password == conf_password) {
      setState(() {
        _isLoading = true;
      });

      try {
        await Provider.of<UserAuth>(context, listen: false)
            .change_password(oldPassword, password);
        print('Password changed');

        _oldpasswordController.text = '';
        _newPasswordController.text = '';
        _confirmpasswordController.text = '';
        Toast.show(
          "Password changed",
          context,
          duration: Toast.LENGTH_LONG,
        );

        // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        // Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) {
        //                     return AvatarGenderAgeUpload(firstVisit: true,);
        //                   },
        //                 ),
        //               );
        // print("going on home page");
      } catch (err) {
        Toast.show(
          "Failed to change password",
          context,
          duration: Toast.LENGTH_LONG,
        );
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      print('Password not matched');
      Toast.show(
        "Password did not matched",
        context,
        duration: Toast.LENGTH_LONG,
      );
    }
    }

    
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _oldpasswordController.dispose();
    _newPasswordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(
          preferredSize:
              Size.fromHeight(58.0), // Change the height of the appbar
          child: CustomAppbar(
            isHome: false,
            leading: true,
            show_icon: false,
            isProfile: false,

            elevation: 2.0,
            color: Colors.white,
            title: 'Password',
          )),
      // appBar: AppBar(
      //   title: Text(
      //     'Profile Info',
      //     style: TextStyle(
      //         color: Colors.black,
      //         fontFamily: 'Poppins',
      //         fontSize: 18,
      //         fontWeight: FontWeight.w500),
      //   ),
      //   automaticallyImplyLeading: true,
      //   elevation: 2,
      //   backgroundColor: Colors.white,
      //   iconTheme: IconThemeData.fallback(),
      //   actions: widget.forEdit
      //       ? null
      //       : <Widget>[
      //           Padding(
      //             padding: const EdgeInsets.all(20.0),
      //             child: InkWell(
      //               onTap: () {
      //                 Navigator.pop(context);
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => Password(
      //                               firstVisit: true,forEdit: true,
      //                             )));
      //               },
      //               child: Text('Edit info',
      //                   style: TextStyle(color: Color(0xFF4175DF), fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.w500)),
      //             ),
      //           )
      //         ],
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: oldPasswordTextFormField(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: newPasswordTextFormField(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: confirmPasswordTextFormField(),
          ),
          _isLoading
              ? Container(margin: EdgeInsets.fromLTRB(15, 30, 15, 0),child: Center(child: CircularProgressIndicator(),))
              : InkWell(
                  onTap: _submit,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xFF3550A3),
                    ),
                    margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                    // width: _large ? _width - 45 : (_medium ? _width - 35 : _width - 25),
                    height: 50,
                    child: Center(
                      child: Text(
                        "Change Password",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget oldPasswordTextFormField() {
    return CustomTextField(
      obscureText: true,
      max: 1,
      keyboardType: TextInputType.visiblePassword,
      textEditingController: _oldpasswordController,
      hint: "Old password",
    );
  }

  Widget newPasswordTextFormField() {
    return CustomTextField(
      obscureText: true,
      max: 1,
      keyboardType: TextInputType.visiblePassword,
      textEditingController: _newPasswordController,
      hint: "New password",
    );
  }

  Widget confirmPasswordTextFormField() {
    return CustomTextField(
      obscureText: true,
      max: 1,
      keyboardType: TextInputType.visiblePassword,
      textEditingController: _confirmpasswordController,
      hint: "Confirm new password",
    );
  }
}
