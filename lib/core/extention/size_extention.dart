
import 'dart:math';

import 'package:flutter/material.dart';

extension DimentionalExtention on num{

  static const double _width = 430.0;
  static const double _height = 932.0;

  double rW(BuildContext context)=> (MediaQuery.of(context).size.width/_width)* this;

  double rH(BuildContext context)=> (MediaQuery.of(context).size.height/_height)* this;

  double rP(BuildContext context)=>
      max(MediaQuery.of(context).size.height/_height,
          MediaQuery.of(context).size.width/_width) * this;
}
