import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_database/dash_list.dart';
import 'package:supabase_database/utils.dart';

class AddDash extends StatefulWidget {
  const AddDash({Key? key}) : super(key: key);

  @override
  State<AddDash> createState() => _AddDashState();
}

class _AddDashState extends State<AddDash> {
  String? selectedImagePath;
  String? dashPath;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Dash"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 4,
            right: 16,
          ),
          child: selectedImagePath != null
              ? Container(
                  width: 118.0,
                  height: 118.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.00),
                    border: Border.all(color: Colors.blue, width: 1),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: selectedImagePath!,
                    height: 118.00,
                    width: 118.00,
                    fit: BoxFit.cover,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Stack(fit: StackFit.loose, children: <Widget>[
                    Container(
                        width: 118.0,
                        height: 118.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.00),
                          border: Border.all(color: Colors.blue, width: 1),
                          image: const DecorationImage(
                            image: ExactAssetImage('assets/images/img.png'),
                          ),
                        )),
                    InkWell(
                      onTap: () async {
                        _getFromGallery();
                      },
                      child: const Padding(
                          padding: EdgeInsets.only(top: 80.0, left: 79),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 25.0,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ]),
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.redAccent,
              primaryColorDark: Colors.red,
            ),
            child: TextFormField(
              controller: textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                hintText: 'Tell us about dash',
                helperText: 'Keep it short, this is just a demo.',
                labelText: 'Dash Name',
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 20.0, left: 50, right: 50),
          child: OutlinedButton(
            onPressed: () async {
              final res = await Utils.supabaseClient.from('dash_list').insert([
                {
                  'dash_name': textEditingController.text,
                  'dash_image': dashPath
                }
              ]).execute();
              if (res.status == 201) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const DashList()));
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
            ),
            child: const Text(
              "Insert Dash",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }

  _getFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      final res = await Utils.supabaseClient.storage
          .from('dash-images')
          .upload(pickedFile.path, selectedImage);
      setState(() {
        selectedImagePath =
            '${Utils.supabaseUrl}/storage/v1/object/public/${res.data!}';
        dashPath = '${Utils.supabaseUrl}/storage/v1/object/public/${res.data!}';
      });
    }
  }
}
