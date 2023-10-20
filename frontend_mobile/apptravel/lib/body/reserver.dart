import 'dart:convert';
import 'package:apptravel/api/ville.dart';
import 'package:apptravel/body/home.dart';
import 'package:apptravel/body/pages.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apptravel/body/bouton.dart';
import '../components/already_have_an_account_acheck.dart';
import 'package:http/http.dart' as http;

class Reserver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Search(),
            formule(),
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Pages();
              },
            ),
          );
        },
      ),
      title: Text(
        'Reservation',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reserver une Place ",
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}

class formule extends StatefulWidget {
  @override
  _formule createState() => _formule();
}

class _formule extends State<formule> {
  List<Ville> _ville = [];
  List<String> _nomVilles = [];
  List<String> _nomVille = [];
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

  @override
  void initState() {
    super.initState();
    fetchVille();
  }

  Future<void> fetchVille() async {
    final response = await http
        .get(Uri.parse('http://fasotravel.pythonanywhere.com/api/ville/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _ville = data.map((json) => Ville.fromJson(json)).toList();
        _nomVilles = _ville.map((ville) => ville.nom).toList();
        _nomVille.addAll(_nomVilles);
      });
    } else {
      throw Exception('Failed to load ville');
    }
  }

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
    Size size = MediaQuery.of(context).size;
    String dropdownValue = 'OUAGADOUGOU';
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                hintText: "Ville de depart",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.car_rental),
                ),
              ),
              items: _nomVilles.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
              onChanged: (selectedValue) {
                setState(() {
                  // Remove the selected value from the _nomVille list
                  _nomVille.remove(selectedValue);
                  _villeDepart = selectedValue.toString();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                hintText: "Ville D'arrivee",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.car_rental),
                ),
              ),
              items: _nomVille.map<DropdownMenuItem<String>>((String value1) {
                return DropdownMenuItem<String>(
                  value: value1,
                  child: Text(
                    value1,
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _villeArrivee = newVal.toString();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  _nombrePlaces = int.parse(value); // Conversion en entier
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                hintText: "Type de voyage",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.car_rental),
                ),
              ),
              items: _typeVoyage.map<DropdownMenuItem<String>>((String value2) {
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month),
                          Text(
                            "Date de Reservation :",
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
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: _dateReservation,
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
                                  color: Colors
                                      .redAccent, // changer la couleur en bleu
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
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () async {
              final response = await createReservation(_villeDepart,
                  _villeArrivee, _nombrePlaces, _typeVoyages, _dateReserve);
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
                                  return HomePage();
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
                      content:
                          Text("Veuillez remplir le formulaire à nouveau. "),
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
                print('Erreur lors de la création de la réservation.');
                print(
                    '${_villeDepart} ${_villeArrivee} ${_nombrePlaces} ${_typeVoyages} ${_dateReserve}');
              }
            },
            child: Text(
              "RESERVER".toUpperCase(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
