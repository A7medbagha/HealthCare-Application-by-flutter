import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syaahhospitalsystem/Screens/Models/user.dart';
import 'package:syaahhospitalsystem/Screens/login_screen.dart';
import 'package:syaahhospitalsystem/Screens/surveyPage.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  final firstnameEditingcontroller = new TextEditingController();
  final secondnameEditingcontroller = new TextEditingController();
  final lastnameEditingcontroller = new TextEditingController();
  final emailEditingcontroller = new TextEditingController();
  final phoneNumberEditingcontroller = new TextEditingController();
  final ageEditingcontroller = new TextEditingController();
  final addressEditingcontroller = new TextEditingController();
  final passwordEditingcontroller = new TextEditingController();
  final confirmPasswordEditingcontroller = new TextEditingController();
  String selectedGender = "";

  @override
  Widget build(BuildContext context) {

    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstnameEditingcontroller,
      style: TextStyle(fontWeight: FontWeight.bold),
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("First Name can't be empty");
        }
        return null;
      },
      onSaved: (value) {
        firstnameEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
          labelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(color: Colors.black, Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondnameEditingcontroller,
      style: TextStyle(fontWeight: FontWeight.bold),
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Second Name can't be empty");
        }
        return null;
      },
      onSaved: (value) {
        firstnameEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(color: Colors.black, Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );


    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastnameEditingcontroller,
      style: TextStyle(fontWeight: FontWeight.bold),
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Last Name can't be empty");
        }
        return null;
      },
      onSaved: (value) {
        lastnameEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(color: Colors.black, Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final phonenumber = TextFormField(
      autofocus: false,
      controller: phoneNumberEditingcontroller,
      style: TextStyle(fontWeight: FontWeight.bold),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Phone Number can't be empty");
        }
        return null;
      },
      onSaved: (value) {
        lastnameEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(color: Colors.black, Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );


    TextFormField age = TextFormField(
      autofocus: false,
      controller: ageEditingcontroller,
      style: TextStyle(fontWeight: FontWeight.bold),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Birthday can't be empty");
        }
        return null;
      },
      onSaved: (value) {
        ageEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: IconButton(
          icon: Icon(Icons.date_range, color: Colors.black),
          onPressed: _openDatePicker,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Birthdate D/M/Y",
        hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );


    @override
    void dispose() {
      ageEditingcontroller.dispose();
      super.dispose();
    }



    final gender = TextFormField(
      readOnly: true,
      onTap: _openGenderPicker,
      controller: TextEditingController(text: selectedGender),
      style: TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.person, color: Colors.black),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Gender",
        hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );


    final adress = TextFormField(
      autofocus: false,
      controller: addressEditingcontroller,
      style: TextStyle(fontWeight: FontWeight.bold),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Address can't be empty");
        }
        return null;
      },
      onSaved: (value) {
        addressEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(color: Colors.black, Icons.location_city),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Address",
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );


    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingcontroller,
      style: TextStyle(fontWeight: FontWeight.bold),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(color: Colors.black, Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );


    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingcontroller,
      style: TextStyle(fontWeight: FontWeight.bold),
      obscureText: true,

      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter your password");
        }
        if (!regex.hasMatch(value)) {
          return ("Password must be at least 6 characters long.");
        }

        return null;
      },
      onSaved: (value) {
        passwordEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(color: Colors.black, Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );



    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingcontroller,
      style: TextStyle(fontWeight: FontWeight.bold),
      obscureText: true,

      validator: (value) {
        if (confirmPasswordEditingcontroller.text.length > 6 &&
            passwordEditingcontroller.text != value) {
          return "Passwords don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,

      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(color: Colors.black, Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final SignupButton = Material(
      color: Color(0xffc08806),
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingcontroller.text, passwordEditingcontroller.text);
        },
        child: Text(
          "Sign Up",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffc08806),
          automaticallyImplyLeading: false,
          title: Text(
            "Sign Up Page",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          )),
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/back.jpg'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
            child: Container(
          color: Colors.white.withOpacity(0),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 18,
                    ),
                    firstNameField,
                    SizedBox(
                      height: 15,
                    ),
                    secondNameField,
                    SizedBox(
                      height: 15,
                    ),
                    lastNameField,
                    SizedBox(
                      height: 15,
                    ),
                    phonenumber,
                    SizedBox(
                      height: 15,
                    ),
                    age,
                    SizedBox(
                      height: 15,
                    ),
                    gender,
                    SizedBox(
                      height: 15,
                    ),
                    adress,
                    SizedBox(
                      height: 15,
                    ),
                    emailField,
                    SizedBox(
                      height: 15,
                    ),
                    passwordField,
                    SizedBox(
                      height: 15,
                    ),
                    confirmPasswordField,
                    SizedBox(
                      height: 25,
                    ),
                    SignupButton,
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "If you have account. ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text('Sign In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ],
                )),
          ),
        )),
      ),
    );
  }

  DateTime? selectedDate;
  void _openDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        ageEditingcontroller.text =
            DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }

  void _openGenderPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Gender"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Male"),
                onTap: () {
                  setState(() {
                    selectedGender = "Male";
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Female"),
                onTap: () {
                  setState(() {
                    selectedGender = "Female";
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();


    userModel.uid = user!.uid;
    userModel.email = user.email;
    userModel.firstName = firstnameEditingcontroller.text;
    userModel.secondName = secondnameEditingcontroller.text;
    userModel.lastName = lastnameEditingcontroller.text;
    userModel.phoneNumber = phoneNumberEditingcontroller.text;
    userModel.birthDate = ageEditingcontroller.text;
    userModel.address = addressEditingcontroller.text;
    userModel.gender = selectedGender;

    await firebaseFirestore
        .collection("MobileApp_Users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Created Successfully");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => QuizPage()), (route) => false);
  }
}
