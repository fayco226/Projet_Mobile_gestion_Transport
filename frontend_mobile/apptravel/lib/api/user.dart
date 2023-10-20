class Profile {
  final String nom;
  final String prenom;
  final String addresse;
  final String nomUtisateur;
  final String email;
  final String telephone;
  final int cnib;

  Profile(
      {required this.nom,
      required this.prenom,
      required this.addresse,
      required this.nomUtisateur,
      required this.email,
      required this.cnib,
      required this.telephone});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      nom: json['nom'],
      prenom: json['prenom'],
      addresse: json['addresse'],
      nomUtisateur: json['nomUtisateur'],
      email: json['email'],
      cnib: json['cnib'],
      telephone: json['telephone'],
    );
  }
}
