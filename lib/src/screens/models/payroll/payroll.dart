import 'package:flutter/material.dart';
import 'package:gugu/src/gateway/categories.dart';
import 'package:gugu/src/utils/animations/shimmers/available_courses.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:gugu/src/widgets/app_button.dart';
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
  bool reconciliation = false;
  List data = [];
  List filteredData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
    searchController.addListener(_filterData);
  }

  String formatPrice(String number, String currencySymbol) {
    int price = int.parse(number);
    String formattedPrice = NumberFormat('#,###').format(price);
    return formattedPrice + currencySymbol;
  }

  void fetchData() async {
    hairDressers hairDresserServices = hairDressers();
    final datas = await hairDresserServices.getPayroll(context);
    setState(() {
      data = datas['payroll'];
      filteredData = data;
    });
  }

  void _filterData() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredData = data
          .where((item) =>
              item['hairDresserName'].toString().toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search by Hairdresser Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: AppConst.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: AppConst.black, width: 1.0),
                  ),
                ),
              ),
            ),
            if (reconciliation == false)
              Container(
                width: 350,
                height: 55,
                child: AppButton(
                  onPress: () async {
                    setState(() {
                      reconciliation = true;
                    });
                    hairDressers hairDresserServices = hairDressers();
                    final datas =
                        await hairDresserServices.reconciliation(context);
                    fetchData();
                  },
                  label: 'Perform reconciliation',
                  borderRadius: 5,
                  textColor: AppConst.white,
                  bcolor: AppConst.primary,
                ),
              ),
            if (reconciliation == false)
              AppText(
                txt:
                    'Please perform reconciliation before accessing payroll data',
                align: TextAlign.center,
                size: 20,
                weight: FontWeight.bold,
              ),
            if (reconciliation == true)
              data.isEmpty
                  ? Column(
                      children: List.generate(
                        10,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: availableCoursesShimmerLoad(
                            width: MediaQuery.of(context).size.width - 20,
                            height: 50,
                            borderRadius: 5,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: AppListviewBuilder(
                          itemnumber: filteredData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: AppListTile(
                                title: AppText(
                                  txt: filteredData[index]['hairDresserName'],
                                  size: 15,
                                  color: AppConst.black,
                                  weight: FontWeight.bold,
                                ),
                                trailing: AppText(
                                  txt: formatPrice(
                                      filteredData[index]
                                              ['totalHairDresserAmount']
                                          .toString(),
                                      'Tsh'),
                                  size: 15,
                                  color: AppConst.black,
                                  weight: FontWeight.normal,
                                ),
                              ),
                            );
                          }),
                    ),
          ],
        ));
  }
}
