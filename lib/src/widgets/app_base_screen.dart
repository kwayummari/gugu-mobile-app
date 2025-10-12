import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBaseScreen extends StatefulWidget {
  final Widget child;
  final Widget? title;
  final Widget? floatingAction;
  final bool? isLoading;
  final bool? backgroundImage;
  final bool backgroundAuth;
  final AppBar? appBar;
  final bool? isvisible;
  final bool? isFlexible;
  final bool? showAppBar;
  final bool? centerTitle;
  final EdgeInsetsGeometry? padding;
  final Color? bgcolor;
  final Color? appBarBgColor;
  final Color? iconColor;

  const AppBaseScreen({
    Key? key,
    required this.child,
    required this.isvisible,
    required this.isFlexible,
    required this.showAppBar,
    this.isLoading = false,
    required this.backgroundImage,
    required this.backgroundAuth,
    this.appBar,
    this.padding,
    this.floatingAction,
    this.title,
    this.bgcolor,
    this.appBarBgColor,
    this.iconColor,
    this.centerTitle,
  }) : super(key: key);

  @override
  State<AppBaseScreen> createState() => _AppBaseScreenState();
}

class _AppBaseScreenState extends State<AppBaseScreen> {
  var fullname;
  var roles;
  static String branchId = dotenv.env['BRANCH_ID'] ?? '1';
  OverlayEntry? sideSheetOverlayEntry;
  final sideSheetOverlayLayerLink = LayerLink();
  bool isSidebarShown = false;

  @override
  void initState() {
    getName();
    super.initState();
  }

  String _getGreeting() {
    var now = DateTime.now();
    var hour = now.hour;

    if (hour < 12) {
      return 'Good morning ☀️';
    } else if (hour < 18) {
      return 'Good afternoon 🌞';
    } else {
      return 'Good evening 🌙';
    }
  }

  Future<String> getName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('name');
    var role = 'Manager';
    setState(() {
      fullname = name.toString();
      roles = role.toString();
    });
    return name.toString();
  }

  @override
  Widget build(BuildContext context) {
    String greeting = _getGreeting();
    return Scaffold(
      backgroundColor: widget.bgcolor ?? AppConst.black,
      appBar:
          widget.showAppBar == true
              ? widget.appBar ??
                  AppBar(
                    automaticallyImplyLeading: false,
                    centerTitle: widget.centerTitle,
                    title: Padding(
                      padding: EdgeInsets.only(
                        bottom: widget.isFlexible == true ? 150 : 0,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: widget.title,
                      ),
                    ),
                    flexibleSpace:
                        widget.isFlexible == true
                            ? Container(
                              decoration: BoxDecoration(
                                color: AppConst.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppConst.grey.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 50),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              txt: greeting,
                                              size: 14,
                                              weight: FontWeight.w400,
                                              color: AppConst.grey,
                                            ),
                                            SizedBox(height: 4),
                                            AppText(
                                              txt: fullname ?? 'Guest',
                                              size: 20,
                                              weight: FontWeight.w600,
                                              color: AppConst.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            )
                            : null,
                    iconTheme: IconThemeData(
                      color: widget.iconColor ?? AppConst.white,
                    ),
                    shape: null,
                    toolbarHeight: widget.isFlexible == true ? 100 : null,
                    backgroundColor:
                        widget.appBarBgColor ?? AppConst.transparent,
                  )
              : null,
      body: SingleChildScrollView(
        child: Container(
          decoration:
              widget.backgroundAuth
                  ? BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/login.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.4,
                    ),
                  )
                  : null,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Padding(
                padding: widget.padding ?? const EdgeInsets.all(16.0),
                child: widget.child,
              ),
              if (widget.backgroundImage == true)
                Positioned.fill(
                  child: Image.asset('assets/intro.png', fit: BoxFit.cover),
                ),
              if (widget.backgroundAuth == true)
                Container(color: AppConst.black.withOpacity(0.85)),
              if (widget.backgroundImage == true)
                Container(color: AppConst.black.withOpacity(0.85)),
              if (widget.isLoading == true)
                Center(child: SpinKitCircle(color: AppConst.primary)),
              if (widget.isvisible == true)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 130,
                    width: 120,
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    decoration: BoxDecoration(
                      color: AppConst.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        bottomLeft: Radius.circular(126),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.floatingAction,
    );
  }
}
