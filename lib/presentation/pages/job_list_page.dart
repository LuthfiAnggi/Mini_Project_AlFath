import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project1/presentation/pages/erorr_connection.dart';
import 'package:mini_project1/presentation/pages/erorr_server.dart';
import 'package:mini_project1/presentation/widgets/filter_dialog_content.dart';
import 'package:mini_project1/presentation/widgets/job_list_item_skeleton.dart';
import '../../bloc/job_list/job_list_bloc.dart';
import '../../bloc/job_list/job_list_event.dart';
import '../../bloc/job_list/job_list_state.dart';
import '../widgets/job_list_item_card.dart';
import '../../data/models/job_model.dart';
import 'package:http/http.dart' as http;

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  // Kita tambahkan initState untuk memanggil fungsi tes dan BLoC
  @override
  void initState() {
    super.initState();
    // 1. Panggil fungsi tes jaringan
    // _testNetworkCall();

    // 2. Panggil BLoC (ini bisa di-comment dulu jika Anda hanya ingin tes jaringan)
    context.read<JobListBloc>().add(FetchJobList());
  }


  

  // build() Anda dimulai di sini 
  @override
  Widget build(BuildContext context) {
    final Color customOutlineColor = Color(0xFFE7ECFA);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lowongan Kerja'),
        leading: IconButton(
          icon: Image.asset('assets/ic_arrow-left.png', width: 24, height: 24),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari Lowongan",
                      suffixIcon: Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: customOutlineColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: customOutlineColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: customOutlineColor, width: 2.0),
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      "assets/ic_filter.png",
                      width: 24,
                      height: 24,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        // Ini membuat sheet bisa di-scroll jika kontennya panjang
                        isScrollControlled: true, 
                        // Ini membuat sudut atasnya rounded
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                        ),
                        builder: (ctx) {
                          return FilterWidgetContent(
                            onFilterApply: () {
                              // Tutup bottom sheet
                              Navigator.pop(context);
                              // TODO: Panggil BLoC untuk filter data
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<JobListBloc, JobListState>(
                builder: (context, state) {

                  // state ketika loading bang
                  if (state is JobListLoading || state is JobListInitial) {
                    return ListView.builder(
                      itemCount: 5, // Tampilkan 5 skeleton item
                      itemBuilder: (context, index) {
                        return JobListItemSkeleton(); // Panggil widget skeleton
                      },
                    );
                  }

                  //state ketika erorr connection
                  if (state is JobListError) {
                    // --- 3. BEDAKAN TIPE ERROR ---
                    if (state.message.contains("Tidak ada koneksi")) {
                      // Tampilkan halaman error koneksi
                      return ErorrConnection(); // (Pastikan nama class-nya benar)
                    }else {
                      // TAMBAHKAN 'ELSE' UNTUK ERROR LAIN (401, 500, dll)
                      return ErorrServer(
                        onRetry: () {
                          context.read<JobListBloc>().add(FetchJobList());
                        },
                      );
                    }
                  }
                  if (state is JobListLoaded) {
                    final jobList = state.jobModel.data;
                    return ListView.builder(
                      itemCount: jobList.length,
                      itemBuilder: (context, index) {
                        final Datum jobData = jobList[index];
                        return JobListItemCard(jobData: jobData);
                      },
                    );
                  }
                  
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
