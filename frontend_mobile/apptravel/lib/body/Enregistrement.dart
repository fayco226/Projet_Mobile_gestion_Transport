import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apptravel/body/home.dart';

import 'package:apptravel/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Enregistrement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [enregist()],
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
        "S'INSCRIRE",
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
  @override
  void initSate() {
    super.initState();
  }

  var _id = 3;
  var _nom;
  var _prenom;
  var _addresse;
  var _email;
  var _phone;
  var _cnib;
  var baseUrl = 'http://fasotravel.pythonanywhere.com/client/enregistrement/';

  Future<http.Response> enregistrer(
    var id,
    var nom,
    var prenom,
    var addresse,
    var email,
    var phone,
    var cnib,
  ) async {
    Map<String, dynamic> reservation = {
      'id': id,
      'nom': nom,
      'prenonom': prenom,
      'addresse': addresse,
      'email': email,
      'telephone': phone,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Nom",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _nom = value;
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
                hintText: "Prenom",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _prenom = value;
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
                hintText: "Addresse",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _addresse = value;
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
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
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
                  child: Icon(Icons.person),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _phone = value;
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
                  child: Icon(Icons.person),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _nom = value;
                });
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () async {
              final response = await enregistrer(
                  _id, _nom, _prenom, _addresse, _email, _phone, _cnib);
              if (response.statusCode == 201) {
                print('Réservation créée avec succès.');
              } else {
                print('Erreur lors de la création de la réservation.');
                print('${_nom} ${_prenom} ${_addresse} ${_email} ${_phone}');
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomePage();
                  },
                ),
              );
            },
            child: Text(
              "S'incrire".toUpperCase(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
