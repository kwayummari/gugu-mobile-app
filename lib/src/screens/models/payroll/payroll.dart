import 'package:flutter/material.dart';
import 'package:gugu/src/gateway/categories.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:gugu/src/widgets/app_button.dart';
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
  bool reconciliation = true; // Auto-show payroll data
  List data = [];
  List filteredData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
    searchController.addListener(_filterData);
  }

  String formatPrice(dynamic number, String currencySymbol) {
    try {
      // Handle both string and number types
      int price = number is int ? number : int.parse(number.toString());
      String formattedPrice = NumberFormat('#,###').format(price);
      return formattedPrice + currencySymbol;
    } catch (e) {
      print('Error formatting price: $e, value: $number');
      return '0$currencySymbol';
    }
  }

  void fetchData() async {
    try {
      hairDressers hairDresserServices = hairDressers();
      final datas = await hairDresserServices.getPayroll(context);
      print('Payroll Response: $datas');
      if (datas != null && datas['payroll'] != null) {
        setState(() {
          data = datas['payroll'];
          filteredData = data;
        });
        print('Payroll data loaded: ${data.length} hairdressers');
      } else {
        print('No payroll data received');
        setState(() {
          data = [];
          filteredData = [];
        });
      }
    } catch (e) {
      print('Error fetching payroll: $e');
      setState(() {
        data = [];
        filteredData = [];
      });
    }
  }

  void _filterData() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredData =
          data
              .where(
                (item) => item['hairDresserName']
                    .toString()
                    .toLowerCase()
                    .contains(query),
              )
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBaseScreen(
      isFlexible: false,
      showAppBar: true,
      bgcolor: AppConst.white,
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      padding: EdgeInsets.all(0),
      appBar: AppBar(
        title: AppText(
          txt: 'Payroll',
          size: screenWidth * 0.045,
          weight: FontWeight.w600,
          color: AppConst.black,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppConst.white,
        elevation: 0,
        centerTitle: true,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * 0.02),
            TextField(
              controller: searchController,
              style: TextStyle(
                color: AppConst.black,
                fontSize: screenWidth * 0.038,
              ),
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(
                  color: AppConst.grey,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: AppConst.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: AppConst.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppConst.primary, width: 1.5),
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: AppConst.grey.withOpacity(0.5),
                  size: screenWidth * 0.05,
                ),
                filled: true,
                fillColor: AppConst.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            if (reconciliation == false)
              SizedBox(
                height: screenHeight * 0.065,
                child: AppButton(
                  onPress: () async {
                    setState(() {
                      reconciliation = true;
                    });
                    hairDressers hairDresserServices = hairDressers();
                    await hairDresserServices.reconciliation(context);
                    fetchData();
                  },
                  label: 'PERFORM RECONCILIATION',
                  borderRadius: 8,
                  textColor: AppConst.white,
                  bcolor: AppConst.primary,
                ),
              ),
            if (reconciliation == false) SizedBox(height: screenHeight * 0.02),
            if (reconciliation == false)
              AppText(
                txt:
                    'Please perform reconciliation before accessing payroll data',
                align: TextAlign.center,
                size: screenWidth * 0.035,
                weight: FontWeight.w400,
                color: AppConst.grey,
              ),
            if (reconciliation == true)
              filteredData.isEmpty
                  ? Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: screenWidth * 0.15,
                            color: AppConst.grey.withOpacity(0.5),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          AppText(
                            txt: 'No hairdressers worked today',
                            size: screenWidth * 0.04,
                            color: AppConst.grey,
                            weight: FontWeight.w500,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          AppText(
                            txt: 'Orders will show hairdressers here',
                            size: screenWidth * 0.035,
                            color: AppConst.grey.withOpacity(0.7),
                            align: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                  : SizedBox(
                    height: screenHeight,
                    child: AppListviewBuilder(
                      itemnumber: filteredData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.015),
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.04),
                            decoration: BoxDecoration(
                              color: AppConst.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppConst.grey.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    filteredData[index]['hairDresserName'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.038,
                                      color: AppConst.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  formatPrice(
                                    filteredData[index]['totalHairDresserAmount']
                                        .toString(),
                                    ' Tsh',
                                  ),
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: AppConst.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
