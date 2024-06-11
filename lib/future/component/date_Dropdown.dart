import 'package:flutter/material.dart';
import 'package:smaill_project/future/component/Colors.dart';
import 'package:smaill_project/future/component/Search_Form.dart';
import 'package:intl/intl.dart';

class DateDrop extends StatefulWidget {
  DateDrop({
    super.key,
    required this.value,
    required this.filedname,
  });
  final _DateDropState _state = _DateDropState();
  final OnChangeCallback value;
  final String filedname;
  void clear() {
    _state.clearText();
  }

  @override
  State<DateDrop> createState() => _state;
}

class _DateDropState extends State<DateDrop> {
  late TextEditingController todate;
  @override
  void initState() {
    todate = TextEditingController(text: widget.filedname);
    super.initState();
  }

  @override
  void dispose() {
    todate.dispose();
    super.dispose();
  }

  void clearText() {
    todate = TextEditingController(text: widget.filedname);
    setState(() {
      todate.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: TextField(
          style: const TextStyle(fontSize: 12),
          controller: todate,
          decoration: InputDecoration(
            prefixIcon:
                const Icon(Icons.calendar_today, color: greyColor, size: 20),
            labelText: widget.filedname,
            fillColor: whileColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: greyColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: greyColor),
                borderRadius: BorderRadius.circular(5.0)),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);

              setState(() {
                todate.text = formattedDate;
                widget.value(todate.text);
              });
            }
          },
        ),
      ),
    );
  }
}
