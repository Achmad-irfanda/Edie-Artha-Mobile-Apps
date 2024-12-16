import 'package:flutter/material.dart';

Future loadingDialog({
  required context,
}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(0), // Set to 0 for no border radius
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              Padding(
                  padding: EdgeInsets.only(left: 10), child: Text("Loading")),
            ],
          ),
        ),
      );
    },
  );
}
