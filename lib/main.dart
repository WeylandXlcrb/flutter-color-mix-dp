import 'package:flutter/material.dart';

import 'package:color_mix/widgets/color_slider_row.dart';

void main() {
  runApp(const ColorMixApp());
}

enum ColorSection { red, green, blue }

class ColorMixApp extends StatelessWidget {
  const ColorMixApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Color Mix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ColorMixPage(),
    );
  }
}

class ColorMixPage extends StatefulWidget {
  const ColorMixPage({Key? key}) : super(key: key);

  @override
  State<ColorMixPage> createState() => _ColorMixPageState();
}

class _ColorMixPageState extends State<ColorMixPage> {
  Map<ColorSection, bool> switchValues = {
    ColorSection.red: true,
    ColorSection.green: false,
    ColorSection.blue: false,
  };

  Map<ColorSection, double> sliderValues = {
    ColorSection.red: 0.5,
    ColorSection.green: 0.5,
    ColorSection.blue: 0.5,
  };

  Color previewColor = Colors.black;

  @override
  void initState() {
    super.initState();

    _updateUI();
  }

  void _setSliderValue(double value, ColorSection key) {
    setState(() {
      sliderValues[key] = value;
    });
    _updateUI();
  }

  void _setSwitchValue(bool value, ColorSection key) {
    setState(() {
      switchValues[key] = value;
    });
    _updateUI();
  }

  void _reset() {
    setState(() {
      switchValues[ColorSection.red] = true;
      switchValues[ColorSection.green] = false;
      switchValues[ColorSection.blue] = false;
      sliderValues[ColorSection.red] = 0.5;
      sliderValues[ColorSection.green] = 0.5;
      sliderValues[ColorSection.blue] = 0.5;
    });
    _updateUI();
  }

  void _updateUI() {
    final red = switchValues[ColorSection.red]!
        ? (255 * sliderValues[ColorSection.red]!).toInt()
        : 0;
    final green = switchValues[ColorSection.green]!
        ? (255 * sliderValues[ColorSection.green]!).toInt()
        : 0;
    final blue = switchValues[ColorSection.blue]!
        ? (255 * sliderValues[ColorSection.blue]!).toInt()
        : 0;

    setState(() {
      previewColor = Color.fromRGBO(red, green, blue, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isBright =
        ThemeData.estimateBrightnessForColor(previewColor) == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mix your color'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  color: previewColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Red ${previewColor.red}\nGreen ${previewColor.green}\nBlue ${previewColor.blue}',
                      style: TextStyle(
                        inherit: true,
                        color: isBright ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ColorSliderRow(
              onSwitchChanged: (value) =>
                  _setSwitchValue(value, ColorSection.red),
              onSliderChanged: (value) =>
                  _setSliderValue(value, ColorSection.red),
              switchValue: switchValues[ColorSection.red]!,
              sliderValue: sliderValues[ColorSection.red]!,
              activeColor: Colors.red,
            ),
            ColorSliderRow(
              onSwitchChanged: (value) =>
                  _setSwitchValue(value, ColorSection.green),
              onSliderChanged: (value) =>
                  _setSliderValue(value, ColorSection.green),
              switchValue: switchValues[ColorSection.green]!,
              sliderValue: sliderValues[ColorSection.green]!,
              activeColor: Colors.green,
            ),
            ColorSliderRow(
              onSwitchChanged: (value) =>
                  _setSwitchValue(value, ColorSection.blue),
              onSliderChanged: (value) =>
                  _setSliderValue(value, ColorSection.blue),
              switchValue: switchValues[ColorSection.blue]!,
              sliderValue: sliderValues[ColorSection.blue]!,
              activeColor: Colors.blue,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  child: const Text('Reset'),
                  onPressed: _reset,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
