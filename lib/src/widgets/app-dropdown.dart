import 'package:flutter/material.dart';
import 'package:gugu/src/gateway/dropdown-service.dart';
import 'package:gugu/src/utils/animations/shimmers/dropdown.dart';
import 'package:gugu/src/utils/app_const.dart';
import 'package:gugu/src/widgets/app_text.dart';

// ignore: must_be_immutable
class DropdownTextFormField extends StatefulWidget {
  final String labelText;
  final Icon? icon;
  final Color? fillcolor;
  final Color? dropdownColor;
  final IconButton? suffixicon;
  final String apiUrl;
  final String valueField;
  final String displayField;
  final String dataOrigin;
  final Color? textsColor;
  final bool? fetchSupplier;
  final double? circle;
  final labelWeight;
  String? valueHolder;
  final Function(String?)? onChanged;

  DropdownTextFormField({
    required this.labelText,
    this.icon,
    this.suffixicon,
    required this.fillcolor,
    required this.dropdownColor,
    required this.apiUrl,
    required this.valueField,
    required this.displayField,
    required this.dataOrigin,
    this.fetchSupplier,
    this.textsColor,
    this.circle,
    this.labelWeight,
    this.valueHolder,
    this.onChanged,
  });

  @override
  State<DropdownTextFormField> createState() => _DropdownTextFormFieldState();
}

class _DropdownTextFormFieldState extends State<DropdownTextFormField> {
  late Future<List<DropdownMenuItem<String>>> _itemsFuture;
  String? _selectedValue;
  late List<Map<String, dynamic>> _apiData;

  @override
  void initState() {
    super.initState();
    _itemsFuture = _getItems();
  }

  @override
  void didUpdateWidget(DropdownTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.fetchSupplier != oldWidget.fetchSupplier &&
        widget.fetchSupplier == true) {
      setState(() {
        _itemsFuture = _getItems();
      });
    }
  }

  Future<List<DropdownMenuItem<String>>> _getItems() async {
    final dropdownService _dropdownService = await dropdownService();
    final apiResponse =
        await _dropdownService.dropdownPost(context, widget.apiUrl);
    _apiData = List<Map<String, dynamic>>.from(apiResponse[widget.dataOrigin]);

    return _apiData
        .map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
              value: item[widget.valueField].toString(),
              child: AppText(
                txt: item[widget.displayField],
                size: 15,
                color: AppConst.black,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: FutureBuilder<List<DropdownMenuItem<String>>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return dropdownShimmer(width: 400, height: 50, borderRadius: 5.0);
          } else if (snapshot.hasError) {
            return Text('Failed to fetch items: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final items = snapshot.data!;
            if (items.isNotEmpty) {
              return DropdownButtonFormField<String>(
                  value: _selectedValue,
                  dropdownColor: widget.dropdownColor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.circle ?? 5.0),
                    ),
                    label: Container(
                      color: widget.fillcolor,
                      child: AppText(
                        txt: widget.labelText,
                        size: 15,
                        weight: widget.labelWeight ?? FontWeight.w700,
                        color: widget.textsColor ?? AppConst.black,
                      ),
                    ),
                    filled: true,
                    fillColor: widget.fillcolor,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.circle ?? 5.0),
                      borderSide: BorderSide(color: AppConst.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.circle ?? 5.0),
                      borderSide: BorderSide(color: AppConst.black),
                    ),
                    prefixIcon: widget.icon,
                    suffixIcon: widget.suffixicon,
                  ),
                  items: items,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(value);
                    }
                  });
            } else {
              return Text('No items found');
            }
          } else {
            return Text('Unexpected state');
          }
        },
      ),
    );
  }
}
