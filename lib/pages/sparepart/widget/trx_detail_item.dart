import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/common/constant/images.dart';
import 'package:eam_app/common/constant/price_ext.dart';
import 'package:eam_app/common/constant/variables.dart';
import 'package:eam_app/data/models/response/trx_product_response_model.dart';
import 'package:eam_app/pages/navigation/navigation_page.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrxDetailItem extends StatefulWidget {
  final Transaction trx;
  const TrxDetailItem({super.key, required this.trx});

  @override
  State<TrxDetailItem> createState() => _TrxDetailItemState();
}

class _TrxDetailItemState extends State<TrxDetailItem> {
  String productName = '';
  String image = 'https://i.ibb.co.com/gTRNYXN/mekanik.jpg';
  String price = '0';
  String kuantitas = '0';
  String alamat = '';
  String ready = '';
  String status = '';
  String pembayaran = '';
  String jasaPasang = '';
  String varian = '';
  String total = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      productName = widget.trx?.items?.first?.product?.nama ?? '';
      image = widget.trx?.items?.first?.product?.thumbnail ?? '';
      price = widget.trx?.items?.first?.harga ?? '';
      kuantitas = widget.trx?.items?.first.kuantitas ?? '';
      alamat = widget.trx?.alamat ?? '';
      total = widget.trx?.total ?? '';
      ready = widget.trx?.items?.first?.product?.status ?? '';
      pembayaran = widget.trx?.pembayaran ?? '';
      jasaPasang = widget.trx?.jasaPasang ?? '';
      status = widget.trx?.status ?? '';
      varian = widget.trx?.items?.first?.varian ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
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
                      image: NetworkImage(Variables.baseUrl + image),
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
                        productName,
                        style: GoogleFonts.inter(
                          color: ColorName.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${price}'.formatPrice(),
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
                            ready,
                            style: GoogleFonts.inter(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${kuantitas} Pcs',
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
                padding: const EdgeInsets.all(8.0), child: Text(alamat)),
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
                Text(
                  pembayaran,
                  style: GoogleFonts.inter(
                    color: ColorName.black,
                    fontWeight: FontWeight.bold,
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
                Text(
                  jasaPasang,
                  style: GoogleFonts.inter(
                    color: ColorName.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                Text(
                  varian,
                  style: GoogleFonts.inter(
                    color: ColorName.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status',
                style: GoogleFonts.inter(
                  color: ColorName.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                status,
                style: GoogleFonts.inter(
                  color: ColorName.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
                'Sparepart [ ${kuantitas} Pcs]',
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavigationPage()),
              );
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: ColorName.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Kembali',
                  style: GoogleFonts.inter(
                    color: ColorName.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
