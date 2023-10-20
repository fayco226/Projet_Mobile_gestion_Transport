class Ville {
  final String nom;
  Ville({required this.nom});
  factory Ville.fromJson(Map<String, dynamic> json){
    return Ville(
    nom: json['nom'],
    );
  }
}
