import 'package:eam_app/common/constant/icons.dart';
import 'package:eam_app/data/datasource/bengkel_remote_datesource.dart';
import 'package:eam_app/data/models/response/bengkel_response_model.dart';
import 'package:eam_app/pages/bengkel/widget/text_disabled_bengkel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constant/colors.dart';
import '../../../common/constant/images.dart';
import '../../navigation/navigation_page.dart';

class DetailItem extends StatefulWidget {
  final Transaction trx;
  const DetailItem({super.key, required this.trx});

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  bool isRating = false;
  bool isRated = false;
  bool isMekanik = false;
  double rating = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (widget.trx.status == 'process' || widget.trx.status == 'success') {
        isMekanik = true;
      }
      if (widget.trx.status == 'success') {
        isRating = true;
      }
      if (widget.trx.rating != null) {
        rating = double.parse(widget.trx.rating!);
        isRated = true;
      }
    });
  }

  // DIALOG
  Future<void> showMessDialog(bool success) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Container(
        width: MediaQuery.of(context).size.width - (2 * 20),
        child: AlertDialog(
          backgroundColor: ColorName.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: ColorName.black,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  success ? IconName.success : IconName.success,
                  color: success ? ColorName.green : Colors.red,
                  width: 80,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  success ? 'Terimakasih!' : 'Gagal!',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  success ? 'Rating berhasil dikirim' : 'Rating gagal dikirim',
                  style: GoogleFonts.inter(fontSize: 12),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 145,
                  height: 44,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationPage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: success ? ColorName.green : Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Lanjut',
                      style: GoogleFonts.inter(
                        color: ColorName.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _rating() async {
    if (await BengkelRemoteDatesource().rating(widget.trx!.id!, rating)) {
      showMessDialog(true);
    } else {
      showMessDialog(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      width: size.width * 0.8,
       constraints: BoxConstraints(maxHeight:  size.height * 1.4),
      decoration: BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
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
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(isMekanik
                            ? widget.trx!.mekanik!.image!
                            : 'https://i.ibb.co.com/gTRNYXN/mekanik.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isMekanik
                      ? Text(
                          widget.trx.mekanik!.nama ?? '',
                          style: GoogleFonts.inter(
                            color: ColorName.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          "Mekanik Edie Arta",
                          style: GoogleFonts.inter(
                            color: ColorName.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: ColorName.black,
                      height: 0,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    "Detail Pesanan",
                    style: GoogleFonts.inter(
                      color: ColorName.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextDisabledBengkel(
                    label: 'Kendala yang dialami',
                    value: widget.trx.kendala ?? '',
                  ),
                  TextDisabledBengkel(
                    label: 'Alamat',
                    value: widget.trx.alamat ?? '',
                  ),
                  TextDisabledBengkel(
                    label: 'Status Pesanan',
                    value: widget.trx.status ?? '',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isRated
                      ? Column(
                          children: [
                            Text('Terimakasih telah memberikan rating'),
                            Container(
                              child: RatingBarIndicator(
                                rating: rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 50.0,
                                direction: Axis.horizontal,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            isRating
                                ? Container(
                                    child: Column(
                                      children: [
                                        Text('Berikan Rating kepada montir kami'),
                                        RatingBar.builder(
                                          initialRating: rating,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (value) {
                                            setState(() {
                                              rating = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : Text(
                                    'Note: Anda dapat melakukan pembayaran langsung kepada montir jika kendala sudah selesai.',
                                    style: GoogleFonts.inter(
                                      color: ColorName.grey,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.justify,
                                  )
                          ],
                        )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            !isRated
                ? Padding(
                    padding:
                        const EdgeInsets.only(right: 30, left: 30, bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (isRating) {
                          _rating();
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigationPage()),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isRating ? ColorName.green : ColorName.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            isRating ? 'Kirim Review' : 'Kembali',
                            style: GoogleFonts.inter(
                              color: ColorName.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(right: 30, left: 30, bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationPage()),
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
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
