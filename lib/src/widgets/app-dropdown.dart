import 'package:flutter/material.dart';
import 'package:gugu/src/gateway/dropdown-service.dart';
import 'package:gugu/src/utils/animations/shimmers/dropdown.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
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
    final apiResponse = await _dropdownService.dropdownPost(
      context,
      widget.apiUrl,
    );
    _apiData = List<Map<String, dynamic>>.from(apiResponse[widget.dataOrigin]);

    final screenWidth = MediaQuery.of(context).size.width;

    return _apiData
        .map<DropdownMenuItem<String>>(
          (item) => DropdownMenuItem<String>(
            value: item[widget.valueField].toString(),
            child: AppText(
              txt: item[widget.displayField],
              size: screenWidth * 0.038,
              color: AppConst.black,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 0, right: 0),
      child: FutureBuilder<List<DropdownMenuItem<String>>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return dropdownShimmer(
              width: screenWidth,
              height: 56,
              borderRadius: 8.0,
            );
          } else if (snapshot.hasError) {
            return Text('Failed to fetch items: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final items = snapshot.data!;
            if (items.isNotEmpty) {
              return DropdownButtonFormField<String>(
                value: _selectedValue,
                dropdownColor: widget.dropdownColor,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.circle ?? 8.0),
                    borderSide: BorderSide(
                      color: AppConst.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  label: Container(
                    color: widget.fillcolor,
                    child: AppText(
                      txt: widget.labelText,
                      size: screenWidth * 0.035,
                      weight: widget.labelWeight ?? FontWeight.w400,
                      color: AppConst.grey,
                    ),
                  ),
                  filled: true,
                  fillColor: widget.fillcolor,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.circle ?? 8.0),
                    borderSide: BorderSide(
                      color: AppConst.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.circle ?? 8.0),
                    borderSide: BorderSide(
                      color: AppConst.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.circle ?? 8.0),
                    borderSide: BorderSide(color: AppConst.primary, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.circle ?? 8.0),
                    borderSide: BorderSide(
                      color: Colors.red.shade300,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.circle ?? 8.0),
                    borderSide: BorderSide(
                      color: Colors.red.shade400,
                      width: 1.5,
                    ),
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
                },
              );
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
