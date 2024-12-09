import 'package:eam_app/bloc/trx_product/trx_product_bloc.dart';
import 'package:eam_app/pages/sparepart/widget/riwayat_item_star.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constant/colors.dart';

class TrxSuccessItem extends StatefulWidget {
  const TrxSuccessItem({super.key});

  @override
  State<TrxSuccessItem> createState() => _TrxSuccessItemState();
}

class _TrxSuccessItemState extends State<TrxSuccessItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var status = 'success';
    context.read<TrxProductBloc>().add(TrxProductEvent.getAll(status));
  }

  Widget build(BuildContext context) {
    return Container(
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
      child: SingleChildScrollView(
        child: BlocBuilder<TrxProductBloc, TrxProductState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return Container(
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
                          color: Colors.black12),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              );
            }, loaded: (data) {
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: data.data!.transaction!
                      .map((trx) => RiwayatItemStar(
                            trx: trx,
                          ))
                      .toList(),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
