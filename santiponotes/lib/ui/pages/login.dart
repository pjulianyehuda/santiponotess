part of 'pages.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final _formKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  // final AuthServices auth = AuthServices();

  bool isVisible = true;
  bool isLoading = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/planner_icon.png",
                        height: 70,
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: ctrlEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          email = value;
                          if (value.isEmpty) {
                            return "Please fill the field!";
                          } else {
                            if (!EmailValidator.validate(value)) {
                              return "Email isn't valid!";
                            } else {
                              return null;
                            }
                          }
                        },
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: ctrlPass,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.vpn_key),
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
                            )),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          password = value;
                          return value.length < 6
                              ? "Password must have at least 6 characters!"
                              : null;
                        },
                      ),
                      SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () async {
                          print(email + password);
                          if (_formKey.currentState.validate()) {
                            //melanjutkan ke tahap berikutnya
                            setState(() {
                              isLoading = true;
                            });
                            await AuthServices.signIn(email, password).then((value) {
                              if (value == "success") {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast("Login success", Colors.greenAccent);
                                Navigator.pushReplacementNamed(context, MainMenu.routeName);
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast(
                                    value, Colors.redAccent);
                              }
                            });
                            //melanjutkan ke tahap berikutnya
                            // Navigator.pushReplacementNamed(
                            // context, MainMenu.routeName);

                          } else {
                            Fluttertoast.showToast(
                            msg: "Please check the field",
                            backgroundColor: Colors.red,
                            textColor: Colors.white);
                          }
                        },
                        icon: Icon(Icons.login_rounded),
                        label: Text("Login"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange[400],
                          elevation: 0,
                        ),
                      ),
                      SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Register.routeName);
                        },
                        child: Text(
                          "Not Registered yet? Join Now.",
                          style: TextStyle(
                            color: Colors.deepOrange[400],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }
}
