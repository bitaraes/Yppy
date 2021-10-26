import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_bar/bottom_bar.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/services/api.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Home(),
      '/login': (context) => Login(),
      '/signup': (context) => Cadastrar(),
      '/profile': (context) => Profile(),
      '/upload': (context) => Upload(),
    },
  ));
}

class Upload extends StatefulWidget {
  UploadState createState() {
    return UploadState();
  }
}

class UploadState extends State<Upload> {
  TextEditingController titleController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String file;
  String title;
  String gender;
  String description;

  selectImage() async {
    var fileName =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (fileName != null) {
      file = fileName.path;
      print(file);
    } else {
      print(file);
    }
  }

  isVisible() {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300), color: Colors.white),
        margin: EdgeInsets.only(bottom: 10),
        height: MediaQuery.of(context).size.height * 0.20,
        child: Image.asset("assets/img/fundo_transparente.png"),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 30),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/tela_de_fundo_app.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isVisible(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          'Poste uma história',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: titleController,
                          onChanged: (text) {
                            title = text;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Título',
                            labelStyle: TextStyle(color: Color(0xFF6d398e)),
                            prefixIcon:
                                Icon(Icons.title, color: Color(0xFF6d398e)),
                            suffixIcon: IconButton(
                              onPressed: () => titleController.clear(),
                              icon: Icon(Icons.clear, color: Color(0xFF6d398e)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: genderController,
                          onChanged: (text) {
                            gender = text;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Gênero',
                            labelStyle: TextStyle(color: Color(0xFF6d398e)),
                            prefixIcon: Icon(Icons.attractions,
                                color: Color(0xFF6d398e)),
                            suffixIcon: IconButton(
                              onPressed: () => genderController.clear(),
                              icon: Icon(Icons.clear, color: Color(0xFF6d398e)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          maxLines: 2,
                          controller: descriptionController,
                          onChanged: (text) {
                            description = text;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Descrição',
                            labelStyle: TextStyle(color: Color(0xFF6d398e)),
                            prefixIcon: Icon(Icons.history_edu,
                                color: Color(0xFF6d398e)),
                            suffixIcon: IconButton(
                              onPressed: () => descriptionController.clear(),
                              icon: Icon(Icons.clear, color: Color(0xFF6d398e)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            selectImage();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              padding: EdgeInsets.only(left: 20, right: 20)),
                          child: Text(
                            'Adicionar arquivo',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            if (file != null &&
                                title != null &&
                                gender != null &&
                                description != null) {
                              createPost(
                                  file, title, gender, description, context);
                              titleController.clear();
                              genderController.clear();
                              descriptionController.clear();
                              file = null;
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text(
                                    'Erro',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Text(
                                    'Todos os campos devem ser preenchidos',
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () => {Navigator.pop(context)},
                                      child: Text('Voltar'),
                                    )
                                  ],
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF6d398e),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              padding: EdgeInsets.only(left: 20, right: 20)),
                          child: Text(
                            'Postar História',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
