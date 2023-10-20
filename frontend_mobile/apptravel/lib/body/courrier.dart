import 'package:apptravel/body/bouton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apptravel/body/home.dart';
import 'package:apptravel/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:apptravel/database/database.dart';
import 'package:apptravel/database/database.dart';

class Courrier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            enregist(),
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
                return HomePage();
              },
            ),
          );
        },
      ),
      title: Text(
        "SERVICE COURRIER",
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

class enregist extends StatefulWidget {
  @override
  _enregist createState() => _enregist();
}

class _enregist extends State<enregist> {
  var user;

  @override
  void initSate() {
    super.initState();
    setState(() {
      getExpediteur();
    });

    print(user);
  }

  Future<String> getExpediteur() async {
    final users = await getUser();
    print(users);
    String nom = users['nom'];
    String prenom = users['prenom'];
    return '$nom $prenom';
  }

  var _nomEtPrenomDeExpediteur;
  var _nomEtPrenomDuDestinatair;
  var _objetAEnvoyer;
  var _prixDeLobjet;
  var _telephone;
  var _cnib;
  var baseUrl = 'http://fasotravel.pythonanywhere.com/api/courier/';

  Future<http.Response> enregistrer(
    var nomEtPrenomDeExpediteur,
    var nomEtPrenomDuDestinatair,
    var objetAEnvoyer,
    var prixDeLobjet,
    var telephone,
    var cnib,
  ) async {
    Map<String, dynamic> reservation = {
      'nomEtPrenomDeExpediteur': nomEtPrenomDeExpediteur,
      'nomEtPrenomDuDestinatair': nomEtPrenomDuDestinatair,
      'objetAEnvoyer': objetAEnvoyer,
      'prixDeLobjet': prixDeLobjet,
      'telephone': telephone,
      'cnib': cnib
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
    return Form(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Nom du Destinataire",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _nomEtPrenomDuDestinatair = value;
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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "object a envoyer",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.shopping_cart),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _objetAEnvoyer = value;
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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Prix de l'object",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.money),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _prixDeLobjet = value;
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
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Telephone",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _telephone = value;
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
                hintText: "CNIB",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.perm_identity),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _cnib = value;
                });
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () async {
              _nomEtPrenomDeExpediteur = await getExpediteur();
              final response = await enregistrer(
                  _nomEtPrenomDeExpediteur,
                  _nomEtPrenomDuDestinatair,
                  _objetAEnvoyer,
                  _prixDeLobjet,
                  _telephone,
                  _cnib);

              if (response.statusCode == 201) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Succès infos courrier"),
                      content: Text("Infos Courrier envoyer avec succès"),
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
                print('courrir créée avec succès.');
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Échec d'envoie de infos courrier"),
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
                print(user);
                print('Erreur lors de la création du courrier.');
              }
            },
            child: Text(
              "Envoyer".toUpperCase(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
