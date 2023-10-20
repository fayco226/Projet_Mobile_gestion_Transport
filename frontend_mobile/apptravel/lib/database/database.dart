import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

Future<void> profileEnregistrement(var nom, var prenom, var addresse,
    var nomUtisateur, var email, var telephone, var cnib, var motDePass) async {
  // Initialize the database factory
  databaseFactory = databaseFactoryFfi;
  final directory = await getApplicationDocumentsDirectory();
  final dbPath = join(directory.path, 'my_database.db');
  var db = await openDatabase(dbPath);
  db.execute(
      'CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY, nom TEXT, prenom TEXT, addresse TEXT, nomUtisateur TEXT, email TEXT, telephone TEXT, cnib TEXT, motDePass TEXT)');

  

  final List<Map<String, dynamic>> existe =
      await db.query('user', where: 'id=?', whereArgs: [1]);

  if (existe.isNotEmpty) {
    await db.delete('user', where: 'id=?', whereArgs: [1]);
  }
  await db.insert(
    'user',
    {
      'id': 1,
      'nom': nom,
      'prenom': prenom,
      'addresse': addresse,
      'nomUtisateur': nomUtisateur,
      'email': email,
      'telephone': telephone,
      'cnib': cnib,
      'motDePass': motDePass
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  db.close();

  // Retrieve the record from the database.
}

Future<Map<String, dynamic>> getUser() async {
// Initialize the database factory
  databaseFactory = databaseFactoryFfi;
  final directory = await getApplicationDocumentsDirectory();
  final dbPath = join(directory.path, 'my_database.db');
  print(dbPath);
  final db = await openDatabase(dbPath);
  try {
    final user = await db.query('user', where: 'id = ?', whereArgs: [1]);
    db.close();
    if (user.isNotEmpty) {
      return user.first;
    } else {
      return {};
    }
  } catch (e) {
    print('non');
  }

  return {};
}

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

Future<bool> connection() async {
  final user = await getUser();
  bool re;
  if (user.isNotEmpty) {
    String a = user['nomUtisateur'];
    String b = user['motDePass'];
    print('Nom utilisateur: $a, Mot de passe: $b');

    final respons = await verifeLog(a, b);
    if (respons.statusCode == 201) {
      re = true;
      return re;
    } else {
      re = false;
      return re;
    }
  }

  return false;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  final dbPath = join(directory.path, 'my_database.db');
  print('Chemin absolu de la base de données: $dbPath');

  // TODO: Ouvrir le fichier my_database.db à partir du chemin
}
