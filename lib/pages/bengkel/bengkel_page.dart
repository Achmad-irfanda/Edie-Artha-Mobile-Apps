import 'package:eam_app/bloc/bengkel/bengkel_bloc.dart';
import 'package:eam_app/common/constant/loading_dialog.dart';
import 'package:eam_app/data/models/request/bengkel_request_model.dart';
import 'package:eam_app/pages/auth/register_page.dart';
import 'package:eam_app/pages/bengkel/bengkel_detail.dart';
import 'package:eam_app/pages/bengkel/trx_bengkel_page.dart';
import 'package:eam_app/pages/bengkel/widget/text_area_bengkel.dart';
import 'package:eam_app/pages/bengkel/widget/text_field_bengkel.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../common/constant/colors.dart';
import '../../common/constant/images.dart';

class BengkelPage extends StatefulWidget {
  const BengkelPage({super.key});

  @override
  State<BengkelPage> createState() => _BengkelPageState();
}

class _BengkelPageState extends State<BengkelPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _kendalaController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _platController = TextEditingController();
  TextEditingController _kendaraanController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();

  bool _isDisabledBtn = false;

  void initState() {
    super.initState();
    _kendalaController.addListener(_validateFields);
    _deskripsiController.addListener(_validateFields);
    _platController.addListener(_validateFields);
    _kendaraanController.addListener(_validateFields);
    _alamatController.addListener(_validateFields);
  }

  void _validateFields() async {
    final kendala = _kendalaController.text;
    final deskripsi = _deskripsiController.text;
    final plat = _platController.text;
    final kendaraan = _kendaraanController.text;
    final alamat = _alamatController.text;

    // Cek validasi di sini
    bool isValid = kendala.isNotEmpty &&
        deskripsi.isNotEmpty &&
        plat.isNotEmpty &&
        kendaraan.isNotEmpty &&
        alamat.isNotEmpty;

    setState(() {
      _isDisabledBtn = isValid;
      print(isValid);
    });
  }

  void dispose() {
    _kendalaController.dispose();
    _deskripsiController.dispose();
    _platController.dispose();
    _kendaraanController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  order() async {
    String alamat = _alamatController.text.trim();
    String kendala = _kendalaController.text.trim();
    String deskripsi = _deskripsiController.text.trim();
    String kendaraan = _kendaraanController.text.trim();
    String plat = _platController.text.trim();

    final model = BengkelRequestModel(
      alamat: alamat,
      kendala: kendala,
      deskripsi: deskripsi,
      kendaraan: kendaraan,
      platNomor: plat,
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      context.read<BengkelBloc>().add(BengkelEvent.bengkel(model));
    });
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.only(top: 30),
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: ColorName.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Text(
            'Pesan Montir',
            style: GoogleFonts.iceland(
              color: ColorName.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrxBengkelPage(),
              ),
            ),
            icon: Icon(IconsaxBold.receipt_1),
          )
        ],
      ),
    );
  }

  Widget button() {
    return BlocConsumer<BengkelBloc, BengkelState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
          },
          loading: () {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              content: SizedBox(
                height: 150,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Loading....',
                        style: GoogleFonts.inter(color: ColorName.black),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          loaded: (data) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return BengkelDetail(
                id: data.data.transaction.id.toString(),
                isOrder: true,
              );
            }), (route) => false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Order Berhasil'),
                backgroundColor: Colors.green,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            loadingDialog(context: context); 
            if (_formKey.currentState!.validate()) {
              order();
            }
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: ColorName.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Order',
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
    );
  }

  Widget disabledBtn() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: ColorName.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Order',
            style: GoogleFonts.inter(
              color: ColorName.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [
              Color(0xff02F80B),
              Color(0xff194E1A),
            ], // Warna gradien
          ),
        ),
        child: Column(
          children: [
            header(),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: size.width * 0.85,
                decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      Images.logoText,
                    ),
                    Divider(
                      color: ColorName.black,
                      height: 0,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Silahkan isi form berikut",
                              style: GoogleFonts.inter(
                                color: ColorName.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFieldBengkel(
                              controller: _kendalaController,
                              label: 'Kendala yang dialami',
                            ),
                            TextAreaBengkel(
                              controller: _deskripsiController,
                              label: 'Deskripsikan kendala anda',
                            ),
                            TextFieldBengkel(
                              controller: _platController,
                              label: 'Plat Nomor Kendaraan',
                            ),
                            TextFieldBengkel(
                              controller: _kendaraanController,
                              label: 'Jenis Kendaraan',
                            ),
                            TextAreaBengkel(
                              controller: _alamatController,
                              label: 'Alamat',
                            ),
                            ImageFieldComp(),
                            jar(sized: 20),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: ColorName.green,
                                    ),
                                    color: const Color.fromARGB(
                                        255, 194, 221, 198)),
                                padding: EdgeInsets.all(8),
                                child: Text(
                                    'Harga di dalam kota akan dikenakan biaya transport Rp. 5000, sedangkan diluar kota Rp. 10.000')),
                            jar(sized: 14)
                          ],
                        ),
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
                          _isDisabledBtn ? button() : disabledBtn()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







// //import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:dartz/dartz.dart'; // Make sure to import Either
// import 'your_model_file.dart'; // Import your models
// import 'auth_local_datasource.dart'; // Import your AuthLocalDatasource
// import 'variables.dart'; // Import your Variables

// Future<Either<String, BengkelResponseModel>> transaction(
//     BengkelRequestModel model) async {
//   final token = await AuthLocalDatasource().getToken();
//   final headers = {
//     'Accept': 'application/json',
//     'Authorization': 'Bearer $token'
//   };

//   // Create a multipart request
//   var request = http.MultipartRequest(
//     'POST',
//     Uri.parse("${Variables.baseUrl}api/trx/workshop"),
//   );

//   // Add headers to the request
//   request.headers.addAll(headers);

//   // Add the fields from the model to the request
//   request.fields['description'] = model.description; // Add other fields as necessary

//   // If you have a file path, create a MultipartFile
//   String filePath = valuesImageComp!; // Ensure this is a valid file path
//   var gambar = await http.MultipartFile.fromPath('gambar', filePath);
  
//   // Add the MultipartFile to the request
//   request.files.add(gambar);

//   // Send the request
//   var response = await request.send();

//   // Check the response
//   if (response.statusCode == 200) {
//     // Convert the response to a string
//     var responseString = await response.stream.bytesToString();
//     return Right(BengkelResponseModel.fromJson(jsonDecode(responseString)));
//   } else {
//     // Handle error response
//     final mess = jsonDecode(await response.stream.bytesToString())['meta']['message'];
//     return Left(mess);
//   }
// }