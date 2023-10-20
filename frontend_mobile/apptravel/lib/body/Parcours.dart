import 'dart:convert';

import 'package:apptravel/body/bouton.dart';
import 'package:apptravel/body/recherche.dart';
import 'package:apptravel/body/voyages.dart';
import 'package:flutter/material.dart';
import 'package:apptravel/body/home.dart';
import '../../../constants.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apptravel/api/voyage.dart';
import 'package:http/http.dart' as http;
export 'Parcours.dart';

class Parcour extends StatefulWidget {
  @override
  _VoyagesListState createState() => _VoyagesListState();
}

String villD = '';
String villA = '';
String heurD = '';
int prix = 0;

class _VoyagesListState extends State<Parcour> {
  List<Voyage> _voyages = [];

  @override
  void initState() {
    super.initState();
    fetchVoyages();
  }

  Future<void> fetchVoyages() async {
    final response = await http
        .get(Uri.parse('http://fasotravel.pythonanywhere.com/api/voyages/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _voyages = data.map((json) => Voyage.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load voyages');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ParcourVoyages(),
                  SizedBox(height: 10), // ajout d'un espace pour plus de clarté
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.7, // hauteur bornée à 70% de la hauteur de l'écran
                    child: ListView.builder(
                      itemCount: _voyages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final voyage = _voyages[index];
                        return Container(
                          margin: EdgeInsets.all(05),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 98, 95, 95),
                                spreadRadius: 4,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                  height: 05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                    ),
                                  )),
                              Container(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Voy();
                                        },
                                      ),
                                    );

                                    villD = voyage.villeDepart;
                                    villA = voyage.villeArrivee;
                                    heurD = voyage.heureDepart;
                                    prix = voyage.prix;
                                  },
                                  child: Text(
                                    '${voyage.villeDepart} - ${voyage.villeArrivee}'
                                            .toUpperCase() +
                                        '\t / \t ${voyage.heureDepart}',
                                    style: GoogleFonts.nunito(
                                      color: Color.fromARGB(255, 81, 18, 18),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
        'Liste des Parcours',
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

String searchValue = '$villD';

class ParcourVoyages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\t \t \t \t \t LISTE DES PARCOURS",
                    style: GoogleFonts.crimsonPro(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 30,
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
        ]));
  }

  void setState(Null Function() param0) {}
}
