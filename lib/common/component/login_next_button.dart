import 'package:flutter/material.dart';
import 'package:yakmoya/common/const/colors.dart';

class LoginNextButton extends StatefulWidget {
  final String buttonName;
  final bool isButtonEnabled;
  final VoidCallback? onPressed;

  const LoginNextButton({
    required this.onPressed,
    required this.buttonName,
    required this.isButtonEnabled,
    super.key,
  });

  @override
  State<LoginNextButton> createState() => _LoginNextButtonState();
}

class _LoginNextButtonState extends State<LoginNextButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: widget.isButtonEnabled ? widget.onPressed : null,
              style: ElevatedButton.styleFrom(
                primary:
                widget.isButtonEnabled ? Colors.red[300] : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.buttonName,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
