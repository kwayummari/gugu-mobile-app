import 'package:flutter/material.dart';
import 'package:gugu/src/gateway/categories.dart';
import 'package:gugu/src/utils/animations/shimmers/available_courses.dart';
import 'package:gugu/src/utils/app_const.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:gugu/src/widgets/app_button.dart';
import 'package:gugu/src/widgets/app_input_text.dart';
import 'package:gugu/src/widgets/app_snackbar.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:gugu/src/widgets/printableData.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class contentsById extends StatefulWidget {
  final dynamic styleId;
  final String name;

  const contentsById({Key? key, required this.styleId, required this.name})
      : super(key: key);

  @override
  State<contentsById> createState() => _contentsByIdState();
}

class _contentsByIdState extends State<contentsById> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String selectedValue = '';
  List data = [];
  List inventory = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    hairDressers hairDresserServices = hairDressers();
    final datas = await hairDresserServices.getHairDresserById(
        context, widget.styleId.toString());
    final dataValues = await hairDresserServices.getProducts(context);
    setState(() {
      data = datas['hairDresser'];
      inventory = dataValues['products'];
      if (inventory.isNotEmpty) {
        selectedValue = '${inventory[0]['id']}-${inventory[0]['name']}';
      }
    });
  }

  Future<void> printDoc() async {
    final image = await imageFromAssetBundle(
      "assets/logo.jpg",
    );
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(image);
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
        centerTitle: true,
      ),
      bgcolor: AppConst.white,
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      child: data.isEmpty
          ? availableCoursesShimmerLoad(
              width: 400,
              height: 200,
              borderRadius: 15,
            )
          : SizedBox(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: data.length,
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
                                      SizedBox(
                                        height: 5,
                                      ),
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
                                        textfieldcontroller: phoneController,
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
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: 350,
                                        height: 55,
                                        child: AppButton(
                                          onPress: () async {
                                            if (!_formKey.currentState!
                                                .validate()) {
                                              return;
                                            }
                                            hairDressers hairDresserServices =
                                                hairDressers();
                                            final datas =
                                                await hairDresserServices
                                                    .makeOrder(
                                              context,
                                              nameController.text.toString(),
                                              phoneController.text.toString(),
                                              widget.styleId.toString(),
                                              data[index]['hairdresserId']
                                                  .toString(),
                                            );
                                            print(datas['message']);
                                            if (datas['message'] ==
                                                'Order created successfully') {
                                              Navigator.of(context).pop();
                                              // Open another dialog and pass previously sent data
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        AppConst.whiteOpacity,
                                                    title: AppText(
                                                      txt: 'Print receipt',
                                                      size: 20,
                                                      weight: FontWeight.bold,
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
                                                                printDoc();
                                                                AppSnackbar(
                                                                  isError:
                                                                      false,
                                                                  response:
                                                                      'Printing',
                                                                ).show(context);
                                                              },
                                                              label:
                                                                  'Print Receipts',
                                                              borderRadius: 5,
                                                              textColor:
                                                                  AppConst
                                                                      .white,
                                                              bcolor: AppConst
                                                                  .primary),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          label: 'Add order',
                                          borderRadius: 5,
                                          textColor: AppConst.white,
                                          bcolor: AppConst.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
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
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppConst.primary,
                              AppConst.red,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              txt: data[index]['hairDresserName'],
                              size: 18,
                              color: AppConst.white,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
