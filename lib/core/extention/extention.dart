import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizedboxExtention on num {
  SizedBox get toVert => SizedBox(height: h);
  SizedBox get toHort => SizedBox(width: w);
}
