import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

TextStyle headTextStyle() {
  return const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}

TextStyle subTitle() {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );
}

InputDecoration appInputStyle(label, {IconButton}){
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      fillColor: Colors.white,
      filled: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      hintText: label,
      suffixIcon: IconButton,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ));
}

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    padding: const EdgeInsets.symmetric(vertical: 20),
    shadowColor: const Color(0x00000004),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    elevation: 4,
  );
}


PinTheme appOTPStyle() {
  return PinTheme(
    inactiveColor: Colors.grey,
    inactiveFillColor: Colors.white,
    selectedColor: Colors.green,
    activeColor: Colors.white,
    selectedFillColor: Colors.green,
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(5),
    fieldHeight: 50,
    borderWidth: 0.5,
    fieldWidth: 50,
    activeFillColor: Colors.white,
  );
}
