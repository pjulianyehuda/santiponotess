part of 'pages.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
  static const String routeName = "/register";
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlPass = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        elevation: 0,
      ),

      resizeToAvoidBottomInset: false, //buat bikin tampilan gapapa pas keyboard keluar

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.all(24),
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        Image.asset(
                          "assets/images/planner_icon.png",
                          height: 100,
                        ),

                        SizedBox(height: 26),
                        TextFormField(
                          controller: ctrlName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value){
                            if(value.isEmpty){
                              return "Please fill all field!";
                            }else{
                              if(!EmailValidator.validate(value)){
                                return null;
                              }else{
                                return null;
                              }

                            }
                          },
                        ),

                        SizedBox(height: 32), //spacing antar form box

                        TextFormField(
                          controller: ctrlEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.mail),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value){
                            if(value.isEmpty){
                              return "Please fill all field!";
                            }else{
                              if(!EmailValidator.validate(value)){
                                return "Email is not valid!";
                              }else{
                                return null;
                              }

                            }
                          },
                        ),

                        SizedBox(height: 32),

                        TextFormField(
                          controller: ctrlPass,
                          obscureText: isVisible,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.vpn_key),
                            border: OutlineInputBorder(),
                            suffixIcon: new GestureDetector(
                              onTap: (){
                                setState(() {
                                  isVisible = !isVisible; //tulisan gini supaya isa balik" visibilitynya
                                });
                              },
                              child: Icon(
                                isVisible ?
                                Icons.visibility : Icons.visibility_off //biar icon isa ganti" pas dipencet nanti
                              ),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value){
                            return value.length < 6 ?
                            "Password must have 6 or more characters!" : null;
                          },
                        ),

                        SizedBox(height: 32),

                        TextFormField(
                          controller: ctrlPhone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value){
                            if(value.isEmpty){
                              return "Please fill all field!";
                            }else{
                              if(value.length < 7 || value.length > 14){
                                return "Phone number is not valid!";
                              }else{
                                return null;
                              }
                            }
                          },
                        ),

                        SizedBox(height: 32),

                        ElevatedButton.icon(
                          onPressed: () async{
                            if(_formKey.currentState.validate()){
                              setState(() {
                                isLoading = true;
                              });
                              Users users = new Users("", ctrlName.text, ctrlEmail.text, ctrlPass.text, ctrlPhone.text, "", "");
                              await AuthServices.signUp(users).then((value){
                                if(value == "success"){
                                setState(() {
                                  isLoading = false;
                                });
                                  ActivityServices.showToast("register success", Colors.green);
                                  Navigator.pushReplacementNamed(context, Login.routeName);
                                }else{
                                  ActivityServices.showToast(value, Colors.red);
                                }
                              });

                              //lanjut ke page berikut
                            }else{
                              //kosongkan aja
                              Fluttertoast.showToast(msg: "Please check all fields!",backgroundColor: Colors.red, toastLength: Toast.LENGTH_SHORT);
                            }
                          },
                          icon: Icon(Icons.save),
                          label: Text("Register"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange[400],
                            elevation: 4,
                          ),
                        ),
                        SizedBox(height: 24),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, Login.routeName);
                          },
                          child: Text(
                            "Already registered? Login here!",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 16,
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),

            isLoading == true ? ActivityServices.loadings()
            : Container()
          ],
        ),
      ),
    );
  }
}