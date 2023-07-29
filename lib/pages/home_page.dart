import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patterns_setstate/pages/update_page.dart';
import 'package:patterns_setstate/services/http_service.dart';

import '../model/post_model.dart';
import 'create_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> items = [];

  void _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    setState(() {
      isLoading = false;
      if (response != null) {
        items = Network.parsePostList(response);
      } else {
        items = [];
      }
    });
  }

  void _apiPostDelete(Post post) async {
     setState(() {
       isLoading = true;
     });

     var response = await Network.DEL(Network.API_DELETE + post.id.toString() , Network.paramsEmpty());
     setState(() {
       isLoading = false;
       if(response != null) {
         _apiPostList();
       }else{

       }
     });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("setState"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return itemOfPost(items[index]);
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return Slidable(
      startActionPane: ActionPane(
         motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: (){},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(title: post.title!, body: post.body!),));

            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "Update",
          )
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: (){},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){
              _apiPostDelete(post);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete ",
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title!.toUpperCase()),
            const SizedBox(
              height: 5,
            ),
            Text(post.body!),
          ],
        ),
      ),
    );
  }
}
