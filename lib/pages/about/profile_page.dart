import 'dart:io';

import 'package:eam_app/bloc/user/user_bloc.dart';
import 'package:eam_app/data/models/request/user_request_model.dart';
import 'package:eam_app/data/models/response/user_response_model.dart';
import 'package:eam_app/pages/bengkel/widget/text_field_bengkel.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../common/constant/colors.dart';
import '../bengkel/widget/text_area_bengkel.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({
    super.key,
    required this.user,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nohpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _namaController.text = widget.user.name!;
      _nohpController.text = widget.user.nohp!;
      _emailController.text = widget.user.email!;
      _alamatController.text = widget.user.alamat ?? '';
    });
  }

  // IMAGE PICKER
  late String _imagePath = "";
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() => this.image = imagePermanent);
      cropSquareImage(this.image);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File?> cropSquareImage(File? imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressQuality: 70,
      compressFormat: ImageCompressFormat.png,
      uiSettings: [androidUiSettingsLocked(), iosUiSettingsLocked()],
    );
    if (croppedFile != null) {
      setState(() {
        _imagePath = croppedFile.path;
      });
    }
  }

  IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
        rotateClockwiseButtonHidden: false,
        rotateButtonsHidden: false,
      );

  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Edit Foto',
        toolbarColor: ColorName.green,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: true,
      );

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = path.basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  // SELECT SOURCE PICK IMAGE
  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text('Camera'),
              onPressed: () => pickImage(ImageSource.camera),
            ),
            CupertinoActionSheetAction(
              child: Text('Gellery'),
              onPressed: () => pickImage(ImageSource.gallery),
            ),
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(IconsaxBold.camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.camera);
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Icon(IconsaxBold.image),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void update() async {
      String name = _namaController.text.trim();
      String email = _emailController.text.trim();
      String nohp = _nohpController.text.trim();
      String alamat = _alamatController.text.trim();
      String image = _imagePath;

      // Bloc
      final model = UserRequestModel(
        name: name,
        email: email,
        nohp: nohp,
        alamat: alamat,
        image: image,
      );
      print('model:' + model.toJson());
      context.read<UserBloc>().add(UserEvent.update(model));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Akun Saya',
          style: GoogleFonts.iceland(
            color: ColorName.black,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff02F80B),
                Color(0xff194E1A),
              ], // Warna gradien
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip
                  .none, // Add this line to ensure the circle can be positioned outside the stack
              children: [
                // Background container for profile description
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * 0.7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            TextFieldBengkel(
                              controller: _namaController,
                              label: 'Nama lengkap',
                            ),
                            TextFieldBengkel(
                              controller: _emailController,
                              label: 'Alamat Email',
                            ),
                            TextFieldBengkel(
                              controller: _nohpController,
                              label: 'No handphone',
                            ),
                            TextAreaBengkel(
                              controller: _alamatController,
                              label: 'Alamat',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 30, left: 30, bottom: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            BlocConsumer<UserBloc, UserState>(
                              listener: (context, state) {
                                state.maybeWhen(
                                  orElse: () {},
                                  loading: () {
                                    Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  loaded: (data) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Profil berhasil diupdate'),
                                      backgroundColor: Colors.green,
                                    ));
                                  },
                                );
                              },
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: update,
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: ColorName.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Simpan',
                                        style: GoogleFonts.inter(
                                          color: ColorName.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Profile picture
                Positioned(
                  top:
                      -50, // Adjust this value to position the circle above the container
                  child: Column(
                    children: [
                      image == null
                          ? Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: NetworkImage(widget.user.image ?? ''),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4.0,
                                ),
                              ),
                            )
                          : Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: FileImage(image!),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4.0,
                                ),
                              ),
                            ),
                      GestureDetector(
                        onTap: () => showImageSource(context),
                        child: Text(
                          'Ganti Photo',
                          style: GoogleFonts.inter(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
