import 'package:flutter/material.dart';
import 'package:food_core/food_core/model/response.dart';
import 'package:food_core/food_core/ui/login/login_component.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

abstract class BaseState<S extends StatefulWidget> extends State<S>  {

  @override
  Widget build(BuildContext context) {
    return null;
  }

  void handleError(Response response){
    if(response.status == Response.NO_AUTH_CODE) {
      showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            content: Text(Strings.noAuth),
            actions: <Widget>[
              TextButton(
                child: Text(Strings.ok),
                onPressed: () {
                  showRegister();
                },
              )
            ],
          ));
    } else {
      GlobalUtils.showFlashBanner(context, Strings.info, response.message);
    }
  }

  showRegister(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()), ModalRoute.withName('/'));
  }
}

