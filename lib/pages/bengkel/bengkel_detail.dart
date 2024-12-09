import 'package:eam_app/bloc/bengkel/bengkel_bloc.dart';
import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/pages/bengkel/widget/detail_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

class BengkelDetail extends StatefulWidget {
  final String id;
  final bool isOrder;
  const BengkelDetail({
    super.key,
    required this.id,
    this.isOrder = false,
  });

  @override
  State<BengkelDetail> createState() => _BengkelDetailState();
}

class _BengkelDetailState extends State<BengkelDetail> {
  @override
  bool isRating = false;
  late double rating;
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.isOrder) {
      _getData();
    }
  }

  Future<void> _getData() async {
    context.read<BengkelBloc>().add(BengkelEvent.getTrx(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorName.green,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detail Pesanan Montir',
          style: GoogleFonts.iceland(
            color: ColorName.black,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<BengkelBloc, BengkelState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return SizedBox();
          }, loaded: (data) {
            return RefreshIndicator(
              color: ColorName.green,
              onRefresh: () {
                return _getData();
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: DetailItem(trx: data!.data!.transaction!),
                  )
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
