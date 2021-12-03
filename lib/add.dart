import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  State<AddMovie> createState() => _AddMovieState();
}

final picker = ImagePicker();

class _AddMovieState extends State<AddMovie> {
  _imgFromGallery() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = await image.readAsBytes();
      image1 = MemoryImage(imageFile);
    }
    setState(() {});
  }

  var imageFile, image1;
  final movieName = TextEditingController();
  final directorName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void buttonPressed() {
      Fluttertoast.showToast(
        msg: movieName.text.isEmpty
            ? "Invalid Input"
            : "${movieName.text} added",
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      if (movieName.text.isNotEmpty) {
        addItem(movieName.text, directorName.text, image1);
        setState(() {});
      }
    }

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add New Movie'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.of(context).push(backHome());
            },
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _imgFromGallery();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  child: (imageFile == null)
                      ? const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.black87,
                          size: 50,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                            image: image1,
                            fit: BoxFit.fill,
                          ),
                        ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade50,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 0.0,
                          blurRadius: 3.0,
                          offset: const Offset(3.0, 3.0)),
                      BoxShadow(
                          color: Colors.grey.shade400,
                          spreadRadius: 0.0,
                          blurRadius: 3.0 / 2.0,
                          offset: const Offset(3.0, 3.0)),
                      const BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2.0,
                          blurRadius: 3.0,
                          offset: Offset(-3.0, -3.0)),
                      const BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2.0,
                          blurRadius: 3.0 / 2,
                          offset: Offset(-3.0, -3.0)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: movieName,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Movie Name',
                ),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: directorName,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Director',
                ),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    buttonPressed();
                  },
                  child: const Text('Create'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black87,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void addItem(String a, String b, var posterImage) {
  movies.add(a);
  director.add(b);
  poster.add(posterImage);
}
