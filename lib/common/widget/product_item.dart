import 'package:eam_app/common/constant/price_ext.dart';
import 'package:eam_app/data/models/response/product_response_model.dart';
import 'package:eam_app/pages/sparepart/sparepart_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colors.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SparepartDetail(
                    product: product,
                  ))),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: ColorName.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: ColorName.grey
                  .withOpacity(0.1), // Warna shadow dengan transparansi
              spreadRadius: 5, // Radius penyebaran shadow
              blurRadius: 5, // Radius blur shadow
              offset:
                  Offset(0, 3), // Posisi offset shadow (horizontal, vertical)
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 175,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(product.thumbnail!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      product.nama ?? '-',
                      style: GoogleFonts.inter(
                        color: ColorName.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${product.harga}'.formatPrice(),
                    style: GoogleFonts.inter(
                      color: Colors.orange,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.status ?? '-',
                    style: GoogleFonts.inter(
                      color: Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
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
