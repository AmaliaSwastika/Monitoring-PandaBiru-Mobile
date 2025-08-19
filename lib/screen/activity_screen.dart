// import 'package:flutter/material.dart';
// import 'package:panda_biru/model/report_summary_model.dart';
// import 'package:panda_biru/services/report_summary_api.dart';

// class ActivityScreen extends StatefulWidget {
//   const ActivityScreen({super.key});

//   @override
//   State<ActivityScreen> createState() => _ActivityScreenState();
// }

// class _ActivityScreenState extends State<ActivityScreen> {
//   late Future<ActivityResponse> _futureActivity;

//   @override
//   void initState() {
//     super.initState();
//     _futureActivity = ActivityApi().getActivity();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Activity")),
//       body: FutureBuilder<ActivityResponse>(
//         future: _futureActivity,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.summary.isEmpty) {
//             return const Center(child: Text("No activity found"));
//           }

//           final activities = snapshot.data!.summary;

//           return ListView.builder(
//             itemCount: activities.length,
//             itemBuilder: (context, index) {
//               final act = activities[index];
//               return Card(
//                 margin: const EdgeInsets.all(8),
//                 child: ExpansionTile(
//                   title: Text("${act.username} (${act.email})"),
//                   subtitle: Text("Date: ${act.date}"),
//                   children: [
//                     if (act.attendanceData != null)
//                       ...act.attendanceData!.map((a) => ListTile(
//                             leading: const Icon(Icons.check_circle, color: Colors.green),
//                             title: Text(a.data.status),
//                             subtitle: Text("${a.data.note}\n${a.createdAt}"),
//                           )),
//                     ...act.stores.map((s) => ListTile(
//                           leading: const Icon(Icons.store),
//                           title: Text(s.storeName),
//                           subtitle: Text(s.storeAddress),
//                         )),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:panda_biru/model/report_summary_model.dart';
import 'package:panda_biru/services/report_summary_api.dart';

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
    _futureActivity = ActivityApi().getActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Activity Report")),
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
          // karena 1 akun = ambil data pertama saja

          return ListView(
            children: [
              // ================= Attendance Report =================
              Card(
  margin: const EdgeInsets.all(8),
  child: ExpansionTile(
    leading: const Icon(Icons.access_time),
    title: const Text("Report Attendance"),
    children: act.attendanceData?.map((a) {
          return ListTile(
            title: Text("Status : ${a.data.status}"),
            subtitle: Text(
              "Note : ${a.data.note.isNotEmpty ? a.data.note : '-'}\n"
              "Created : ${a.createdAt}",
            ),
          );
        }).toList() ??
        [const ListTile(title: Text("No attendance data"))],
  ),
),


              // ================= Shop Report =================
              Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  leading: const Icon(Icons.store),
                  title: const Text("Report Shop"),
                  children: act.stores.map((s) {
                    return ExpansionTile(
                      leading: const Icon(Icons.storefront),
                      title: Text(s.storeName),
                      subtitle: Text(
                              "Code: ${s.storeCode}\nAddress: ${s.storeAddress}"),
                      children: [
                        // ----- Report Product -----
                        ExpansionTile(
                          leading: const Icon(Icons.shopping_bag),
                          title: const Text("Report Product"),
                          children: s.products.map((p) {
                            return ListTile(
                              leading: Icon(
                                p.available
                                    ? Icons.check_circle
                                    : Icons.remove_circle,
                                color: p.available ? Colors.green : Colors.red,
                              ),
                              title: Text(p.product),
                              subtitle: Text(
                                  "Barcode: ${p.barcode ?? '-'}\nCreated: ${p.createdAt}"),
                            );
                          }).toList(),
                        ),

                        // ----- Report Promo -----
                        ExpansionTile(
                          leading: const Icon(Icons.local_offer),
                          title: const Text("Report Promo"),
                          children: s.promos.map((pr) {
                            return ListTile(
                              leading: const Icon(Icons.discount),
                              title: Text(pr.product),
                              subtitle: Text(
                                  "Normal: Rp ${pr.normalPrice}\nPromo: Rp ${pr.promoPrice}\nCreated: ${pr.createdAt}"),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
