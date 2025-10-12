import 'package:flutter/material.dart';
import 'package:gugu/src/functions/moneyFormatter.dart';
import 'package:gugu/src/gateway/categories.dart';
import 'package:gugu/src/utils/animations/shimmers/available_courses.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/utils/routes/route-names.dart';
import 'package:gugu/src/widgets/app_text.dart';

class AvailableHairStyles extends StatefulWidget {
  final String searchQuery;
  const AvailableHairStyles({Key? key, this.searchQuery = ''})
    : super(key: key);

  @override
  State<AvailableHairStyles> createState() => _AvailableHairStylesState();
}

class _AvailableHairStylesState extends State<AvailableHairStyles> {
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
      filteredData =
          data
              .where(
                (item) => item['name'].toLowerCase().contains(
                  widget.searchQuery.toLowerCase(),
                ),
              )
              .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didUpdateWidget(covariant AvailableHairStyles oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      filterData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return filteredData.isEmpty
        ? Column(
          children: List.generate(
            5,
            (index) => Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: availableCoursesShimmerLoad(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    borderRadius: 12,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: availableCoursesShimmerLoad(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.15,
                    borderRadius: 12,
                  ),
                ),
              ],
            ),
          ),
        )
        : Column(
          children: [
            SizedBox(
              height: screenHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: GridView.builder(
                  itemCount: filteredData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.03,
                    mainAxisSpacing: screenHeight * 0.02,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap:
                          () => Navigator.pushNamed(
                            context,
                            RouteNames.getContentsById,
                            arguments: {
                              'styleId': filteredData[index]['id'],
                              'name': filteredData[index]['name'],
                              'amount': filteredData[index]['amount'],
                            },
                          ),
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: AppConst.white,
                          borderRadius: BorderRadius.circular(12),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Service name
                            Text(
                              filteredData[index]['name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: screenWidth * 0.038,
                                color: AppConst.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.008),
                            // Description (if exists)
                            if (filteredData[index]['description'] != null &&
                                filteredData[index]['description']
                                    .toString()
                                    .isNotEmpty)
                              Expanded(
                                child: Text(
                                  filteredData[index]['description'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: AppConst.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            SizedBox(height: screenHeight * 0.01),
                            // Price
                            FutureBuilder<String>(
                              future: formatPrice(
                                filteredData[index]['amount'] ?? '50000',
                                'Tzs',
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    !snapshot.hasData) {
                                  return SizedBox(
                                    height: screenHeight * 0.02,
                                    width: screenHeight * 0.02,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppConst.primary,
                                    ),
                                  );
                                } else {
                                  return AppText(
                                    txt: snapshot.data ?? '',
                                    color: AppConst.primary,
                                    weight: FontWeight.w700,
                                    size: screenWidth * 0.04,
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
            SizedBox(height: screenHeight * 0.12),
          ],
        );
  }
}
