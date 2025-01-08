import 'package:flutter/material.dart';

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
      {super.key, this.maxLines = 1, this.textInputType = TextInputType.text, this.isShowTitle = true});
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int maxLines;
  final TextInputType? textInputType;
  final bool? isShowTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(isShowTitle!)
        Text.rich(
          TextSpan(
            text: labelText,
            children: <InlineSpan>[
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ],
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          validator: (e) {
            if (e?.isEmpty ?? true) {
              return "Không bỏ trống";
            }
            return null;
          },
          textInputAction: TextInputAction.done,
          controller: controller,
          maxLines: maxLines,
          keyboardType: textInputType,
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
