import 'package:flutter/material.dart';
import 'package:flutter_selectable_svg/hexagons.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> selectedPaths = [];
  bool hitListVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selectable SVG"),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 16,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    hitListVisible = !hitListVisible;
                    setState(() {});
                  },
                  icon: Icon(
                    hitListVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    selectedPaths.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.clear_all),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: 300,
              child: Stack(
                children: [
                  SvgPicture.string(
                    hexagons(selectedPaths),
                    // Never forget to assign `width` or it will
                    // change when resolution changes and entire
                    // `HitArea` will diformed
                    width: 300,
                  ),
                  hitArea(tag: "A", l: 44, width: 86, height: 147),
                  hitArea(tag: "C", l: 44, t: 147, width: 86, height: 147),
                  hitArea(tag: "B", l: 171, t: 73.5, width: 86, height: 147),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(selectedPaths.toString()),
            ),
          ),
        ],
      ),
    );
  }

  Widget hitArea(
      {double? l,
      double? r,
      double? t,
      double? b,
      required String tag,
      double height = 20,
      double width = 20}) {
    return Positioned(
      left: l,
      top: t,
      right: r,
      bottom: b,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (selectedPaths.contains(tag)) {
              selectedPaths.remove(tag);
            } else {
              selectedPaths.add(tag);
            }
            setState(() {});
          },
          child: Container(
            height: height,
            width: width,
            color: hitListVisible
                ? Colors.white.withOpacity(0.3)
                : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
