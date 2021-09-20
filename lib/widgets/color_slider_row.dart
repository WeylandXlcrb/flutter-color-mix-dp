import 'package:flutter/material.dart';

class ColorSliderRow extends StatelessWidget {
  final ValueChanged<bool> onSwitchChanged;
  final ValueChanged<double> onSliderChanged;
  final bool switchValue;
  final double sliderValue;
  final Color activeColor;

  const ColorSliderRow({
    Key? key,
    required this.onSwitchChanged,
    required this.onSliderChanged,
    required this.switchValue,
    required this.sliderValue,
    required this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Switch(
          value: switchValue,
          onChanged: onSwitchChanged,
          activeColor: activeColor,
        ),
        Slider(
          value: sliderValue,
          onChanged: switchValue ? onSliderChanged : null,
          activeColor: activeColor,
        ),
      ],
    );
  }
}
