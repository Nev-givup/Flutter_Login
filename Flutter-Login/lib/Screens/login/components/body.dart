import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/Components/Rounded_Button.dart';
import 'package:myapp/Components/Rounded_input_field.dart';
import 'package:myapp/Components/already_hava_an_account_check.dart';
import 'package:myapp/Components/rounded_password_field.dart';
import 'package:myapp/Components/text_field_container.dart';
import 'package:myapp/Screens/login/components/Background.dart';
import 'package:myapp/contants.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "LOGIN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: size.height * 0.03),
        SvgPicture.asset(
          "assets/icons/login.svg",
          height: size.height * 0.35,
        ),
        SizedBox(height: size.height * 0.03),
        RoundedInputField(
          hintText: "Your Email",
          onchanged: (value) {},
        ),
        RoundedPasswordField(
          onchanged: (value) {},
        ),
        RoundedButton(
          text: "LOGIN",
          press: () {},
        ),
        SizedBox(height: size.height * 0.03),
        AlreadyHaveAnAccountCheck(
          press: () {},
        ),
      ],
    ));
  }
}
