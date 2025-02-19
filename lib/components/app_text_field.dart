import 'package:app_bamnguyet_2/components/app_snackbar.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel(this.label, {super.key});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: label,
        children: <InlineSpan>[
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red),
          ),
        ],
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField(this.controller, this.hintText, this.labelText,
      {super.key,
      this.maxLines = 1,
      this.textInputType = TextInputType.text,
        this.onChanged,
      this.isShowTitle = true,
      this.isShowRequired = true, });
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int maxLines;
  final TextInputType? textInputType;
  final bool? isShowTitle;
  final bool? isShowRequired;
  final Function(String? s)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle!)
          Text.rich(
            TextSpan(
              text: labelText,
              children: <InlineSpan>[
                if (isShowRequired!)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        TextFormField(
          validator: (e) {
            if ((isShowRequired ?? false) && (e?.isEmpty ?? true)) {
              return "Không bỏ trống";
            }
            if(textInputType == TextInputType.phone){
              if(!RegExp(r'^(\+84|0)\d{9,10}$').hasMatch(e!)){
                return "Số điện thoại khônh hợp lệ";
              }
            }
            return null;
          },
          textInputAction: TextInputAction.done,
          autovalidateMode: AutovalidateMode.onUnfocus,
          controller: controller,
          maxLines: maxLines,
          keyboardType: textInputType,
          onChanged: (s) {
            if(onChanged != null) onChanged!(s);
          },
          decoration: InputDecoration(
            hintText: hintText,
            labelStyle: TextStyle(),
            hintStyle: TextStyle(color: Colors.grey),
            // prefixIcon: Padding(
            //   padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
            //   child: SvgPicture.asset(
            //     "assets/icons/world_map.svg",
            //     height: 24,
            //     width: 24,
            //     colorFilter: ColorFilter.mode(
            //       Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.3),
            //       BlendMode.srcIn,
            //     ),
            //   ),
            // ),
          ),
        ),
      ],
    );
  }
}
