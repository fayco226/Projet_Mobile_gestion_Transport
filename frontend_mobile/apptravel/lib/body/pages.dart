import 'dart:convert';

import 'package:apptravel/Screens/Welcome/welcome_screen.dart';
import 'package:apptravel/body/Apropos.dart';
import 'package:apptravel/body/home.dart';
import 'package:apptravel/body/recherche.dart';
import 'package:apptravel/body/reservperson.dart';
import 'package:apptravel/body/voyages.dart';
import 'package:flutter/material.dart';
import 'package:apptravel/body/Parcours.dart';
import 'package:apptravel/body/reserver.dart';
import '../../../constants.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apptravel/body/bouton.dart';
import 'package:http/http.dart' as http;
import 'courrier.dart';

class Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Search(),
            Moi(),
            Autre(),
          ],
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
        onPressed: () async {
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
        'Page de Reservation',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [],
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 205, 163, 151),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                textInputAction: TextInputAction.done,
                obscureText: false,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Recherche",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.search),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class Moi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Reserver();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryLightColor, elevation: 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Me Reserver une place".toUpperCase(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                  ],
                )),
          ],
        ));
  }
}

class Autre extends StatelessWidget {
  get child => null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Reserver1();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryLightColor, elevation: 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Reserver une personne".toUpperCase(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                  ],
                )),
          ],
        ));
  }
}
