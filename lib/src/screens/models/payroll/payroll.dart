import 'package:gugu/src/gateway/categories.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:gugu/src/widgets/app_listTile.dart';
import 'package:gugu/src/widgets/app_listview_builder.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:intl/intl.dart';

class Payroll extends StatefulWidget {
  const Payroll({Key? key}) : super(key: key);

  @override
  State<Payroll> createState() => _PayrollState();
}

class _PayrollState extends State<Payroll> {
  bool isLoading = false;
  List data = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String formatPrice(String number, String currencySymbol) {
    int price = int.parse(number);
    String formattedPrice = NumberFormat('#,###').format(price);
    return 'Amount: ' + formattedPrice + currencySymbol;
  }

  void fetchData() async {
    hairDressers hairDresserServices = hairDressers();
    final datas = await hairDresserServices.getPayroll(context);
    setState(() {
      data = datas['payroll'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
        isFlexible: true,
        showAppBar: true,
        bgcolor: AppConst.white,
        isvisible: false,
        backgroundImage: false,
        backgroundAuth: false,
        padding: EdgeInsets.all(0),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppConst.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        child: Column(
          children: [
            AppListviewBuilder(
                itemnumber: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return AppListTile(
                    title: AppText(
                      txt: data[index]['hairDresserName'],
                      size: 15,
                      color: AppConst.black,
                      weight: FontWeight.bold,
                    ),
                    trailing: AppText(
                      txt: formatPrice(
                          data[index]['totalHairDresserAmount'].toString(),
                          'Tsh'),
                      size: 15,
                      color: AppConst.black,
                      weight: FontWeight.normal,
                    ),
                  );
                })
          ],
        ));
  }
}
