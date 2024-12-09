import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/pages/sparepart/widget/trx_process_item.dart';
import 'package:eam_app/pages/sparepart/widget/trx_success_item.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';

class TrxSparepartPage extends StatelessWidget {
  const TrxSparepartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Riwayat Transaksi"),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: ColorName.green,
            labelColor: ColorName.green,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(
                text: 'Sedang Dalam Proses',
                icon: Icon(IconsaxBold.clock),
              ),
              Tab(
                text: 'Selesai',
                icon: Icon(IconsaxBold.task),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TrxProcessItem(),
            TrxSuccessItem(),
          ],
        ),
      ),
    );
  }
}
