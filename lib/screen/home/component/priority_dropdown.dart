import 'package:flutter/material.dart';

import '../../../component/color_component.dart';
import '../../../component/text_component.dart';

class PriorityDropdown extends StatefulWidget {
  final String initialPriority;
  final Function(String) onPriorityChanged;

  PriorityDropdown({required this.initialPriority, required this.onPriorityChanged});

  @override
  _PriorityDropdownState createState() => _PriorityDropdownState();
}

class _PriorityDropdownState extends State<PriorityDropdown> {
  late String _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.initialPriority;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {

      },
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor500,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: DropdownButton<String>(
            value: _selectedPriority,
            dropdownColor: primaryColor500,
            isDense: true,
            iconSize: 0,
            padding: EdgeInsets.zero,
            isExpanded: false,
            underline: SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedPriority = newValue!;
                widget.onPriorityChanged(_selectedPriority);
              });
            },
            items: <String>['All', 'High', 'Medium', 'Low']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: 100,
                  child: Center(
                    child: Text(
                      value,
                      style: AppTextStyles.baseTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}