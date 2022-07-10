import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';

class Submit extends StatefulWidget {
  const Submit({Key? key, required this.onSubmitFunction, required this.state})
      : super(key: key);
  final onSubmitFunction;
  final ButtonState state;
  @override
  SubmitState createState() => SubmitState();
}

class SubmitState extends State<Submit> {
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateOnlyCustomIndicatorText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;

  final description = 'widget.description';

  final color = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      width: MediaQuery.of(context).size.width * 0.9,
      child: buildTextWithIcon(),
    );
  }

  Widget buildTextWithIcon() {
    return ProgressButton(
      stateWidgets: const {
        ButtonState.idle: Text(
          "Save",
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.loading: Text(
          "",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.fail: Text(
          'Failed',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.success: Text(
          'Success',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )
      },
      stateColors: {
        ButtonState.idle: Colors.blueGrey,
        ButtonState.loading: Colors.blue.shade300,
        ButtonState.fail: Colors.red.withOpacity(0.8),
        ButtonState.success: Colors.lightGreen,
      },
      onPressed: widget.onSubmitFunction,
      state: widget.state,
      // maxWidth: 100,
      padding: widget.state == ButtonState.loading
          ? EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 40)
          : const EdgeInsets.all(0),
    );
  }
}
