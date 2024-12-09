import 'dart:convert';

import 'package:eam_app/bloc/trx_product/trx_product_bloc.dart';
import 'package:eam_app/common/constant/price_ext.dart';
import 'package:eam_app/data/models/request/trx_product_request_model.dart';
import 'package:eam_app/data/models/response/product_response_model.dart';
import 'package:eam_app/pages/sparepart/trx_detail_page.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/constant/colors.dart';
import '../../common/constant/images.dart';
import 'package:flutter/widgets.dart' as widgets;

class CheckoutPage extends StatefulWidget {
  final int kuantitas;
  final Product product;
  const CheckoutPage(
      {super.key, required this.kuantitas, required this.product});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _alamatController = TextEditingController();
  List<String> paymentMethods = ["COD", "Transfer Bank"];
  List<String> varians = [];
  List<String> pasang = ["YA", "TIDAK"];

  String selectedPaymentMethod = "COD";
  String selectedPasang = "YA";
  String selectedVarian = "";
  int total = 0;
  bool _isDisabledBtn = false;

  void initState() {
    super.initState();
    _alamatController.addListener(_validateFields);
    setState(() {
      varians = List<String>.from(jsonDecode(widget.product.varian!));
      selectedVarian = varians.first;
      double doubleValue = double.parse(widget.product.harga!);
      int intValue = doubleValue.toInt();
      total = intValue * widget.kuantitas;
    });
  }

  void _validateFields() async {
    final alamat = _alamatController.text;

    // Cek validasi di sini
    bool isValid = alamat.isNotEmpty;

    setState(() {
      _isDisabledBtn = isValid;
    });
  }

  void dispose() {
    _alamatController.dispose();
    super.dispose();
  }

  order() async {
    String alamat = _alamatController.text.trim();
    List<Item> items = [
      Item(
        product: widget.product.id!,
        kuantitas: widget.kuantitas,
        varian: selectedVarian,
      )
    ];
    final model = TrxProductRequestModel(
      jasaPasang: selectedPasang,
      pembayaran: selectedPaymentMethod,
      alamat: alamat,
      items: items,
    );
    context.read<TrxProductBloc>().add(TrxProductEvent.trxProduct(model));
  }

  Widget buttonSubmit() {
    return BlocConsumer<TrxProductBloc, TrxProductState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return TrxDetailPage(
                  id: data.data!.transaction!.first.id.toString(),
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
            error: (message) {
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ),
              );
            });
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (_alamatController.text.isEmpty || selectedVarian.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Silahkan lengkap form pemesanan'),
                  backgroundColor: Colors.red,
                ),
              );
            }
            order();
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
                'Pesan Sekarang',
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
            'Pesan Sekarang',
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detail Sparepart',
          style: GoogleFonts.iceland(
            color: ColorName.black,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: widgets.Image(
                  image: AssetImage(Images.logoText),
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(widget.product.thumbnail!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: size.width * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.nama ?? '',
                            style: GoogleFonts.inter(
                              color: ColorName.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${widget.product.harga}'.formatPrice(),
                            style: GoogleFonts.inter(
                              color: Colors.orange,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                IconsaxBold.tick_circle,
                                color: ColorName.green,
                                size: 14,
                              ),
                              Text(
                                widget.product.status ?? '-',
                                style: GoogleFonts.inter(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${widget.kuantitas.toString()} Pcs',
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
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
                    controller: _alamatController,
                    decoration: InputDecoration(
                      hintText: 'Alamat Lengkap',
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                width: size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pilih Metode Pembayaran',
                      style: GoogleFonts.inter(
                        color: ColorName.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    child: CupertinoPicker(
                                      itemExtent: 32.0,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          print(paymentMethods[index]);
                                          selectedPaymentMethod =
                                              paymentMethods[index];
                                        });
                                      },
                                      children:
                                          paymentMethods.map((String method) {
                                        return Center(child: Text(method));
                                      }).toList(),
                                    ),
                                  ),
                                  CupertinoButton(
                                    child: Text('Selesai'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        selectedPaymentMethod,
                        style: GoogleFonts.inter(
                          color: ColorName.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                width: size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Langsung dengan Pemasangan',
                      style: GoogleFonts.inter(
                        color: ColorName.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    child: CupertinoPicker(
                                      itemExtent: 32.0,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          selectedPasang = pasang[index];
                                        });
                                      },
                                      children: pasang.map((String method) {
                                        return Center(child: Text(method));
                                      }).toList(),
                                    ),
                                  ),
                                  CupertinoButton(
                                    child: Text('Selesai'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        selectedPasang,
                        style: GoogleFonts.inter(
                          color: ColorName.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                width: size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pilih Varian',
                      style: GoogleFonts.inter(
                        color: ColorName.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    child: CupertinoPicker(
                                      itemExtent: 32.0,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          selectedVarian = varians[index];
                                        });
                                      },
                                      children: varians.map((String method) {
                                        return Center(child: Text(method));
                                      }).toList(),
                                    ),
                                  ),
                                  CupertinoButton(
                                    child: Text('Selesai'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        selectedVarian,
                        style: GoogleFonts.inter(
                          color: ColorName.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: ColorName.black,
              ),
              Text(
                'Rincian Transaksi',
                style: GoogleFonts.inter(
                  color: ColorName.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sparepart [ ${widget.kuantitas} Pcs]',
                    style: GoogleFonts.inter(
                      color: ColorName.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    '${total}'.formatPrice(),
                    style: GoogleFonts.inter(
                      color: ColorName.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: GoogleFonts.inter(
                      color: ColorName.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    '${total}'.formatPrice(),
                    style: GoogleFonts.inter(
                      color: ColorName.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              _isDisabledBtn ? buttonSubmit() : disabledBtn()
            ],
          ),
        ),
      ),
    );
  }
}
