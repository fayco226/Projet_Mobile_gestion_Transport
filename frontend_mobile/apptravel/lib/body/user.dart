import 'dart:convert';
import 'dart:io';
import 'package:apptravel/body/home.dart';
import 'package:apptravel/database/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apptravel/api/user.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class InfosUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [const Search(), infosuser()],
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
        'Mon Profil',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 205, 163, 151),
    );
  }
}

var _image;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Choisr dans la galery'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _imgFromGallery() async {
    final pickedFile =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future<void> _imgFromCamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

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
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          _image != null ? FileImage(_image) : null,
                      child: _image == null ? Icon(Icons.person) : null,
                      
                    ),
                    InkWell(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Icon(Icons.person),
                    ),
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

class infosuser extends StatefulWidget {
  @override
  _infosuser createState() => _infosuser();
}

class _infosuser extends State<infosuser> {
  @override
  void initSate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          return ListBody(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('${user['nom']}'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('${user['prenom']}'),
              ),
              ListTile(
                leading: Icon(Icons.place),
                title: Text('${user['email']}'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('${user['nomUtisateur']}'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('${user['telephone']}'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('${user['addresse']}'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('B-${user['cnib']}'),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
