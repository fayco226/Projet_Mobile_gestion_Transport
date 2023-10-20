import 'package:apptravel/Screens/Login/components/login_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import 'dart:convert';
import 'package:apptravel/database/database.dart';

class SignUpForm extends StatefulWidget {
  @override
  _signup createState() => _signup();
}

class _signup extends State<SignUpForm> {
  @override
  void initSate() {
    super.initState();
  }

  var _nom;
  var _prenom;
  var _addresse;
  var _nomUtisateur;
  var _email;
  var _phone;
  var _cnib;
  var _motDePass;
  var baseUrl = 'http://fasotravel.pythonanywhere.com/client/enregistrement/';

  Future<http.Response> enregistrer(
    var nom,
    var prenom,
    var addresse,
    var nomUtisateur,
    var email,
    var phone,
    var cnib,
    var motDePass,
  ) async {
    Map<String, dynamic> reservation = {
      'nom': nom,
      'prenom': prenom,
      'addresse': addresse,
      'nomUtisateur': nomUtisateur,
      'email': email,
      'telephone': phone,
      'cnib': cnib,
      'motDePass': motDePass
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
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Votre nom",
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
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Votre Prenom",
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
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
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
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Nom d'utilisation",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _nomUtisateur = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Email",
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
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Numero Telephone",
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
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Numero CNIB ou Autre",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _cnib = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Mot de Passe",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _motDePass = value;
                });
              },
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              final response = await enregistrer(_nom, _prenom, _addresse,
                  _nomUtisateur, _email, _phone, _cnib, _motDePass);

              if (response.statusCode == 201) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Succès"),
                      content: Text("Utilisateur enregister avec succès"),
                      actions: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginForm();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
                profileEnregistrement(_nom, _prenom, _addresse, _nomUtisateur,
                    _email, _phone, _cnib, _motDePass);
                print('Utilisation créée avec succès.');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      icon: Icon(
                        Icons.error_outline,
                        size: 20,
                      ),
                      title: Text("Échec de creation de l'utilisateur"),
                      content:
                          Text("Veuillez remplir le formulaire à nouveau ."),
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
                print('${_nom} ${_prenom} ${_addresse} ${_email} ${_phone}');
              }
            },
            child: Text("S'incrire".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
