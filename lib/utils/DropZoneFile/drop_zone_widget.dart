import 'dart:io';

import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

import 'model/file_drop_item.dart';

class DropZoneWidget extends StatefulWidget {
  final ValueChanged<File_Data_Model> onDroppedFile;

  const DropZoneWidget({Key key, this.onDroppedFile}) : super(key: key);

  @override
  _DropZoneWidgetState createState() => _DropZoneWidgetState();
}

class _DropZoneWidgetState extends State<DropZoneWidget> {
  DropzoneViewController controller;
  bool highlight = false;

  @override
  Widget build(BuildContext context) {
    return buildDecoration(
        child: Stack(
      children: [
        DropzoneView(
          onCreated: (controller) => this.controller = controller,
          onDrop: UploadedFile,
          onHover: () => setState(() => highlight = true),
          onLeave: () => setState(() => highlight = false),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_upload_outlined,
                size: 45,
                color: Colors.white,
              ),
              const Text(
                'Drop Files Here',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: highlight ? primaryColor2 : primaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                    child: InkWell(
                      onTap: () async {
                        final events = await controller.pickFiles();
                        if (events.isEmpty) return;
                        UploadedFile(events.first);
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Icon(
                                Icons.search,
                                color: spaceColor,
                              ),
                            ),
                            const CustomText(
                              text: "Choose file",
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Future UploadedFile(dynamic event) async {
    final name = event.name;

    final mime = await controller.getFileMIME(event);
    final byte = await controller.getFileSize(event);
    final file = await controller.getFileData(event);

    print('Name : $name');
    print('Mime: $mime');

    // print('Size : ${byte / (1024 * 1024)}');

    final droppedFile = File_Data_Model(
      name: name,
      mime: mime,
      bytes: file,
    );

    widget.onDroppedFile(droppedFile);
    setState(() {
      highlight = false;
    });
  }

  Widget buildDecoration({Widget child}) {
    final colorBackground = highlight ? primaryColor2 : primaryColor;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: child,
        color: colorBackground,
      ),
    );
  }
}
