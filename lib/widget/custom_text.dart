import 'package:flutter/material.dart';

class CustomText extends Text{

  CustomText(String data, {color: Colors.black, textAlign: TextAlign.center}):
        super(data,
          textAlign: textAlign,
          style: new TextStyle(color: color)
      );

}
