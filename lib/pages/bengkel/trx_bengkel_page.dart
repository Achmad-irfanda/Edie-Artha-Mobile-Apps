import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/pages/bengkel/widget/riwayat_item.dart';
import 'package:eam_app/pages/bengkel/widget/riwayat_item_star.dart';
import 'package:eam_app/pages/bengkel/widget/trx_process_item.dart';
import 'package:eam_app/pages/bengkel/widget/trx_success_item.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrxBengkelPage extends StatefulWidget {
  const TrxBengkelPage({super.key});

  @override
  State<TrxBengkelPage> createState() => _TrxBengkelPageState();
}

class _TrxBengkelPageState extends State<TrxBengkelPage> {
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
