import 'package:apptravel/Screens/Welcome/welcome_screen.dart';
import 'package:apptravel/body/Apropos.dart';
import 'package:apptravel/body/user.dart';
import 'package:flutter/material.dart';
import 'package:apptravel/body/Parcours.dart';
import '../../../constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'courrier.dart';
import 'pages.dart';
import 'package:apptravel/body/bouton.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Search(),
            TopImage(),
            Voyages(),
            Voyages1(),
          ],
        ),
      ),
    );
  }
}

Boutonbar instance = Boutonbar();

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
        onPressed: () async {},
      ),
      title: Text(
        'EXPLORER',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.person,
            color: Color.fromARGB(255, 244, 241, 241),
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return InfosUser();
                },
              ),
            );
          },
        ),
      ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "\t \t \t \t \t \t\t \t \t E-Transport",
                      style: GoogleFonts.lobster(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
            const Spacer(),
            Expanded(
              flex: 5,
              child: Image.asset("assets/images/p1.png"),
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

class Voyages extends StatelessWidget {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(children: [
        Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 2 -
                20, // minus 32 due to the margin
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 205, 163, 151), // background color of the cards
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                // this is the shadow of the card
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0.5,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Parcour();
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.design_services,
                        size: 30,
                      ),
                      SizedBox(
                        width: 05,
                      ),
                      Text(
                        ' CONSULTATION \n VOYAGES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Netflix",
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 0.0,
                          color: Color.fromARGB(255, 10, 10, 10),
                        ),
                      ),
                    ],
                  )),
            )),
        Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 2 -
                32, // minus 32 due to the margin
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 205, 163, 151), // background color of the cards
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                // this is the shadow of the card
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0.5,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Pages();
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.car_rental,
                        size: 30,
                      ),
                      SizedBox(
                        width: 05,
                      ),
                      Text(
                        'RESERVATION',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Netflix",
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 0.0,
                          color: Color.fromARGB(255, 10, 10, 10),
                        ),
                      ),
                    ],
                  )),
            )),
      ]),
    );
  }
}

class Voyages1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(children: [
        Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 2 -
                20, // minus 32 due to the margin
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 205, 163, 151), // background color of the cards
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                // this is the shadow of the card
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0.5,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Courrier();
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.mark_as_unread,
                        size: 30,
                      ),
                      Text(
                        'SERVICE COURRIER',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Netflix",
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 0.0,
                          color: Color.fromARGB(255, 10, 10, 10),
                        ),
                      ),
                    ],
                  )),
            )),
        Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 2 -
                32, // minus 32 due to the margin
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 205, 163, 151), // background color of the cards
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                // this is the shadow of the card
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0.5,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Propos();
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'APROPOS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Netflix",
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 0.0,
                          color: Color.fromARGB(255, 10, 10, 10),
                        ),
                      ),
                    ],
                  )),
            )),
      ]),
    );
  }
}
