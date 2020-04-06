import 'package:flutter/material.dart';

import 'package:saca/components/accordion.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Accordion(),
      // child: Text("Registrar"),
    );
  }
}