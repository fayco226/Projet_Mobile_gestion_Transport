import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Recherche extends StatefulWidget {
  const Recherche({Key? key}) : super(key: key);

  @override
  State<Recherche> createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  late Future<List> voyages;
  final VoyageListKey = GlobalKey<_RechercheState>();

  @override
  void initState() {
    super.initState();
    voyages = getData();
  }

  Future<List> getData() async {
    var url = 'http://localhost/apiMobile/affiche_voyage.php';
    final reponse = await http.get(Uri.parse(url));
    var datarec = json.decode(reponse.body);

    return datarec;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: VoyageListKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF001133),
        title: Text('Liste des Voyages '),
      ),
      body: Center(
        child: FutureBuilder<List>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // By default, show a loading spinner.
              if (!snapshot.hasData) return CircularProgressIndicator();
              // Render Voyage lists
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data[index];
                    return Container(
                      margin: EdgeInsets.all(10),
                      height: 230,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 4,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                              image: DecorationImage(
                                image: AssetImage(('hotel_1.png')),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 5,
                                  right: -15,
                                  child: MaterialButton(
                                    color: Colors.white,
                                    shape: CircleBorder(),
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.favorite_outline_rounded,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['depart_lieu'] +
                                      " ------ > " +
                                      data['arrive_lieu'],
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  data['cout'].toString() + '\cfa',
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Voyage N°' + data['id'].toString(),
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.place,
                                      size: 14.0,
                                    ),
                                    Text(
                                      'Distance ' +
                                          data['distance'].toString() +
                                          ' km',
                                      style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Depart prévu ' +
                                      data['heur_depart'] +
                                      '    '
                                          'Arrivé prévu  ' +
                                      data['heur_arriv'],
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 3, 10, 0),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rate,
                                      size: 14.0,
                                    ),
                                    Icon(
                                      Icons.star_rate,
                                      size: 14.0,
                                    ),
                                    Icon(
                                      Icons.star_rate,
                                      size: 14.0,
                                    ),
                                    Icon(
                                      Icons.star_rate,
                                      size: 14.0,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      size: 14.0,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Text(
                                  data['nbr_place'].toString() +
                                      'passagers attendu',
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
