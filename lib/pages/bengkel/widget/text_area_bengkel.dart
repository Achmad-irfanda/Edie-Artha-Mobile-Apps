import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class TextAreaBengkel extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const TextAreaBengkel(
      {super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLines: 2,
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

String? valuesImageComp;

class ImageFieldComp extends StatefulWidget {
  const ImageFieldComp({super.key});

  @override
  State<ImageFieldComp> createState() => _ImageFieldCompState();
}

class _ImageFieldCompState extends State<ImageFieldComp> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: width,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () async {
                final XFile? photo;
                final ImagePicker picker = ImagePicker();

                photo = await picker.pickImage(source: ImageSource.camera);
                if (photo != null) {
                  
                  final directory = await getApplicationDocumentsDirectory();
                  String imageName = photo.name;

                  
                  final File file = File('${directory.path}/$imageName');

                  await File(photo.path).copy(file.path);

                  print("tapp $photo  || file $file");

                  setState(() {
                    valuesImageComp = file.absolute.path;
                  });
                }
              },
              child: (valuesImageComp != null)
                  ? Image.file(
                      File(valuesImageComp!),
                      fit: BoxFit.fitHeight,
                      width: width,
                      height: 100,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Upload Gambar Kendaraan Anda"),
                        SizedBox(
                          height: 6,
                        ),
                        Icon(
                          Icons.image_outlined,
                          size: 24,
                        ),
                      ],
                    ))),
    );
  }
}
