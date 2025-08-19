import 'package:flutter/material.dart';
import 'package:panda_biru/model/report_summary_model.dart';
import 'package:panda_biru/services/report_summary_api.dart';
import 'package:panda_biru/theme/theme_color.dart';
import 'package:panda_biru/theme/theme_text_style.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late Future<ActivityResponse> _futureActivity;

  @override
  void initState() {
    super.initState();
    _futureActivity = ActivityAPI().getActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor().whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: ThemeColor().blueColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Activity Report",
            style: ThemeTextStyle().appBar,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
      ),
      body: FutureBuilder<ActivityResponse>(
        future: _futureActivity,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.summary.isEmpty) {
            return const Center(child: Text("No activity found"));
          }

          final act = snapshot.data!.summary.first;

          return Padding(
          padding: const EdgeInsets.only(top: 25.0), 
          child: ListView(
            children: [
            //report attendance
              Card(
                color: ThemeColor().whiteColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: ThemeColor().blueColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  leading: Icon(Icons.access_time, color: ThemeColor().blueColor),
                  title: Text("Report Attendance", style: ThemeTextStyle().activityReport,),
                  children: act.attendanceData?.map((a) {
                    return ListTile(
                      title: Text("Status : ${a.data.status}", style: ThemeTextStyle().activityReport2),
                      subtitle: Text(
                        "Note : ${a.data.note.isNotEmpty ? a.data.note : '-'}\n"
                        "Created : ${a.createdAt}", style: ThemeTextStyle().activityReport2
                      ),
                    );
                  }).toList() ??
                  [const ListTile(title: Text("No attendance data"))],
                ),
              ),

              //report shop
              Card(
                color: ThemeColor().whiteColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: ThemeColor().blueColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  leading: Icon(Icons.store, color: ThemeColor().blueColor),
                  title: Text("Report Shop", style: ThemeTextStyle().activityReport,),
                  children: act.stores.map((s) {
                    return ExpansionTile(
                      leading: Icon(Icons.storefront, color: ThemeColor().blueColor),
                      title: Text(s.storeName, style: ThemeTextStyle().activityReport3),
                      subtitle: Text(
                        "Code: ${s.storeCode}\nAddress: ${s.storeAddress}",style: ThemeTextStyle().activityReport2
                      ),
                  children: [
                  //report product
                  ExpansionTile(
                    leading: Icon(Icons.shopping_bag, color: ThemeColor().blueColor),
                    title: Text("Report Product",style: ThemeTextStyle().activityReport3),
                    children: s.products.map((p) {
                      return ListTile(
                        leading: Icon(
                          p.available
                          ? Icons.check_circle
                          : Icons.remove_circle,
                          color: p.available ? Colors.green : Colors.red,
                       ),
                        title: Text(p.product, style: ThemeTextStyle().activityReport3),
                        subtitle: Text(
                          "Barcode: ${p.barcode ?? '-'}\nCreated: ${p.createdAt}", style: ThemeTextStyle().activityReport2),
                      );
                    }).toList(),
                  ),

                  //report promo
                  ExpansionTile(
                    leading: Icon(Icons.local_offer, color: ThemeColor().blueColor),
                    title: Text("Report Promo", style: ThemeTextStyle().activityReport3),
                    children: s.promos.map((pr) {
                      return ListTile(
                       leading: const Icon(Icons.discount),
                        title: Text(pr.product, style: ThemeTextStyle().activityReport3),
                        subtitle: Text(
                          "Normal: Rp ${pr.normalPrice}\nPromo: Rp ${pr.promoPrice}\nCreated: ${pr.createdAt}", style: ThemeTextStyle().activityReport2),
                        );
                      }).toList(),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
        },
      ),
    );
  }
}