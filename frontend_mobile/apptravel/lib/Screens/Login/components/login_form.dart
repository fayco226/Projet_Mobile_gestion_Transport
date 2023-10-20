import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../body/home.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  Future<http.Response> verifeLog(
    var nomUtisateur,
    var motDePass,
  ) async {
    Map<String, dynamic> reservation = {
      'nomUtisateur': nomUtisateur,
      'motDePass': motDePass
    };
    var baseUrl = 'http://fasotravel.pythonanywhere.com/api/VerifeLogin';
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
    TextEditingController userName = TextEditingController();
    TextEditingController mdp = TextEditingController();

    return Form(
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.done,
            obscureText: false,
            cursorColor: kPrimaryColor,
            controller: userName,
            decoration: InputDecoration(
              hintText: "Nom d'utilisation",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              controller: mdp,
              decoration: InputDecoration(
                hintText: "Mot de passe",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                final response = await verifeLog(userName.text, mdp.text);
                if (response.statusCode == 201) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Succès"),
                        content: Text("Connexion avec succès"),
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
                        icon: Icon(
                          Icons.error_outline,
                          size: 20,
                        ),
                        title: Text("Échec de Connexion"),
                        content: Text(
                            "Nom d'utilisateur ou mot de passe incorrect ."),
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
                  print(userName.text);
                  print(mdp.text);
                  print('error');
                }
              },
              child: Text(
                "Se Connecter".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
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
