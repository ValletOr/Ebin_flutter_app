import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppCheckbox extends StatefulWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  late bool _isChecked;

  @override
  Widget build(BuildContext context) {
    _isChecked = widget.value;
    return Checkbox(
      value: _isChecked,
      onChanged: changeValue,
    );
  }

  void changeValue(bool? value) {
    setState(() {
      _isChecked = value!;
    });
    widget.onChanged(value!);
  }
}
