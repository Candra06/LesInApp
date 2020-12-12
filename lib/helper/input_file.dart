import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';

class FormInputFile extends StatefulWidget {
  final VoidCallback onTap;
  final PlatformFile label;
  const FormInputFile({
    Key key,
    this.onTap,
    this.label,
  }) : super(key: key);

  @override
  _FormInputFileState createState() => _FormInputFileState();
}

class _FormInputFileState extends State<FormInputFile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Material(
      color: Colors.grey[300],
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: InkWell(
        highlightColor: Colors.white.withOpacity(0.5),
        onTap: () {
          this.widget.onTap();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Container(
            height: 48,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text(
                    widget.label == null ? "Pilih File" : widget.label.name,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Config.textBlack,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}