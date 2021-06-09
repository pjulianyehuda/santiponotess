part of 'pages.dart';

class MainMenu extends StatefulWidget {
  static const String routeName = "/mainmenu";
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

   bool isLoading = false;
  String msg = "Fail";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Menu"),
      ),
      body: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await AuthServices.signOut().then((value) {
                      if (value) {
                        setState(() {
                          isLoading = false;
                        });
                        AcitivityServices.showToast(
                            "Logout success", Colors.greenAccent);
                        Navigator.pushReplacementNamed(
                            context, Login.routeName);
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        AcitivityServices.showToast(msg, Colors.redAccent);
                      }
                    });
                  },
                  icon: Icon(Icons.logout),
                  label: Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange[400],
                    elevation: 0,
                  )),
            ),
            isLoading == true ? AcitivityServices.loadings() : Container()
          ],
        )
    );
  }
}
