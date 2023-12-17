import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  var imgURL;
  final newEmp = FirebaseFirestore.instance.collection('Employees');
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  String id = DateTime.now().microsecond.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: ListView(children: [
          Column(
            children: [
              InkWell(
                child: CircleAvatar(
                  radius: 60,
                  child: imgURL == null
                      ? const Icon(Icons.add_a_photo)
                      : Image.network(imgURL, fit: BoxFit.cover),
                ),
                onTap: () {
                  uploadImg();
                },
              ),
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Name'),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                          hintText: "Name",
                          hintStyle:
                              TextStyle(color: Colors.deepPurple, fontSize: 16),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.deepPurple,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.deepPurple,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please update something first!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Email'),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          hintStyle:
                              TextStyle(color: Colors.deepPurple, fontSize: 16),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.deepPurple,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.deepPurple,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please update something first!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('City'),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: city,
                        decoration: const InputDecoration(
                          hintText: "City",
                          hintStyle:
                              TextStyle(color: Colors.deepPurple, fontSize: 16),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.deepPurple,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.deepPurple,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please update something first!';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    newEmp.doc(id).set({
                      'name': name.text,
                      'id': id,
                      'city': city.text,
                      'email': email.text,
                      'imgURL': imgURL,
                    });
                  },
                  child: const Text('Save'))
            ],
          ),
        ]),
      ),
    );
  }

  Future<void> uploadImg() async {
    ImagePicker imgPicker = ImagePicker();
    XFile? file = await imgPicker.pickImage(source: ImageSource.gallery);

    final fileExtension = p.extension(file!.path);
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImg = referenceRoot.child('images');
    Reference referenceOfImg = referenceDirImg
        .child("employee${DateTime.now().millisecond}$fileExtension");

    try {
      await referenceOfImg.putFile(File(file.path));
      imgURL = await referenceOfImg.getDownloadURL();
      setState(() {});
    } catch (e) {}
  }
}
