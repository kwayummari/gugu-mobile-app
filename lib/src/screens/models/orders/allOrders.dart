import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gugu/src/gateway/categories.dart';
import 'package:gugu/src/utils/animations/shimmers/available_courses.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/utils/routes/route-names.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:gugu/src/widgets/app_button.dart';
import 'package:gugu/src/widgets/app_input_text.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:gugu/src/widgets/printableData.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ContentsById extends StatefulWidget {
  final dynamic styleId;
  final String name;
  final String amount;

  const ContentsById({
    Key? key,
    required this.styleId,
    required this.name,
    required this.amount,
  }) : super(key: key);

  @override
  State<ContentsById> createState() => _ContentsByIdState();
}

class _ContentsByIdState extends State<ContentsById> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String selectedValue = '';
  List data = [];
  List filteredData = [];
  bool isLoading = false;
  int generateRandomSixDigitNumber() {
    final random = Random();
    return 100000 + random.nextInt(900000);
  }

  var randomNumber;

  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {
      randomNumber = generateRandomSixDigitNumber();
    });
    searchController.addListener(() {
      filterData();
    });
  }

  void fetchData() async {
    hairDressers hairDresserServices = hairDressers();
    final datas = await hairDresserServices.getHairDresserById(
      context,
      widget.styleId.toString(),
    );
    setState(() {
      data = datas['hairDresser'];
      filteredData = data;
    });
  }

  void filterData() {
    setState(() {
      filteredData =
          data.where((item) {
            final hairDresserName = item['hairDresserName'].toLowerCase();
            final query = searchController.text.toLowerCase();
            return hairDresserName.contains(query);
          }).toList();
    });
  }

  Future<void> printDoc(style, amount, name, customer, customerPhone) async {
    final image = await imageFromAssetBundle("assets/logo.jpg");
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(58 * PdfPageFormat.mm, double.infinity),
        build: (pw.Context context) {
          return buildPrintableData(
            image,
            style,
            amount,
            name,
            customer,
            randomNumber,
          );
        },
      ),
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBaseScreen(
      appBar: AppBar(
        title: AppText(
          txt: widget.name,
          size: screenWidth * 0.045,
          weight: FontWeight.w600,
          color: AppConst.black,
        ),
        backgroundColor: AppConst.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppConst.black),
        actions: [
          IconButton(
            onPressed: () {
              fetchData();
            },
            icon: Icon(
              Icons.refresh_outlined,
              color: AppConst.primary,
              size: screenWidth * 0.055,
            ),
          ),
        ],
        centerTitle: true,
      ),
      bgcolor: AppConst.white,
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      isFlexible: false,
      showAppBar: true,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: TextField(
              controller: searchController,
              style: TextStyle(
                color: AppConst.black,
                fontSize: screenWidth * 0.038,
              ),
              decoration: InputDecoration(
                hintText: 'Search hairdresser',
                hintStyle: TextStyle(
                  color: AppConst.grey.withOpacity(0.5),
                  fontSize: screenWidth * 0.035,
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
          ),
          data.isEmpty
              ? Column(
                children: List.generate(
                  5,
                  (index) => Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: availableCoursesShimmerLoad(
                          width: screenWidth * 0.42,
                          height: screenHeight * 0.12,
                          borderRadius: 8,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: availableCoursesShimmerLoad(
                          width: screenWidth * 0.42,
                          height: screenHeight * 0.12,
                          borderRadius: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : SizedBox(
                height: screenHeight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: GridView.builder(
                    itemCount: filteredData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: screenWidth * 0.03,
                      mainAxisSpacing: screenHeight * 0.02,
                      childAspectRatio: 1.6,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: AppConst.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: AppText(
                                  txt: 'Make Order',
                                  size: screenWidth * 0.045,
                                  weight: FontWeight.w600,
                                  color: AppConst.black,
                                ),
                                actions: [
                                  Form(
                                    key: _formKey,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.02,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: screenHeight * 0.01),
                                          AppInputText(
                                            textsColor: AppConst.black,
                                            textfieldcontroller: nameController,
                                            ispassword: false,
                                            fillcolor: AppConst.white,
                                            label: 'Customer Name',
                                            obscure: false,
                                            isemail: false,
                                            isPhone: false,
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.015,
                                          ),
                                          AppInputText(
                                            textsColor: AppConst.black,
                                            textfieldcontroller:
                                                phoneController,
                                            ispassword: false,
                                            fillcolor: AppConst.white,
                                            label: 'Phone Number',
                                            obscure: false,
                                            isemail: false,
                                            isPhone: true,
                                            keyboardType: TextInputType.phone,
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.025,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            height: screenHeight * 0.06,
                                            child: AppButton(
                                              onPress: () async {
                                                if (!_formKey.currentState!
                                                    .validate()) {
                                                  return;
                                                }

                                                // Show the loading dialog
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (
                                                    BuildContext context,
                                                  ) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          AppConst.white,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                      ),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SpinKitCircle(
                                                            color:
                                                                AppConst
                                                                    .primary,
                                                            size:
                                                                screenWidth *
                                                                0.12,
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                screenHeight *
                                                                0.02,
                                                          ),
                                                          AppText(
                                                            txt:
                                                                'Processing your order...',
                                                            size:
                                                                screenWidth *
                                                                0.038,
                                                            color:
                                                                AppConst.black,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );

                                                // Perform the order operation
                                                try {
                                                  hairDressers
                                                  hairDresserServices =
                                                      hairDressers();
                                                  final datas =
                                                      await hairDresserServices
                                                          .makeOrder(
                                                            context,
                                                            nameController.text
                                                                .toString(),
                                                            phoneController.text
                                                                .toString(),
                                                            widget.styleId
                                                                .toString(),
                                                            filteredData[index]['hairdresserId']
                                                                .toString(),
                                                            randomNumber
                                                                .toString(),
                                                          );

                                                  // Close the loading dialog
                                                  Navigator.pop(context);

                                                  // If the order is successful
                                                  if (datas != null &&
                                                      datas['message'] ==
                                                          'Order created successfully') {
                                                    Navigator.of(context).pop();
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (
                                                        BuildContext context,
                                                      ) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              AppConst.white,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                          ),
                                                          content: Padding(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  vertical:
                                                                      screenHeight *
                                                                      0.02,
                                                                ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .check_circle_outline,
                                                                  color:
                                                                      AppConst
                                                                          .primary,
                                                                  size:
                                                                      screenWidth *
                                                                      0.2,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      screenHeight *
                                                                      0.02,
                                                                ),
                                                                AppText(
                                                                  txt:
                                                                      'Order Created Successfully!',
                                                                  size:
                                                                      screenWidth *
                                                                      0.045,
                                                                  weight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color:
                                                                      AppConst
                                                                          .black,
                                                                  align:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      screenHeight *
                                                                      0.01,
                                                                ),
                                                                AppText(
                                                                  txt:
                                                                      'Receipt: ${randomNumber}',
                                                                  size:
                                                                      screenWidth *
                                                                      0.035,
                                                                  color:
                                                                      AppConst
                                                                          .grey,
                                                                  align:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      screenHeight *
                                                                      0.005,
                                                                ),
                                                                AppText(
                                                                  txt:
                                                                      'Customer will receive SMS confirmation',
                                                                  size:
                                                                      screenWidth *
                                                                      0.03,
                                                                  color:
                                                                      AppConst
                                                                          .grey,
                                                                  align:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    screenWidth *
                                                                    0.04,
                                                                vertical:
                                                                    screenHeight *
                                                                    0.01,
                                                              ),
                                                              child: SizedBox(
                                                                width:
                                                                    double
                                                                        .infinity,
                                                                height:
                                                                    screenHeight *
                                                                    0.06,
                                                                child: AppButton(
                                                                  onPress: () {
                                                                    Navigator.pushNamedAndRemoveUntil(
                                                                      context,
                                                                      RouteNames
                                                                          .bottomNavigationBar,
                                                                      (_) =>
                                                                          false,
                                                                    );
                                                                  },
                                                                  label:
                                                                      'GO TO HOME',
                                                                  borderRadius:
                                                                      8,
                                                                  textColor:
                                                                      AppConst
                                                                          .white,
                                                                  bcolor:
                                                                      AppConst
                                                                          .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    // Order failed - show error
                                                    Navigator.of(context).pop();
                                                  }
                                                } catch (e) {
                                                  // Close loading dialog on error
                                                  Navigator.pop(context);
                                                  // Close order dialog
                                                  Navigator.of(context).pop();
                                                  print(
                                                    'Order creation error: ${e.toString()}',
                                                  );
                                                }
                                              },
                                              label: 'CREATE ORDER',
                                              borderRadius: 8,
                                              textColor: AppConst.white,
                                              bcolor: AppConst.primary,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.015,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                            color: AppConst.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppConst.grey.withOpacity(0.2),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppConst.grey.withOpacity(0.08),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                filteredData[index]['hairDresserName'],
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.038,
                                  color: AppConst.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
