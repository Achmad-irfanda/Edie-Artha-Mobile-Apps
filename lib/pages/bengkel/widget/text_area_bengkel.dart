import 'dart:io';
import 'package:eam_app/pages/auth/register_page.dart';
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
  void changeImage() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                Padding(
                    padding: EdgeInsets.only(left: 10), child: Text("Loading")),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () async {
      late final XFile? photo;
      final ImagePicker picker = ImagePicker();

      Navigator.pop(context);
      photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        final directory = await getApplicationDocumentsDirectory();
        String imageName = photo!.name;

        final File file = File('${directory.path}/$imageName');

        await File(photo!.path).copy(file.path);

        setState(() {
          valuesImageComp = file.absolute.path;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            changeImage();
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 200,
            width: width,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: (valuesImageComp != null)
                    ? Image.file(
                        File(valuesImageComp!),
                        fit: BoxFit.cover,
                        width: width,
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
                      )),
          ),
        ),
        if (valuesImageComp != null) jar(sized: 5),
        if (valuesImageComp != null)
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.red),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: GestureDetector(
              onTap: () {
                changeImage();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Ganti Foto",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
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
