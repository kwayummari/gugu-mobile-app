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
    final screenWidth = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppConst.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: AppText(
            txt: 'Confirm Submission',
            size: screenWidth * 0.045,
            color: AppConst.black,
            weight: FontWeight.w600,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    txt: 'Amount: ',
                    size: screenWidth * 0.035,
                    color: AppConst.grey,
                    weight: FontWeight.w400,
                  ),
                  AppText(
                    txt: '${amount.text}',
                    size: screenWidth * 0.038,
                    color: AppConst.black,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(height: 8),
              AppText(
                txt: 'Description: ',
                size: screenWidth * 0.035,
                color: AppConst.grey,
                weight: FontWeight.w400,
              ),
              SizedBox(height: 4),
              AppText(
                txt: '${description.text}',
                size: screenWidth * 0.035,
                color: AppConst.black,
                weight: FontWeight.w400,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: AppText(
                txt: 'Cancel',
                size: screenWidth * 0.035,
                color: AppConst.grey,
                weight: FontWeight.w500,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: AppText(
                txt: 'Confirm',
                size: screenWidth * 0.035,
                color: AppConst.primary,
                weight: FontWeight.w600,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await submitExpense();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> submitExpense() async {
    try {
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
        // Clear form fields on success
        amount.clear();
        description.clear();
        setState(() {
          valueHolder = null;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Expense submission error: ${e.toString()}');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
            txt: 'Expenses',
            size: screenWidth * 0.045,
            weight: FontWeight.w600,
            color: AppConst.black,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: AppConst.white,
          elevation: 0,
          centerTitle: true,
        ),
        isFlexible: false,
        showAppBar: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.03),
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
              SizedBox(height: screenHeight * 0.02),
              AppInputText(
                textsColor: AppConst.black,
                textfieldcontroller: amount,
                ispassword: false,
                fillcolor: AppConst.white,
                label: 'Amount',
                obscure: false,
                isemail: false,
                isPhone: false,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: screenHeight * 0.02),
              AppInputText(
                textsColor: AppConst.black,
                textfieldcontroller: description,
                ispassword: false,
                fillcolor: AppConst.white,
                label: 'Description',
                obscure: false,
                isemail: false,
                isPhone: false,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: screenHeight * 0.04),
              isLoading
                  ? Center(
                    child: SpinKitCircle(
                      color: AppConst.primary,
                      size: screenWidth * 0.1,
                    ),
                  )
                  : SizedBox(
                    height: screenHeight * 0.065,
                    child: AppButton(
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          await showConfirmationDialog(context);
                        }
                      },
                      label: 'SUBMIT',
                      borderRadius: 8,
                      textColor: AppConst.white,
                      bcolor: AppConst.primary,
                    ),
                  ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
