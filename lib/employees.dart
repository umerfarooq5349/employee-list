import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/add_employee.dart';
import 'package:my_app/update_info.dart';

class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  final employees =
      FirebaseFirestore.instance.collection('Employees').snapshots();
  final employee = FirebaseFirestore.instance.collection('Employees');
  String docId = DateTime.now().microsecond.toString();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Text('All employees'),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: employees,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            showMyDailogue(
                                snapshot.data!.docs[index]['name'].toString(),
                                snapshot.data!.docs[index]['id'].toString(),
                                snapshot.data!.docs[index]['email'].toString(),
                                snapshot.data!.docs[index]['city'].toString(),
                                snapshot.data!.docs[index]['imgURL']
                                    .toString());
                          },
                          leading: CircleAvatar(
                            child: snapshot.data!.docs[index]['imgURL'] == null
                                ? const Icon(Icons.supervised_user_circle)
                                : Image.network(
                                    snapshot.data!.docs[index]['imgURL'],
                                    fit: BoxFit.fill,
                                  ),
                          ),
                          title: Text(
                            snapshot.data!.docs[index]['name'],
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[index]['email'],
                          ),
                          trailing: PopupMenuButton(
                            color: Colors.white,
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.edit,
                                      color: Colors.deepPurple,
                                    ),
                                    title: const Text(
                                      'Edit',
                                      style:
                                          TextStyle(color: Colors.deepPurple),
                                    ),
                                    onTap: () {
                                      showMyDailogue(
                                        snapshot.data!.docs[index]['name']
                                            .toString(),
                                        snapshot.data!.docs[index]['id']
                                            .toString(),
                                        snapshot.data!.docs[index]['email']
                                            .toString(),
                                        snapshot.data!.docs[index]['city']
                                            .toString(),
                                        snapshot.data!.docs[index]['imgURL']
                                            .toString(),
                                      );
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.deepPurple,
                                    ),
                                    title: const Text(
                                      'Delete',
                                      style:
                                          TextStyle(color: Colors.deepPurple),
                                    ),
                                    onTap: () {
                                      employee
                                          .doc(snapshot.data!.docs[index]['id']
                                              .toString())
                                          .delete()
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                )
                              ];
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Text('No data to show');
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddEmployee();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDailogue(String title, String id, String eemail,
      String ecity, String imgURL) async {
    return showDialog(
      context: context,
      builder: (context) {
        name.text = title;
        email.text = eemail;
        city.text = ecity;

        return AlertDialog(
          title: const Text('Update'),
          content: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Image.network(imgURL, width: double.infinity),
                ),
                const SizedBox(
                  height: 8,
                ),
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
          ]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
              ),
            ),
            TextButton(
              onPressed: () {
                employee.doc(id).update({
                  'name': name.text.toString(),
                  'email': email.text.toString(),
                  'city': city.text.toString()
                }).then((value) {
                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  Navigator.pop(context);
                });
              },
              child: const Text(
                'Save and close',
              ),
            ),
          ],
        );
      },
    );
  }
}
