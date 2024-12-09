import 'package:eam_app/bloc/trx_product/trx_product_bloc.dart';
import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/pages/sparepart/widget/trx_detail_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TrxDetailPage extends StatefulWidget {
  final String id;
  final bool isOrder;
  const TrxDetailPage({super.key, required this.id, this.isOrder = false});

  @override
  State<TrxDetailPage> createState() => _TrxDetailPageState();
}

class _TrxDetailPageState extends State<TrxDetailPage> {
  @override
  void initState() {
    super.initState();
    if (!widget.isOrder) {
      _getData();
    }
    print(widget.id);
  }

  Future<void> _getData() async {
    context.read<TrxProductBloc>().add(TrxProductEvent.getTrx(widget.id));
  }

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
      body: BlocBuilder<TrxProductBloc, TrxProductState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return Center(
              child: CircularProgressIndicator(
                color: ColorName.grey,
              ),
            );
          }, loaded: (data) {
            return RefreshIndicator(
              onRefresh: () {
                return _getData();
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: TrxDetailItem(
                      trx: data.data!.transaction!.first,
                    ),
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
