import 'package:flutter/material.dart';

class NumberPickerWidget extends StatefulWidget {
  const NumberPickerWidget({super.key});

  @override
  _NumberPickerWidgetState createState() => _NumberPickerWidgetState();
}

class _NumberPickerWidgetState extends State<NumberPickerWidget> {
  int _selectedNumber = 1;
  String _selectedUnit = '일';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ClipRect(
                  child: Column(
                    children: List.generate(
                      30,
                      (index) => ListTile(
                        title: Text('${index + 1}'),
                        onTap: () {
                          setState(() {
                            _selectedNumber = index + 1;
                          });
                        },
                        selected: _selectedNumber == index + 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            DropdownButton<String>(
              value: _selectedUnit,
              onChanged: (String? value) {
                setState(() {
                  _selectedUnit = value!;
                });
              },
              items: <String>['일', '주', '월']
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('$_selectedNumber $_selectedUnit'),
            ),
          ],
        ),
      ),
    );
  }
}
