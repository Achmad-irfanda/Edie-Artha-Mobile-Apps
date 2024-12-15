import 'package:banner_carousel/banner_carousel.dart';
import 'package:eam_app/bloc/product/product_bloc.dart';
import 'package:eam_app/pages/home/widget/service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/constant/colors.dart';
import '../../common/constant/images.dart';
import '../../common/widget/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Get screen width of viewport.
  double get screenWidth => MediaQuery.of(context).size.width;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductEvent.product());
  }

  @override
  @override
  void dispose() {
    super.dispose();
  }

  int selectedIndex = 0;

  final List<String> products = [
    'Product 1',
    'Product 2',
    'Product 3',
  ];

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorName.green,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          Images.logoText,
                          width: 300.0,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        BannerCarousel.fullScreen(
                          banners: BannerImages.listBanners,
                          customizedIndicators: const IndicatorModel.animation(
                            width: 20,
                            height: 5,
                            spaceBetween: 2,
                            widthAnimation: 50,
                          ),
                          height: 300,
                          activeColor: ColorName.black,
                          disableColor: Colors.white,
                          animation: true,
                          borderRadius: 10,
                          indicatorBottom: false,
                        ),
                        const ServiceWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sparepart Kendaraan',
                              style: GoogleFonts.inter(
                                color: ColorName.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),

              //
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.5 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      );
                    },
                    error: (message) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.5 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Center(
                                child: Text(message),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      );
                    },
                    loaded: (model) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.5 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return ProductItem(
                                product: model.data!.products![index],
                              );
                            },
                            childCount: model.data!.products!.length,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      )),
    );
  }
}

class BannerImages {
  static const String banner1 = "assets/images/slider-1.png";
  static const String banner2 = "assets/images/slider-2.png";
  static const String banner3 = "assets/images/slider-3.png";

  static List<BannerModel> listBanners = [
    BannerModel(imagePath: banner1, id: "1"),
    BannerModel(imagePath: banner2, id: "2"),
    BannerModel(imagePath: banner3, id: "3"),
  ];
}
