import 'package:flutter/material.dart';
import 'package:gugu/src/functions/moneyFormatter.dart';
import 'package:gugu/src/gateway/categories.dart';
import 'package:gugu/src/utils/animations/shimmers/available_courses.dart';
import 'package:gugu/src/utils/app_const.dart';
import 'package:gugu/src/utils/routes/route-names.dart';
import 'package:gugu/src/widgets/app_text.dart';

class availableHairStyles extends StatefulWidget {
  final String searchQuery;
  const availableHairStyles({Key? key, this.searchQuery = ''})
      : super(key: key);

  @override
  State<availableHairStyles> createState() => _availableHairStylesState();
}

class _availableHairStylesState extends State<availableHairStyles> {
  List data = [];
  List filteredData = [];

  void fetchData() async {
    hairDressers HairDresserServices = hairDressers();
    final datas = await HairDresserServices.getStyles(context);
    setState(() {
      data = datas['hairStyle'];
      filterData();
    });
  }

  void filterData() {
    setState(() {
      filteredData = data
          .where((item) => item['name']
              .toLowerCase()
              .contains(widget.searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didUpdateWidget(covariant availableHairStyles oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      filterData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return filteredData.isEmpty
        ? Column(
            children: List.generate(
              5, // Number of rows you want to generate
              (index) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: availableCoursesShimmerLoad(
                      width: 195,
                      height: 100,
                      borderRadius: 15,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: availableCoursesShimmerLoad(
                      width: 195,
                      height: 100,
                      borderRadius: 15,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Column(
          children: [
            SizedBox(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: filteredData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.6,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          RouteNames.getContentsById,
                          arguments: {
                            'styleId': filteredData[index]['id'],
                            'name': filteredData[index]['name'],
                            'amount': filteredData[index]['amount'],
                          },
                        ),
                        child: Container(
                          height: 100,
                          padding: EdgeInsets.all(20),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppText(
                                txt: filteredData[index]['name'],
                                size: 12,
                                color: AppConst.white,
                                weight: FontWeight.bold,
                              ),
                              AppText(
                                txt: filteredData[index]['description'],
                                size: 12,
                                color: AppConst.white,
                                weight: FontWeight.bold,
                              ),
                              FutureBuilder<String>(
                                future: formatPrice(
                                    filteredData[index]['amount'] ?? '50000',
                                    'Tzs'),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      !snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  } else {
                                    return AppText(
                                      txt: snapshot.data ?? '',
                                      color: Colors.white,
                                      weight: FontWeight.w700,
                                      size: 16,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 100,)
          ],
        );
  }
}
