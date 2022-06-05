import 'package:flutter/material.dart';

inputDecoration({Widget? label, required labelText}) {
  return InputDecoration(
      isDense: true,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.black, width: 0.0),
        // borderSide: BorderSide(width: 1, color: textFieldLabelColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.red, width: 0.0),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.purple, width: 0.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.never);
}