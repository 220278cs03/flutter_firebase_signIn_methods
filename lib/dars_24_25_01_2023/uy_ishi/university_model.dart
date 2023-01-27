import 'package:cloud_firestore/cloud_firestore.dart';

class UniversityModel {
  final String name;
  final String country;
  final String website;
  final String image;
  final String logo;
  final num fee;
  final num rank;
  final String location;
  final String phone;

  UniversityModel(
      {required this.name,
      required this.country,
      required this.website,
      required this.image,
      required this.logo,
      required this.fee,
      required this.rank,
      required this.location,
      required this.phone});

  factory UniversityModel.fromJson(QueryDocumentSnapshot data) {
    return UniversityModel(
        name: data['name'],
        country: data['country'],
        website: data['website'],
        image: data['image'],
        logo: data['logo'],
        fee: data['fee'],
        rank: data['rank'],
      phone: data['phone'],
      location: data['location']
    );
  }

  toJson() {
    return {
      "name": name,
      "website": website,
      "country": country,
      "image": image,
      "logo": logo,
      "fee": fee,
      "rank": rank,
      "phone" : phone,
      "location" : location
    };
  }
}
