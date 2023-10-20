

class Voyage {
  final String villeDepart;
  final String villeArrivee;
  final String heureDepart;
  final int prix;

  Voyage(
      {required this.villeDepart,
      required this.villeArrivee,
      required this.heureDepart,
      required this.prix});

  factory Voyage.fromJson(Map<String, dynamic> json) {
    return Voyage(
      villeDepart: json['ville_depart'],
      villeArrivee: json['ville_arrive'],
      heureDepart: json['heure_depart'],
      prix: json['prix'],
    );
  }
}

