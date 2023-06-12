import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController editingController; // kullanıcı değer girecek
  final String placeHolder;
  final String validationText;

  const CustomFormField(
      {Key? key,
      required this.editingController,
      required this.placeHolder,
      required this.validationText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return validationText;
          }
          return null; // form alanı geçerli
        },
        controller: editingController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: placeHolder,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
