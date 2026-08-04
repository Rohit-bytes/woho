class UserPostModel {
  final List<User> results;
  final Info info;

  UserPostModel({required this.results, required this.info});

  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    return UserPostModel(
      results: (json['results'] as List).map((e) => User.fromJson(e)).toList(),
      info: Info.fromJson(json['info']),
    );
  }
}

class User {
  final String gender;
  final Name name;
  final String email;
  final String phone;
  final String cell;
  final Picture picture;
  final Dob dob;
  final String uuid; // Added

  User({
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.cell,
    required this.picture,
    required this.dob,
    required this.uuid,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      gender: json['gender'],
      name: Name.fromJson(json['name']),
      email: json['email'],
      phone: json['phone'],
      cell: json['cell'],
      picture: Picture.fromJson(json['picture']),
      dob: Dob.fromJson(json['dob']),
      uuid: json['login']['uuid'], // Added
    );
  }
}

class Name {
  final String title;
  final String first;
  final String last;

  Name({required this.title, required this.first, required this.last});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(title: json['title'], first: json['first'], last: json['last']);
  }
}

class Picture {
  final String large;
  final String medium;
  final String thumbnail;

  Picture({required this.large, required this.medium, required this.thumbnail});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}

class Dob {
  final String date;
  final int age;

  Dob({required this.date, required this.age});

  factory Dob.fromJson(Map<String, dynamic> json) {
    return Dob(date: json['date'], age: json['age']);
  }
}

class Info {
  final String seed;
  final int results;
  final int page;
  final String version;

  Info({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      seed: json['seed'],
      results: json['results'],
      page: json['page'],
      version: json['version'],
    );
  }
}
