import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/common/constant/images.dart';
import 'package:eam_app/common/constant/price_ext.dart';
import 'package:eam_app/data/models/response/product_response_model.dart';
import 'package:eam_app/pages/sparepart/checkout_page.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:google_fonts/google_fonts.dart';

class SparepartDetail extends StatefulWidget {
  final Product product;
  const SparepartDetail({super.key, required this.product});

  @override
  State<SparepartDetail> createState() => _SparepartDetailState();
}

class _SparepartDetailState extends State<SparepartDetail> {
  int kuantitas = 1;
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
      body: Container(
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
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            width: size.width * 0.8,
            decoration: BoxDecoration(
              color: ColorName.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                widgets.Image.asset(
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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 175,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(widget.product.thumbnail!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          widget.product.nama ?? '-',
                          style: GoogleFonts.inter(
                            color: ColorName.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          color: ColorName.black,
                          height: 0,
                          thickness: 2,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          widget.product.deskripsi ?? '-',
                          style: GoogleFonts.inter(
                            color: ColorName.black,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 13,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 30, left: 30, bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Kuantitas'),
                          Container(
                            width: 110,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: ColorName.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (kuantitas > 1) {
                                        kuantitas--;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    IconsaxBold.minus_square,
                                    color: kuantitas == 1
                                        ? ColorName.grey
                                        : ColorName.black,
                                  ),
                                ),
                                Text(
                                  kuantitas.toString(),
                                  style: GoogleFonts.inter(
                                    color: ColorName.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      kuantitas++;
                                    });
                                  },
                                  icon: Icon(
                                    IconsaxBold.add_square,
                                    color: ColorName.black,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                kuantitas: kuantitas,
                                product: widget.product,
                              ),
                            ),
                          );
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
                              'Pesan',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
