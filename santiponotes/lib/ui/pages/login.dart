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
  bool isVisible = true;
  String email = '';
  bool isLoading = false;
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                Image.asset("assets/images/"),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                            return "Still Empty!";
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
                            setState(() {
                              isLoading = true;
                            });
                            await AuthServices.signIn(ctrlEmail.text , ctrlPass.text).then((value) {
                              if (value == "success") {
                                setState(() {
                                  isLoading = false;
                                });
                                AcitivityServices.showToast("Login success", Colors.blueGrey);
                                Navigator.pushReplacementNamed(context, MainMenu.routeName);
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                AcitivityServices.showToast(
                                    value, Colors.redAccent);
                              }
                            });
                            Navigator.pushReplacementNamed(
                            context, MainMenu.routeName);

                          } else {
                            Fluttertoast.showToast(
                            msg: "Please check the field",
                            backgroundColor: Colors.red,
                            textColor: Colors.white);
                          }
                        },
                          icon: Icon(Icons.login_outlined),
                          label: Text("Login"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            elevation: 10,
                          )),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: "Link Clicked");
                          Navigator.pushReplacementNamed(
                              context, Register.routeName);
                        },
                        child: Text(
                          "Not Registered?",
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
