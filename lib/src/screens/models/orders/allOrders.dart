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

  const ContentsById(
      {Key? key,
      required this.styleId,
      required this.name,
      required this.amount})
      : super(key: key);

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
        context, widget.styleId.toString());
    setState(() {
      data = datas['hairDresser'];
      filteredData = data;
    });
  }

  void filterData() {
    setState(() {
      filteredData = data.where((item) {
        final hairDresserName = item['hairDresserName'].toLowerCase();
        final query = searchController.text.toLowerCase();
        return hairDresserName.contains(query);
      }).toList();
    });
  }

  Future<void> printDoc(style, amount, name, customer, customerPhone) async {
    final image = await imageFromAssetBundle(
      "assets/logo.jpg",
    );
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat(58 * PdfPageFormat.mm, double.infinity),
        build: (pw.Context context) {
          return buildPrintableData(
              image, style, amount, name, customer, randomNumber);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      appBar: AppBar(
        title: AppText(
          txt: widget.name,
          size: 20,
          weight: FontWeight.bold,
        ),
        actions: [
          IconButton(
              onPressed: () {
                fetchData();
              },
              icon: Icon(
                Icons.refresh,
                color: AppConst.primary,
              ))
        ],
        centerTitle: true,
      ),
      bgcolor: AppConst.white,
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      isFlexible: true,
      showAppBar: true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Hairdresser...',
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
          data.isEmpty
              ? Column(
                  children: List.generate(
                    5,
                    (index) => Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: availableCoursesShimmerLoad(
                            width: 190,
                            height: 100,
                            borderRadius: 15,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: availableCoursesShimmerLoad(
                            width: 190,
                            height: 100,
                            borderRadius: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: filteredData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.6,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: AppConst.whiteOpacity,
                                  title: AppText(
                                    txt: 'Make Order',
                                    size: 20,
                                    weight: FontWeight.bold,
                                  ),
                                  actions: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 5),
                                          AppInputText(
                                            textsColor: AppConst.black,
                                            textfieldcontroller: nameController,
                                            ispassword: false,
                                            fillcolor: AppConst.white,
                                            label: 'Name',
                                            obscure: false,
                                            icon: Icon(
                                              Icons.person_2,
                                              color: AppConst.black,
                                            ),
                                            isemail: false,
                                            isPhone: false,
                                          ),
                                          AppInputText(
                                            textsColor: AppConst.black,
                                            textfieldcontroller:
                                                phoneController,
                                            ispassword: false,
                                            fillcolor: AppConst.white,
                                            label: 'Phone',
                                            obscure: false,
                                            icon: Icon(
                                              Icons.phone,
                                              color: AppConst.black,
                                            ),
                                            isemail: false,
                                            isPhone: true,
                                          ),
                                          SizedBox(height: 20),
                                          Container(
                                            width: 350,
                                            height: 55,
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          AppConst.whiteOpacity,
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SpinKitCircle(
                                                            color: AppConst
                                                                .primary,
                                                            size: 50.0,
                                                          ),
                                                          SizedBox(height: 20),
                                                          AppText(
                                                            txt:
                                                                'Processing your order...',
                                                            size: 18,
                                                            color:
                                                                AppConst.black,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );

                                                // Perform the order operation
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
                                                  widget.styleId.toString(),
                                                  filteredData[index]
                                                          ['hairdresserId']
                                                      .toString(),
                                                  randomNumber.toString(),
                                                );

                                                // Close the loading dialog
                                                Navigator.pop(context);

                                                // If the order is successful
                                                if (datas['message'] ==
                                                    'Order created successfully') {
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            AppConst
                                                                .whiteOpacity,
                                                        title: AppText(
                                                          txt: 'Print receipt',
                                                          size: 20,
                                                          weight:
                                                              FontWeight.bold,
                                                        ),
                                                        actions: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 55,
                                                              child: AppButton(
                                                                onPress: () {
                                                                  printDoc(
                                                                      widget
                                                                          .name,
                                                                      widget
                                                                          .amount,
                                                                      filteredData[
                                                                              index]
                                                                          [
                                                                          'hairDresserName'],
                                                                      nameController
                                                                          .text
                                                                          .toString(),
                                                                      phoneController
                                                                          .text
                                                                          .toString());
                                                                  Navigator
                                                                      .pushNamedAndRemoveUntil(
                                                                    context,
                                                                    RouteNames
                                                                        .bottomNavigationBar,
                                                                    (_) =>
                                                                        false,
                                                                  );
                                                                  // Navigator.of(
                                                                  //         context)
                                                                  //     .pop();
                                                                  // AppSnackbar(
                                                                  //   isError:
                                                                  //       false,
                                                                  //   response:
                                                                  //       'Printing',
                                                                  // ).show(
                                                                  //     context);
                                                                },
                                                                label:
                                                                    'Print Receipts',
                                                                borderRadius: 5,
                                                                textColor:
                                                                    AppConst
                                                                        .white,
                                                                bcolor: AppConst
                                                                    .primary,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              label: 'create order',
                                              borderRadius: 5,
                                              textColor: AppConst.white,
                                              bcolor: AppConst.primary,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              gradient: AppConst.primaryGradient,
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  txt: filteredData[index]['hairDresserName'],
                                  size: 18,
                                  color: AppConst.white,
                                  weight: FontWeight.bold,
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
