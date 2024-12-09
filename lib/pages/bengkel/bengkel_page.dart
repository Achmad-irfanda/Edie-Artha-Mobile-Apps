import 'package:eam_app/bloc/bengkel/bengkel_bloc.dart';
import 'package:eam_app/data/models/request/bengkel_request_model.dart';
import 'package:eam_app/pages/bengkel/bengkel_detail.dart';
import 'package:eam_app/pages/bengkel/trx_bengkel_page.dart';
import 'package:eam_app/pages/bengkel/widget/text_area_bengkel.dart';
import 'package:eam_app/pages/bengkel/widget/text_field_bengkel.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
    context.read<BengkelBloc>().add(BengkelEvent.bengkel(model));
  }

  @override
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
              content: Container(
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
                id: data.data!.transaction!.id.toString(),
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

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
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
