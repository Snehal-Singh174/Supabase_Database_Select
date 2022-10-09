import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supabase_database/add_dash.dart';
import 'package:supabase_database/utils.dart';

class DashList extends StatefulWidget {
  const DashList({Key? key}) : super(key: key);

  @override
  State<DashList> createState() => _DashListState();
}

class _DashListState extends State<DashList> {
  List? dashList;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    var response = await Utils.supabaseClient
        .from('dash_list')
        .select()
        .order('dash_position', ascending: true)
        .execute();
    setState(() {
      dashList = response.data.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dash List"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
        child: dashList != null
            ? GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.00,
                crossAxisSpacing: 6.00),
            physics: const BouncingScrollPhysics(),
            itemCount: dashList?.length,
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text((dashList![index]["id"]).toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 4,
                      right: 16,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.00),
                          border: Border.all(color: Colors.blue, width: 1)),
                      child: CachedNetworkImage(
                        imageUrl: dashList![index]["dash_image"],
                        height: 118.00,
                        width: 118.00,
                      ),
                    ),
                  ),
                ],
              );
            })
            : const Center(
          child: Text("No Data Found"),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Dash'),
        icon: const Icon(Icons.add),
        onPressed: _addDash,
      ),
    );
  }

  Future<void> _addDash() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const AddDash()));
  }
}
