import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ahadith/data/models/hadith.dart';
import 'package:google_fonts/google_fonts.dart';

class BlurryBackgroundWidget extends StatefulWidget {
  final DetailedHadith hadith;

  const BlurryBackgroundWidget({super.key, required this.hadith});

  @override
  _BlurryBackgroundWidgetState createState() => _BlurryBackgroundWidgetState();
}

class _BlurryBackgroundWidgetState extends State<BlurryBackgroundWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.hadith.categories!.first,
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _expanded?600.h:375.h,
          width: double.infinity,
          curve: Curves.decelerate,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(top: 100.h, left: 50.w, right: 50.w, bottom: 100.h),
            height: 100.h,
            width: 300.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: _expanded?[
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ]:[
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text(
                      _expanded?'${widget.hadith.hadeeth!}\n\n${widget.hadith.explanation!}':widget.hadith.hadeeth!,
                      style: GoogleFonts.lateef(
                        // overflow: TextOverflow.fade,
                        color: Colors.white,
                        fontSize: 27.sp,
                        fontWeight: FontWeight.bold,
                        // fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
