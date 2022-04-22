import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key, /*required this.orders*/}) : super(key: key);

  // final List<String> orders;
  @override
  Widget build(BuildContext context) {

    return
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              title: const Text("About"),
              automaticallyImplyLeading: true,
              leading: IconButton(icon:const Icon(Icons.arrow_back),
                onPressed:() => Navigator.pop(context, false),
              )

          ),
          // backgroundColor: Colors.black,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 80.0,
                    backgroundImage: AssetImage('images/profile.png'),
                  ),
                  const Text(
                    'Ernesto Louis',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Courgette'),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0,10.0,0,10),
                    child: Text(
                      'Owner',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 150.0,
                    height: 20.0,
                    child: Divider(
                        color: Colors.black
                    ),
                  ),
                  const Card(
                    elevation: 5.0,
                    margin: EdgeInsets.fromLTRB(20.0,10.0,20.0,20.0),
                    child: ListTile(
                      leading: Icon(Icons.article, color: Colors.black),
                      title: Text(
                        'This is a sundae maker',
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.fromLTRB(20.0,10.0,20.0,20.0) /*EdgeInsets.symmetric(vertical: 0, horizontal: 20.0)*/,
                    child:   TextButton (
                      child:  const Text('el938@mynsu.nova.edu'),
                      onPressed: () {
                        _sendingMails();
                      },
                    ),/* ListTile(
                      leading: Icon(Icons.email_rounded, color: Colors.black),
                      onTap: _sendingMails(),
                      title: Text(
                        'el938@mynsu.nova.edu',
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    ),*/
                  )
                ],
              ),
            ),
          ),
        ),
      );

  }


  _sendingMails() async {
    const url = 'mailto:el938@mynsu.nova.edu';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
