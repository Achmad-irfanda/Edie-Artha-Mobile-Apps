import 'package:eam_app/data/models/response/trx_bengkel_response_model.dart';
import 'package:eam_app/pages/bengkel/bengkel_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constant/colors.dart';

class RiwayatItemStar extends StatefulWidget {
  final Transaction trx;
  const RiwayatItemStar({super.key, required this.trx});

  @override
  State<RiwayatItemStar> createState() => _RiwayatItemStarState();
}

class _RiwayatItemStarState extends State<RiwayatItemStar> {
  bool isMekanik = false;
  bool isRating = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (widget.trx.status == 'success') {
        isMekanik = true;
      }
      if (widget.trx.status == 'success' && widget.trx.rating != null) {
        isRating = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BengkelDetail(
                    id: widget.trx.id.toString(),
                  ))),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: ColorName.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
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
              width: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.trx.kendala ?? '',
                    style: GoogleFonts.inter(
                      color: ColorName.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: size.width * 0.45,
                    child: Text(
                      widget.trx.deskripsi ?? '',
                      style: GoogleFonts.inter(
                        color: ColorName.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    widget.trx.status ?? '',
                    style: GoogleFonts.inter(
                      color: widget.trx.status == 'success'
                          ? ColorName.green
                          : Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              child: isRating
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.trx.rating ?? '',
                          style: GoogleFonts.inter(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        )
                      ],
                    )
                  : SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
