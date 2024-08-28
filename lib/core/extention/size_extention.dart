
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:socia/core/routing/router.dart';

extension DimentionalExtention on num{

  static const double _width = 430.0;
  static const double _height = 932.0;

  double get rW => (MediaQuery.of(Routers.globalNavigatorKey!).size.width/_width)* this;

  double get rH=> (MediaQuery.of(Routers.globalNavigatorKey!).size.height/_height)* this;

  double get rP=>
      max(MediaQuery.of(Routers.globalNavigatorKey!).size.height/_height,
          MediaQuery.of(Routers.globalNavigatorKey!).size.width/_width) * this;
}
