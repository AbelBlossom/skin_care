List<Map<String, String>> _deseases = [
  {
    "img": "./assets/deseases/blister.jpg",
    "name": "Blister",
  },
  {
    "img": "./assets/deseases/candidiasis.jpg",
    "name": "Candidiasis",
  },
  {
    "img": "./assets/deseases/chicken-pox-on-young-boy.jpg",
    "name": "ChickenPox",
  },
  {
    "img": "./assets/deseases/eczema-on-hand.jpg",
    "name": "Eczema",
  },
  {
    "img": "./assets/deseases/fifth-disease-child-rash.jpg",
    "name": "Fifth Disease Child",
  },
  {
    "img": "./assets/deseases/hives-from-hay-fever.jpg",
    "name": "Hive",
  },
  {
    "img": "./assets/deseases/measles-on-infant.jpg",
    "name": "Measles",
  },
  {
    "img": "./assets/deseases/ringworm-rash.jpg",
    "name": "Ringworm",
  },
  {
    "img": "./assets/deseases/scabies-rash.jpg",
    "name": "Scabies",
  },
  {
    "img": "./assets/deseases/scarlet-fever-face.jpg",
    "name": "Scarlet",
  },
  {
    "img": "./assets/deseases/shingles-rash.jpg",
    "name": "Shingles",
  },
  {
    "img": "./assets/deseases/syphilis.jpg",
    "name": "Syphilis",
  }
];

class Desease {
  String image;
  String name;

  Desease({this.image, this.name});

  factory Desease.fromMap(Map<String, String> map) {
    return Desease(image: map["img"], name: map["name"]);
  }

  static List<Desease> get all {
    return _deseases.map((e) => Desease.fromMap(e)).toList();
  }
}
