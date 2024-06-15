

String? emailValidator(String? value) {
    RegExp emailRegExp = RegExp(r'[a-zA-z0-9.\-]+@[a-z]+.[a-z]{2,3}');
    if (value==null||value.isEmpty) {
      return 'Please Enter Your Email';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Enter Your Valid mail';
    } else {
      return null;
    }
  }

  String? passWordValidator(String? value) {
    RegExp passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).{8,}$');
    if (value==null||value.isEmpty) {
      return 'Enter Password';
    } else if (!passwordRegExp.hasMatch(value)) {
      return '''Enter your at least 8 character with a lower & upper case letter''';
    } else {
      return null;
    }
  }

