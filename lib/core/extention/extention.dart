import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NumExtention on num {
  SizedBox get toVert => SizedBox(height: h);
  SizedBox get toHort => SizedBox(width: h);
}
