import 'dart:math';

import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';
import 'home_page.dart';

class UpdatePage extends StatefulWidget {
  UpdatePage({super.key, required this.title, required this.body});

  static const String id = "update_page";

  String title;
  String body;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool isLoading = false;
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _bodyTextEditingController =
      TextEditingController();

  _apiPostUpdate() async {
    setState(() {
      isLoading = true;
    });

    Post post = Post(
        id: (Random().nextInt((pow(2, 30) - 1).toInt())),
        title: _titleTextEditingController.text,
        body: _bodyTextEditingController.text,
        userId: (Random().nextInt((pow(2, 30) - 1).toInt())));


    var response =
        await Network.PUT(Network.API_UPDATE + '1', Network.paramsUpdate(post));

    setState(() {
      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.id, (route) => false);
      }
      print(response);
      print("Update page");
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _titleTextEditingController.text = widget.title;
    _bodyTextEditingController.text = widget.body;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTextEditingController;
    _bodyTextEditingController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Column(
                  children: [
                    const Text(
                      "Title",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //title
                    Container(
                      child: TextField(
                        controller: _titleTextEditingController,
                        style: const TextStyle(color: Colors.black, fontSize: 30),
                        decoration: InputDecoration(
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "Body",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //body

                    Container(
                      height: 150,
                      width: double.infinity,
                      child: TextField(
                        maxLines: null,
                        controller: _bodyTextEditingController,
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),

                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueAccent),
                      width: 160,
                      height: 100,
                      child: TextButton(
                        onPressed: () {
                          _apiPostUpdate();
                        }, //apiPostUpdate();
                        child: const Text(
                          "Update",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
          isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
