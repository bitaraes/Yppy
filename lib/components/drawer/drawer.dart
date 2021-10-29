import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api.dart';

void main() => runApp(MyDrawer());

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Ocorreu um erro");
        }

        if (snapshot.hasData) {
          return ListView(
            children: [
              // ignore: missing_required_param
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF752c98),
                ),
                accountName: Text(snapshot.data[0].replaceFirst(
                    snapshot.data[0][0], snapshot.data[0][0].toUpperCase())),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    snapshot.data[0][0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                subtitle: Text("Ir para Home"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print('Voltar para o Inicio.');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text("Perfil"),
                subtitle: Text("Siga para ver o seu perfil."),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print('Ir para postagens.');
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                subtitle: Text("Faça Logout"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  logout();
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
            ],
          );
        }
        return CircularProgressIndicator(
          backgroundColor: Colors.blue,
        );
      },
    );
  }

  mountMenu(BuildContext context) {}
}
