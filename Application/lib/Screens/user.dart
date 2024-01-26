class UserModel {
  String? uid;
  String? firstName;
  String? secondName;
  String? lastName;
  String? phoneNumber;
  String? birthDate;
  String? address;
  String? email;
  String? gender;

  UserModel({
    this.uid,
    this.firstName,
    this.secondName,
    this.lastName,
    this.phoneNumber,
    this.birthDate,
    this.address,
    this.email,
    this.gender,
  });


  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      birthDate: map['birthDate'],
      address: map['address'],
      email: map['email'],
      gender: map['gender'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'secondName': secondName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
      'address': address,
      'email': email,
      'gender': gender,
    };
  }
}
