import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/common/constant/icons.dart';
import 'package:eam_app/common/constant/images.dart';
import 'package:eam_app/pages/sparepart/trx_sparepart_page.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/product/product_bloc.dart';
import '../../common/widget/product_item.dart';

class SparepartPage extends StatefulWidget {
  const SparepartPage({super.key});

  @override
  State<SparepartPage> createState() => _SparepartPageState();
}

class _SparepartPageState extends State<SparepartPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductBloc>().add(ProductEvent.product());
  }

  void searching(String query) async {
    context.read<ProductBloc>().add(ProductEvent.getProduct(query));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final List<String> products = [
      'Product 1',
      'Product 2',
      'Product 3',
      'Product 4',
    ];

    Widget header() {
      return Container(
        padding: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: ColorName.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(Images.logoText),
            ),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrxSparepartPage(),
                ),
              ),
              icon: Icon(IconsaxBold.receipt_1),
            )
          ],
        ),
      );
    }

    Widget search() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFECF0F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              IconName.search,
              width: 20,
              color: ColorName.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                style: GoogleFonts.inter(color: ColorName.black),
                controller: _searchController,
                onChanged: searching,
                decoration: InputDecoration.collapsed(
                  hintText: 'Cari Sparepart',
                  hintStyle: GoogleFonts.inter(color: ColorName.grey),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorName.green,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                header(),
                search(),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (model) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: model.data!.products!.length,
                      itemBuilder: (context, index) => ProductItem(
                        product: model.data!.products![index],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
