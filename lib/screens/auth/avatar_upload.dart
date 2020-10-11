// import 'dart:html';
import 'package:fireauth/screens/auth/forgot_password.dart';
import 'package:fireauth/services/auth/services.dart';
import 'package:flutter/material.dart';
import 'package:fireauth/screens/home/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../widgets/responsive_ui.dart';
import '../../widgets/textformfield.dart';
import 'dart:io';
// import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:fireauth/widgets/dropdown_formField.dart';

class AvatarGenderAgeUpload extends StatefulWidget {
  bool firstVisit;
  AvatarGenderAgeUpload({Key key, this.firstVisit}) : super(key: key);

  @override
  _AvatarGenderAgeUploadState createState() => _AvatarGenderAgeUploadState();
}

class _AvatarGenderAgeUploadState extends State<AvatarGenderAgeUpload> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  bool _isLoading = false;

  final _ageController = TextEditingController();
  final _industryController = TextEditingController();
  final _aboutController = TextEditingController();
  final _telegramIdController = TextEditingController();
  final _twitterIdController = TextEditingController();

  String industry = 'Finance';

  //to get image from user

  File _image;
  Future _getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print(image);
    });
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    final String age = _ageController.text;
    // final String industry = _industryController.text;

    print(age);
    print(industry);
    // final String password = _passwordController.text;

    try {
      await Provider.of<UserAuth>(context, listen: false)
          .editProfile(age, industry, _image
              // email,
              // password,
              // userName,
              );
      //     await Provider.of<UserAuth>(context, listen: false)
      // .getInfo(
      //     // email,
      //     // password,
      //     // userName,
      //     );
      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    fromPost: false,selectedIndex: 0,
                  )));
      Toast.show(
        "updated profile",
        context,
        duration: Toast.LENGTH_LONG,
      );
      print("profile updated");
    } catch (err) {
      print(err.toString());
      Toast.show(
        "error in updating profile",
        context,
        duration: Toast.LENGTH_LONG,
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  // padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 20),
                  child: Center(
                    child: Text(
                      "Create your profile",
                      style: TextStyle(fontFamily: 'Poppins',fontSize: 20,fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context)
                          // .pushReplacementNamed(HomeScreen.routeName);

                      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(fromPost: false,selectedIndex: 0,)));
                    },
                    child: Text("Skip",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Inter')
                        // style:
                        //     Theme.of(context).textTheme.bodyText1.copyWith(
                        //           fontWeight: FontWeight.w400,
                        //           color: Colors.red,
                        //         ),
                        ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 25,
            ),
            Center(
              // margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).accentColor,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: _image == null
                          ? AssetImage('assets/images/avatar.png')
                          : FileImage(_image),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: _getImage,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(width: 1, color: Color(0xFFE1E1E1)),
                      ),
                      height: 50,
                      width: _width / 2 - 15,
                      // width: 150,
                      child: Center(
                        child: Text("Change Profile Pic",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'Inter')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 75,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Which industry you belong to ?",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(letterSpacing: 0.2, fontSize: 18.0),
              ),
            ),

            // Row(
            //   children: <Widget>[
            //     Container(
            //       width: _width / 3 - 5,
            //       height: 50,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.all(Radius.circular(10)),
            //         border: Border.all(width: 1),
            //       ),
            //       margin: EdgeInsets.only(left: 20),
            //       child: Center(
            //         child: Text(
            //           "Male",
            //           style: Theme.of(context)
            //               .textTheme
            //               .bodyText1
            //               .copyWith(fontWeight: FontWeight.w400),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       width: _width / 3 - 5,
            //       height: 50,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.all(Radius.circular(10)),
            //         border: Border.all(width: 1),
            //       ),
            //       margin: EdgeInsets.only(left: 20),
            //       child: Center(
            //         child: Text(
            //           "Female",
            //           style: Theme.of(context)
            //               .textTheme
            //               .bodyText1
            //               .copyWith(fontWeight: FontWeight.w400),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: _large ? 25 : (_medium ? 20 : 15),
            // ),
            // Container(
            //   width: _width / 3 - 5,
            //   height: 50,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(10)),
            //     border: Border.all(width: 1),
            //   ),
            //   margin: EdgeInsets.only(left: 20),
            //   child: Center(
            //     child: Text(
            //       "Others",
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText1
            //           .copyWith(fontWeight: FontWeight.w400),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: industryTextFormField(),
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "How old are you ?",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(letterSpacing: 0.2, fontSize: 18.0),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ageTextFormField(),
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "About you",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(letterSpacing: 0.2, fontSize: 18.0),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: aboutTextFormField(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: telegramIdTextFormField(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: twitterIdTextFormField(),
            ),
            SizedBox(
              height: 40,
            ),

            _isLoading ? Center(child: CircularProgressIndicator()) : next(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget next() => InkWell(
        // onTap: () {

        // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ForgotPassword(),
        //   ),
        // );
        // },
        onTap: _submit,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xFF3550A3),
          ),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          width: _large ? _width - 45 : (_medium ? _width - 35 : _width - 25),
          height: 50,
          child: Center(
            child: Text(
              "Next",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      );
  Widget ageTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      obscureText: false,
      max: 1,
      textEditingController: _ageController,
      icon: Icons.lock,
      hint: "Enter your age",
    );
  }

  Widget aboutTextFormField() {
    return CustomTextField(
      // initVal: widget.forEdit ? null : oldAge.toString(),
      keyboardType: TextInputType.text,
      obscureText: false,
      max: 3,
      textEditingController: _aboutController,
      // icon: Icons.lock,
      hint: "Bio about you",
    );
  }

  Widget telegramIdTextFormField() {
    return CustomTextField(
      // initVal: widget.forEdit ? null : oldAge.toString(),
      keyboardType: TextInputType.text,
      obscureText: false,
      max: 1,
      textEditingController: _telegramIdController,
      // icon: Icons.lock,
      hint: "Telegram User ID url (Optional)",
    );
  }

  Widget twitterIdTextFormField() {
    return CustomTextField(
      // initVal: widget.forEdit ? null : oldAge.toString(),
      keyboardType: TextInputType.text,
      obscureText: false,
      max: 1,
      textEditingController: _twitterIdController,
      // icon: Icons.lock,
      hint: "Twitter User ID url (Optional)",
    );
  }

  Widget industryTextFormField() {
    // return CustomTextField(
    //   keyboardType: TextInputType.text,
    //   obscureText: false,
    //   max: 1,
    //   textEditingController: _industryController,
    //   icon: Icons.lock,
    //   hint: "Select industry type",
    // );
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFC9C9C9), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: DropDownFormField(
        filled: false,
        // titleText: 'Option Actionnnn',
        hintText: 'Select industry type',
        value: widget.firstVisit ? null : industry,
        // value: widget.ForEdit ? widget.Edit_action : option_action,
        onSaved: (value) {
          setState(() {
            industry = value;
            widget.firstVisit = false;

            // option_action = value;
            // widget.Edit_action = value;
          });
        },
        onChanged: (value) {
          setState(() {
            industry = value;
            widget.firstVisit = false;
            // option_action = value;
            // print(option_action);
            // widget.Edit_action = value;
          });
        },
        dataSource: [
          {
            "display": "Finance",
            "value": "Finance",
          },
          {
            "display": "Trade",
            "value": "Trade",
          },
        ],
        textField: 'display',
        valueField: 'value',
      ),
    );
  }
}
