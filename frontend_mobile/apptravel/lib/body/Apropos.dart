import 'dart:convert';

import 'package:apptravel/body/home.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:apptravel/body/bouton.dart';

class Propos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [TopImage(), inform()],
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Color.fromARGB(255, 236, 234, 234),
          size: 20,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        },
      ),
      title: Text(
        'Apropos de nous',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.favorite_outline_rounded,
            color: Color.fromARGB(255, 246, 244, 244),
            size: 20,
          ),
          onPressed: null,
        ),
      ],
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 205, 163, 151),
    );
  }
}

class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 30,
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: Image.asset("assets/images/appo.jpg"),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}

class inform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Apropos",
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
            "E-TRANSPORT est une apllication mobile qui a pour but de faciliter les reservation et la gestion du transport plus facilement au Burkina.")
      ],
    ));
  }
}
