import 'package:flutter/material.dart';

Widget buildDropdown(String label,
    String? value,
    List<String> options,
    void Function(String?) onChanged,) {
  return Padding(
    padding: const EdgeInsets.all(8.0,),
    child: DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      items: options
          .map((option) =>
          DropdownMenuItem(
            value: option,
            child: Text(option, style: TextStyle(color: Colors.black,),),
          ),)
          .toList(),
      decoration: InputDecoration(
        //labelText: label,
        hintText: label,
        hintStyle:  TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.white,
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.white,
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 14,),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.withOpacity(0.4,),),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black54, width: 1.5,),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade700, width: 1.5,),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12,),
          borderSide: BorderSide(color: Colors.red.shade700, width: 1.5,),
        ),
      ),
      onChanged: onChanged,
      validator: (value) =>
      value == null || value.isEmpty
          ? 'Please select $label'
          : null,
    ),
  );
}