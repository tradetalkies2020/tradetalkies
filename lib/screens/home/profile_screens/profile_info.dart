// import 'dart:html';
// import 'dart:html';

import 'package:fireauth/services/auth/services.dart';
import 'package:fireauth/services/home/getInfo.dart';
import 'package:fireauth/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:fireauth/screens/home/home.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:fireauth/widgets/

import 'dart:io';
// import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:fireauth/widgets/dropdown_formField.dart';
import 'package:fireauth/widgets/responsive_ui.dart';
import 'package:fireauth/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Profile_info extends StatefulWidget {
  bool forEdit;

  Profile_info({Key key, this.forEdit}) : super(key: key);

  @override
  _Profile_infoState createState() => _Profile_infoState();
}

class _Profile_infoState extends State<Profile_info> {
  bool _isLoading = false;

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  final _ageController = TextEditingController();
  final _industryController = TextEditingController();
  final _aboutController = TextEditingController();
  final _telegramIdController = TextEditingController();
  final _twitterIdController = TextEditingController();

  String industry = 'Finance';

  String oldIndustry;
  String newIndustry;
  String imageUrl = '';
  int oldAge;
  int newAge;

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

  void initState() {
    _getInfo();
  }
  // @override
  // void initState() {
  //   _getInfo();

  //   super.initState();
  // }

  Future<void> _getInfo() async {
    setState(() {
      widget.forEdit ? _isLoading = false : _isLoading = true;
    });
    try {
      Map output = await Provider.of<UserAuth>(context, listen: false).getAge();

      oldAge = output['age'];
      oldIndustry = output['industry'];
      imageUrl = output['image'];
      print("age=$oldAge");
      // Info myinfo = new Info();
      // myinfo.image=

      // oldIndustry =
      //     await Provider.of<UserAuth>(context, listen: false).getIndustry();
      print("industry=$oldIndustry");
    } catch (err) {
      print(err.toString());
      Toast.show(
        "error",
        context,
        duration: Toast.LENGTH_LONG,
      );
    }
    setState(() {
      _isLoading = false;
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
      // Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) {
      //                     return AvatarGenderAgeUpload(firstVisit: true,);
      //                   },
      //                 ),
      //               );
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
      // appBar: new PreferredSize(
      //   preferredSize: Size.fromHeight(58.0), // Change the height of the appbar
      //   child: CustomAppbar(
      //     leading: true,
      //     show_icon: false,
      //     elevation: 5.0,
      //     color: Colors.white,
      //     title: 'Profile Info',
      // )),
      appBar: AppBar(
        title: Text(
          'Profile Info',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: true,
        elevation: 2,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData.fallback(),
        actions: widget.forEdit
            ? null
            : <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile_info(
                                    forEdit: true,
                                  )));
                    },
                    child: Text('Edit info',
                        style: TextStyle(
                            color: Color(0xFF4175DF),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500)),
                  ),
                )
              ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 35),
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
                                ? NetworkImage(imageUrl)
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                  width: 1, color: Color(0xFFE1E1E1)),
                            ),
                            height: 45,
                            width: _width / 2 - 30,
                            // width: 150,
                            child: Center(
                              child: Text("Change Picture",
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
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Which industry you belong to ?",
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            letterSpacing: 0.2,
                            fontSize: 18.0,
                          ),
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
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : next(),
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
        //   Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ForgotPassword(),
        //     ),
        //   );
        // },
        onTap: widget.forEdit ? _submit : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: widget.forEdit ? Color(0xFF3D96FF) : Color(0xFFABABAB),
          ),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          width: _large ? _width - 45 : (_medium ? _width - 35 : _width - 25),
          height: 50,
          child: Center(
            child: Text(
              widget.forEdit ? "Save changes" : "Next",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      );
  Widget ageTextFormField() {
    return CustomTextField(
      initVal: widget.forEdit ? null : oldAge.toString(),
      keyboardType: TextInputType.number,
      obscureText: false,
      max: 1,
      textEditingController: widget.forEdit ? _ageController : null,
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
        value: widget.forEdit ? industry : oldIndustry,
        // value: widget.ForEdit ? widget.Edit_action : option_action,
        onSaved: (value) {
          setState(() {
            industry = value;
            // widget.firstVisit = false;
            print(industry);

            // option_action = value;
            // widget.Edit_action = value;
          });
        },
        onChanged: (value) {
          setState(() {
            industry = value;
            // widget.firstVisit = false;
            print(industry);
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
