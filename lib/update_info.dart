import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateInfo extends StatefulWidget {
  final int index;
  UpdateInfo({super.key, required this.index});

  @override
  State<UpdateInfo> createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  final data = FirebaseFirestore.instance.collection('Employees');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.doc(widget.index.toString()).toString()),
      ),
    );
  }
}
