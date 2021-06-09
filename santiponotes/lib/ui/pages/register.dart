part of 'pages.dart';

class Register extends StatefulWidget {
  static const String routeName = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlName = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlPass = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(40),
        child: Stack(
          children: [
            ListView(
              children: [
                Image.asset("assets/images/3346770-200.png"),
                SizedBox(height: 0),
                TextFormField(
                    controller: ctrlName,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Name :",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Still Empty!";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(height: 24),
                TextFormField(
                    controller: ctrlPhone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Phone :",
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Still Empty!";
                      } else {
                        if (value.length < 7 || value.length > 14) {
                          return "Phone number isn't valid!";
                        } else {
                          return null;
                        }
                      }
                    }),
                SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: ctrlEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email :",
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Still Empty!";
                            } else {
                              if (!EmailValidator.validate(value)) {
                                return "Email Isn't Valid!";
                              } else {
                                return null;
                              }
                            }
                          }),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: ctrlPass,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.vpn_key_outlined),
                          border: OutlineInputBorder(),
                          suffixIcon: new GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            child: Icon(isVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value.length < 6
                              ? "Password must have at least 6 Character!"
                              : null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                          onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Users users = new Users(
                              "",
                              ctrlName.text,
                              ctrlPhone.text,
                              ctrlEmail.text,
                              ctrlPass.text,
                              "",
                              "");
                          String msg = await AuthServices.signUp(users);
                          if (msg == "success") {
                            AcitivityServices.showToast(
                                "Register Success", Colors.grey);
                          }                     
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  "Please Check Email and Passowrd Correctly!");
                        }
                      },
                          icon: Icon(Icons.save),
                          label: Text("Register"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            elevation: 10,
                          )),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Login.routeName);
                        },
                        child: Text(
                          "Already Registered? Login now.",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
