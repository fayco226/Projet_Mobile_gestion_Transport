import 'dart:convert';

import 'package:apptravel/body/Parcours.dart';
import 'package:apptravel/body/home.dart';
import 'package:apptravel/body/reserver.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apptravel/body/bouton.dart';
import 'package:http/http.dart' as http;

var vilD = villD;

class Voy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [Search(), Infos()],
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
                return Parcour();
              },
            ),
          );
        },
      ),
      title: Text(
        'INFOS PARCOURS',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.car_rental,
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

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${villD}-${villA} ",
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 13,
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
          ],
        ));
  }
}

String villeDepart = villD;
String villeArrivee = villA;
String prixAllerSimple = "${prix} fcfa";
String prixAllerRetour = "${prix * 2} fcfa";
String distance = "367 km";
String tempsTrajet = "5h de temps";
String heuresDepart = "12h30 \t  16h30 \t 20h30 \t 22h30";

class Infos extends StatefulWidget {
  @override
  _Infos createState() => _Infos();
}

class _Infos extends State<Infos> {
  get child => null;

  final baseUrl = 'http://fasotravel.pythonanywhere.com/reservations/create/';
  int _nombrePlaces = 0;
  List<String> _typeVoyage = [
    'Aller',
    'Aller-Retour',
  ];

  var _villeDepart;
  var _villeArrivee;

  var _typeVoyages;
  DateTime _dateReservation = DateTime.now();
  var _dateReserve;

  Future<http.Response> createReservation(var villeDepart, var villeArrivee,
      var nombrePlaces, var typeVoyage, var dateReservation) async {
    Map<String, dynamic> reservation = {
      'villeDepart': villeDepart,
      'villeArrive': villeArrivee,
      'nombreDePlace': nombrePlaces,
      'typeVoyage': typeVoyage,
      'dateReservation': dateReservation
    };
    String requestBody = json.encode(reservation);
    final response = await http.post(
      Uri.parse(baseUrl),
      body: requestBody,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: [
        ListTile(
          leading: Icon(Icons.car_rental),
          title: Text('Ville de Depart'),
          subtitle: Text(villD),
        ),
        ListTile(
          leading: Icon(Icons.car_rental),
          title: Text("Ville d'arrivee"),
          subtitle: Text(villA),
        ),
        ListTile(
          leading: Icon(Icons.money_off_csred),
          title: Text('Prix Aller-Simple'),
          subtitle: Text(prixAllerSimple),
        ),
        ListTile(
          leading: Icon(Icons.money_off_csred_outlined),
          title: Text('Prix AllerRetour'),
          subtitle: Text(prixAllerRetour),
        ),
        ListTile(
          leading: Icon(Icons.social_distance_outlined),
          title: Text('Parcour'),
          subtitle: Text(distance),
        ),
        ListTile(
          leading: Icon(Icons.timelapse),
          title: Text('temps du tranget'),
          subtitle: Text(tempsTrajet),
        ),
        ListTile(
          leading: Icon(Icons.time_to_leave),
          title: Text('Heure des depart'),
          subtitle: Text(heuresDepart),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Reservation'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            obscureText: false,
                            cursorColor: kPrimaryColor,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Nombres places",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Icon(Icons.person),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _nombrePlaces =
                                    int.parse(value); // Conversion en entier
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: "Type de voyage",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Icon(Icons.car_rental),
                              ),
                            ),
                            items: _typeVoyage
                                .map<DropdownMenuItem<String>>((String value2) {
                              return DropdownMenuItem<String>(
                                value: value2,
                                child: Text(
                                  value2,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                _typeVoyages = newVal.toString();
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextButton(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: _dateReservation,
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(2100));
                            },
                            child: TextFormField(
                              obscureText: false,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_month),
                                        Text(
                                          "Date :",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 38, 14,
                                                14), // changer la couleur en bleu
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 3),
                                          child: TextButton(
                                            onPressed: () async {
                                              DateTime? newDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          _dateReservation,
                                                      firstDate: DateTime(2023),
                                                      lastDate: DateTime(2100));
                                              if (newDate == null) return;
                                              setState(() {
                                                _dateReservation = newDate;
                                                _dateReserve =
                                                    "${_dateReservation.year}-${_dateReservation.month}-${_dateReservation.day}";
                                              });
                                            },
                                            child: Text(
                                              "${_dateReservation.year}/${_dateReservation.month}/${_dateReservation.day}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255,
                                                    108,
                                                    194,
                                                    237), // changer la couleur en bleu
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'Annuler',
                          style:
                              TextStyle(color: Color.fromARGB(255, 232, 5, 5)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        onPressed: () async {
                          final response = await createReservation(
                              villeDepart,
                              villeArrivee,
                              _nombrePlaces,
                              _typeVoyages,
                              _dateReserve);
                          if (response.statusCode == 201) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Succès"),
                                  content: Text("Réservation avec succès"),
                                  actions: [
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Parcour();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Échec de réservation"),
                                  content: Text(
                                      "Veuillez remplir le formulaire à nouveau. "),
                                  actions: [
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            print(
                                'Erreur lors de la création de la réservation.');
                            print(
                                '${_villeDepart} ${_villeArrivee} ${_nombrePlaces} ${_typeVoyages} ${_dateReserve}');
                          }
                        },
                        child: Text(
                          "RESERVER".toUpperCase(),
                        ),
                      )
                    ],
                  );
                });
          },
          child: Text(
            "RESERVER Ce Voyage".toUpperCase(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
