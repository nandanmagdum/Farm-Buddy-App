import 'package:flutter/material.dart';
import 'package:krishi_vikas/home_page.dart';

class ViewDetails extends StatefulWidget {
  Map<String, dynamic> object;
  final String photo_url;
  ViewDetails({super.key, required this.object, required this.photo_url});

  @override
  State<ViewDetails> createState() => ViewDetailsState();
}

class ViewDetailsState extends State<ViewDetails> {
  @override
  void initState() {
    widget.object.remove("_v");
    widget.object.remove("_id");
    widget.object.remove("createdAt");
    widget.object.remove("updatedAt");
    widget.object.remove("__v");
    widget.object.remove("photo_url");
    widget.object.removeWhere((key, value) => value is! String);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   print("HEYYYY");
      //   print(widget.object);
      // }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Image.network(widget.photo_url == "" ? "https://c7.alamy.com/comp/2JA6BFB/no-image-vector-symbol-missing-available-icon-no-gallery-for-this-moment-placeholder-2JA6BFB.jpg" : widget.photo_url),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 15000,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.object.length,
                  itemBuilder: (context, index) {
                    String key = widget.object.keys.elementAt(index);
                    dynamic value = widget.object[key];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(key,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(value, style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
