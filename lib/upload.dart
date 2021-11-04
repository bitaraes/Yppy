import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/services/api.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Upload());
}

class Upload extends StatefulWidget {
  UploadState createState() {
    return UploadState();
  }
}

class UploadState extends State<Upload> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List file;
  String filePath;
  String title;
  String description;
  String parentalRating;
  String subCategory;
  String dropdownValue;
  String category;
  List _categories = [
    "Ação",
    "Aventura",
    "Romance",
    "Fantasia",
    "Ficção Científica",
    "Drama",
    "Terror",
    "Suspense",
    "Comédia",
    "Biografia",
    "Fanfic"
  ];
  List _parentalRating = ["Livre", "12 Anos", "14 Anos", "16 Anos", "18 Anos"];

  dropDownList(List list, String label, String variable) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Color(0xFF6d398e))),
      child: DropdownButton(
        underline: Container(),
        alignment: Alignment.center,
        isExpanded: true,
        hint: TextField(
          decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Color(0xFF6d398e)),
              prefixIcon: Icon(Icons.attractions, color: Colors.transparent),
              border: InputBorder.none),
        ),
        value: dropdownValue,
        items: list
            .map(
              (current) => DropdownMenuItem(
                value: current,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: current,
                      labelStyle: TextStyle(color: Color(0xFF6d398e)),
                      prefixIcon:
                          Icon(Icons.attractions, color: Color(0xFF6d398e)),
                      border: InputBorder.none),
                ),
              ),
            )
            .toList(),
        onChanged: (newValue) {
          setState(() {
            switch (variable) {
              case "category":
                category = newValue;
                break;
              case "subcategory":
                subCategory = newValue;
                break;
              case "parental rating":
                parentalRating = newValue;
                break;
              default:
            }
          });
        },
      ),
    );
  }

  previewAdd() {
    if (file == null) {
      return Container(
        height: 300,
        child: ElevatedButton(
          onPressed: () {
            selectImage();
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              padding: EdgeInsets.only(left: 20, right: 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'carregar capa',
                style: TextStyle(color: Color(0xFF6d398e), fontSize: 20),
              ),
              Icon(
                Icons.add_sharp,
                color: Colors.blue,
                size: 40,
              )
            ],
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(18),
            ),
            height: 300,
            child: Image(
              image: FileImage(File(filePath)),
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  file = null;
                });
                selectImage();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: EdgeInsets.only(left: 20, right: 20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Substituir capa',
                    style: TextStyle(color: Color(0xFF6d398e)),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Icon(
                      Icons.autorenew,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

  selectImage() async {
    var result =
        // ignore: invalid_use_of_visible_for_testing_member
        await FilePicker.platform
            .pickFiles(type: FileType.image, withData: true);

    if (result != null && result.files.single.bytes != null) {
      var fileBytes = result.files.single.bytes;
      var fileName = result.files.single.name;
      var path = result.files.single.path;
      setState(() {
        file = [fileBytes, fileName];
        filePath = path;
      });
    } else {
      AlertDialog(
        content: Text("Algo deu errado"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/tela_de_fundo_app.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.90,
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              'nova história',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFF6d398e)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: TextField(
                              controller: titleController,
                              onChanged: (text) {
                                title = text;
                              },
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Nome da História',
                                labelStyle: TextStyle(color: Color(0xFF6d398e)),
                                prefixIcon: Icon(Icons.title,
                                    color: Colors.transparent),
                                suffixIcon: IconButton(
                                  onPressed: () => titleController.clear(),
                                  icon: Icon(Icons.clear,
                                      color: Color(0xFF6d398e)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          dropDownList(_categories, "Categoria", "category"),
                          dropDownList(
                              _categories, "sub Categoria", "subcategory"),
                          dropDownList(_parentalRating,
                              "Classificação indicativa", "parental rating"),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              maxLines: 5,
                              controller: descriptionController,
                              onChanged: (text) {
                                description = text;
                              },
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Descrição',
                                labelStyle: TextStyle(color: Color(0xFF6d398e)),
                                prefixIcon: Icon(Icons.history_edu,
                                    color: Colors.transparent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: previewAdd(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: ElevatedButton(
                          onPressed: () {
                            // selectImage();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              padding: EdgeInsets.only(left: 20, right: 20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Carregar história',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF6d398e)),
                              ),
                              Icon(
                                Icons.add_sharp,
                                color: Colors.blue,
                                size: 40,
                              )
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: ElevatedButton(
                        onPressed: () {
                          if (file != null &&
                              title != null &&
                              category != null &&
                              description != null) {
                            createPost(
                                file, title, category, description, context);
                            titleController.clear();
                            descriptionController.clear();
                            category = null;
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
                          'Enviar',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
