import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gugu/src/gateway/expenses.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/widgets/app-dropdown.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:gugu/src/widgets/app_button.dart';
import 'package:gugu/src/widgets/app_input_text.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var fullname;
  var valueHolder;

  @override
  void initState() {
    getName();
    super.initState();
  }

  Future<String> getName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('name');
    setState(() {
      fullname = name.toString();
    });
    return name.toString();
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppConst.white,
          title: const Text('Confirm Submission'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                txt: 'Amount: ${amount.text}',
                size: 20,
                color: AppConst.black,
                weight: FontWeight.bold,
              ),
              AppText(
                txt: 'Description: ${description.text}',
                size: 15,
                color: AppConst.black,
                weight: FontWeight.normal,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await submitExpense(); // Proceed with submission
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> submitExpense() async {
    setState(() {
      isLoading = true;
    });
    final String result = await expensesServices().expenses(
      context,
      valueHolder.toString(),
      amount.text.toString(),
      description.text.toString(),
    );
    if (result == 'success') {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AppBaseScreen(
        bgcolor: AppConst.white,
        isvisible: false,
        backgroundImage: false,
        backgroundAuth: false,
        padding: EdgeInsets.all(0),
        appBar: AppBar(
          title: AppText(
            txt: 'Add Expenses',
            size: 20,
            weight: FontWeight.bold,
            color: AppConst.white,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: AppConst.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
        ),
        isFlexible: true,
        showAppBar: true,
        child: Column(
          children: [
            SizedBox(height: 20),
            DropdownTextFormField(
              labelText: 'Expense Type',
              fillcolor: AppConst.white,
              apiUrl: 'getExpenses',
              valueField: 'id',
              valueHolder: valueHolder,
              displayField: 'name',
              dropdownColor: AppConst.white,
              dataOrigin: 'data',
              onChanged: (value) {
                setState(() {
                  valueHolder = value;
                });
              },
            ),
            SizedBox(height: 20),
            AppInputText(
              textsColor: AppConst.black,
              textfieldcontroller: amount,
              ispassword: false,
              fillcolor: AppConst.white,
              label: 'Amount',
              obscure: false,
              icon: Icon(Icons.money, color: AppConst.black),
              isemail: false,
              isPhone: false,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            AppInputText(
              textsColor: AppConst.black,
              textfieldcontroller: description,
              ispassword: false,
              fillcolor: AppConst.white,
              label: 'Description',
              obscure: false,
              icon: Icon(Icons.text_fields, color: AppConst.black),
              isemail: false,
              isPhone: false,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            isLoading
                ? SpinKitCircle(color: AppConst.primary)
                : Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 55,
                    child: AppButton(
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          await showConfirmationDialog(context);
                        }
                      },
                      label: 'Submit',
                      borderRadius: 5,
                      textColor: AppConst.white,
                      bcolor: AppConst.primary,
                    ),
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}