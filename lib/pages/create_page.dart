import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';
import 'home_page.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  static const String id = "create_page";

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  bool isLoading = false;
  late TextEditingController titleTextEditingController;
  late TextEditingController bodyTextEditingController;

  _apiPostCreate() async {
    setState(() {
      isLoading = true;
    });
    String titleCont = titleTextEditingController.text.trim().toString();
    String bodyCont = bodyTextEditingController.text.trim().toString();
    Post post = Post(id: 1, title: titleCont, body: bodyCont, userId: 1);

    var response =
    await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    setState(() {
      if (response != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    titleTextEditingController = TextEditingController();
    bodyTextEditingController = TextEditingController();
    _apiPostCreate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Page"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Title",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // #title
                  TextField(
                    controller: titleTextEditingController,
                    style: const TextStyle(color: Colors.black, fontSize: 30),
                    decoration: const InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.blue, fontSize: 20),
                      //border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Content",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // #body
                  TextField(
                    controller: bodyTextEditingController,
                    style: const TextStyle(color: Colors.black, fontSize: 30),
                    decoration: const InputDecoration(
                      hintText: "Body",
                      hintStyle: TextStyle(color: Colors.blue, fontSize: 20),
                      //border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent),
                    width: 160,
                    height: 100,
                    child: TextButton(
                      onPressed: () {}, //_apiPostCreate();
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
