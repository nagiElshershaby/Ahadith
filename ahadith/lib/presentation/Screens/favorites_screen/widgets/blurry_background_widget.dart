import 'package:ahadith/data/data_providers/favorites_and_saved_provider/favorites_and_saved.dart';
import 'package:ahadith/presentation/Screens/hadith_detailed_screen/Widgets/hadith_detailed_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ahadith/data/models/hadith.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BlurryBackgroundWidget extends StatefulWidget {
  final DetailedHadith hadith;
  final String hadithIndex;
  final favoritesProvider;

  const BlurryBackgroundWidget(
      {super.key, required this.hadith, required this.hadithIndex, this.favoritesProvider});

  @override
  _BlurryBackgroundWidgetState createState() => _BlurryBackgroundWidgetState();
}

class _BlurryBackgroundWidgetState extends State<BlurryBackgroundWidget> {
  bool _expanded = false;
  int textLength = 100;
  @override
  Widget build(BuildContext context) {
    textLength = widget.hadith.hadeeth!.length;

    FavoritesAndSavedProvider favoritesProvider = Provider.of<FavoritesAndSavedProvider>(context);

    if ( widget.favoritesProvider != null ) {
      favoritesProvider = widget.favoritesProvider;
    }

    return SizedBox(
      height: 1000.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
            const EdgeInsets.only(top: 50.0, left: 25.0, right: 25.0),
            child: Text(
              '${widget.hadith.categories!.first}: ${widget.hadithIndex}\n\n${widget.hadith.title!}',
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(
              top: _expanded ? 30.h : 50.h,
              left: _expanded ? 40.h : 50.w,
              right: _expanded ? 40.h : 50.w,
              bottom: _expanded ? 30.h : 100.h,
            ),
            height:
            textLength<120 ? 190.h : textLength<160 ? 220.h : textLength<190 ? 240.h : textLength<220 ? 260.h : textLength<250 ? 280.h : textLength<280 ? 300.h : textLength<310 ? 320.h : textLength<340 ? 340.h : textLength<370 ? 360.h : textLength<400 ? 380.h : textLength<430 ? 400.h : textLength<460 ? 420.h : textLength<490 ? 440.h : textLength<520 ? 460.h : textLength<550 ? 480.h : 500.h,
            // _expanded ? 400.h : 250.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _expanded
                      ? Colors.white.withOpacity(0.1)
                      : Colors.white.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: _expanded ? 1 : 2,
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Container(
                // color: Colors.deepPurple.withOpacity(0.2),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: 20.h,
                    bottom: 20.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  children: [
                    Text(
                      widget.hadith.hadeeth!,
                      style: GoogleFonts.lateef(
                        // overflow: TextOverflow.fade,
                        color: Colors.white,
                        fontSize: 27.sp,
                        fontWeight: FontWeight.bold,
                        // fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    _expanded
                        ? SizedBox(height: 30.h)
                        : SizedBox(height: 40.h),
                    goToHadithButton('اذهب الى الحديث', widget.hadith),
                    SizedBox(height: 40.h),
                    MaterialButton(
                        textColor: Colors.red[200],
                        child: const Text(
                          'ازالة الحديث من المفضلة',
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: MediaQuery.of(context)
                                  .platformBrightness ==
                                  Brightness.light
                                  ? Colors.white
                                  : Colors.black87,
                              title: SizedBox(
                                // height: 0.2.sh,
                                // width: 0.8.sw,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'هل انت متأكد من ازالة الحديث من المفضلة؟',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text(
                                            'الرجوع',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            favoritesProvider
                                                .removeFavorite(
                                              widget.hadith.id!,
                                              widget.hadith,
                                            );
                                          },
                                          child: Text(
                                            'ازالة',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                color:
                                                Colors.red[200]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          // favoritesProvider.removeFavorite(
                          //   widget.hadith.id!,
                          //   widget.hadith,
                          // );
                        }),
                  ],
                ),
              ),
            ),
          ),
          const Text('HadeethEnc.com',
              style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }

  void _showDialog(DetailedHadith hadith) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.white
                : Colors.grey.shade800,
        title: SizedBox(
          height: 0.8.sh,
          width: 0.8.sw,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              buildCard(
                  '', hadith.hadeeth! + hadith.attribution!, true, context),
              SizedBox(height: 20.h),
              hadithGrade(hadith.grade!, context),
              SizedBox(height: 10.h),
              buildCard('التفسير : ', hadith.explanation!, false, context),
              if (hadith.wordsMeanings!.isNotEmpty) SizedBox(height: 10.h),
              if (hadith.wordsMeanings!.isNotEmpty)
                buildCard(': معانى الكلمات\n ',
                    hadith.wordsMeanings!.toList().toString(), false, context),
              SizedBox(height: 22.h),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'الرجوع',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget goToHadithButton(title, hadith) {
    return TextButton(
      onPressed: () {
        _showDialog(hadith);
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: SizedBox(
        height: 40.h,
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Colors.white
                      : Colors.deepPurple.shade100,
                ),
          ),
        ),
      ),
    );
  }
}
