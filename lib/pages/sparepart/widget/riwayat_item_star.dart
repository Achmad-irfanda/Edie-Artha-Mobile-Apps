import 'package:eam_app/common/constant/price_ext.dart';
import 'package:eam_app/data/models/response/trx_product_response_model.dart';
import 'package:eam_app/pages/sparepart/trx_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constant/colors.dart';

class RiwayatItemStar extends StatelessWidget {
  final Transaction trx;
  const RiwayatItemStar({super.key, required this.trx});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return TrxDetailPage(
                id: trx.id.toString(),
              );
            },
          ),
        );
      },
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
                  image: NetworkImage(trx.items!.first.product!.thumbnail!),
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
                  Container(
                    width: size.width * 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trx.items!.first.product!.nama!,
                          style: GoogleFonts.inter(
                            color: ColorName.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${trx.items!.first.harga}'.formatPrice(),
                          style: GoogleFonts.inter(
                            color: ColorName.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          trx.pembayaran ?? '',
                          style: GoogleFonts.inter(
                            color: ColorName.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          trx.status ?? '',
                          style: GoogleFonts.inter(
                            color: ColorName.black,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
