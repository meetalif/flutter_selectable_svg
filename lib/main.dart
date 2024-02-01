import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selectable SVG Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
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
          _buildControlButtons(),
          _buildSVGWithHitAreas(),
          _buildSelectedPathsDisplay(),
        ],
      ),
    );
  }

  // Build control buttons for visibility and clear all.
  Widget _buildControlButtons() {
    return Positioned(
      left: 16,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                hitListVisible = !hitListVisible;
              });
            },
            icon: Icon(
              hitListVisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectedPaths.clear();
              });
            },
            icon: const Icon(Icons.clear_all),
          ),
        ],
      ),
    );
  }

  // Build SVG with hit areas.
  Widget _buildSVGWithHitAreas() {
    return Center(
      child: SizedBox(
        width: 300,
        child: Stack(
          children: [
            SvgPicture.string(
              _getHexagonsSVG(),
              width: 300,
            ),
            _buildHitArea(tag: "A", left: 44, width: 86, height: 147),
            _buildHitArea(tag: "C", left: 44, top: 147, width: 86, height: 147),
            _buildHitArea(
                tag: "B", left: 171, top: 73.5, width: 86, height: 147),
          ],
        ),
      ),
    );
  }

  // Build hit area widget.
  Widget _buildHitArea({
    required String tag,
    double? left,
    double? right,
    double? top,
    double? bottom,
    double height = 20,
    double width = 20,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (selectedPaths.contains(tag)) {
                selectedPaths.remove(tag);
              } else {
                selectedPaths.add(tag);
              }
            });
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

  // Build display for selected paths.
  Widget _buildSelectedPathsDisplay() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(selectedPaths.toString()),
      ),
    );
  }

  // Retrieve SVG content with dynamic coloring.
  String _getHexagonsSVG() {
    return """<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
	height="622.17151"
	width="629.23376"
	viewBox="0 0 31.484498 31.131129">
	<path
		style="fill:${selectedPaths.contains("A") ? "#FFC107" : "#AEAEAE"};stroke-width:0.0729123;paint-order:fill markers stroke"
		d="M 2.2865623,11.823779 C 1.0356848,9.709955 0.00674729,7.960318 3.4385663e-5,7.9357 -0.00667841,7.911083 0.97180189,6.136186 2.1744351,3.9914941 L 4.361041,0.09205941 6.3669077,0.04443261 c 1.1032274,-0.026195 3.1378374,-0.046138 4.5213543,-0.0443169958 l 2.515483,0.003309996 2.26029,3.83396569 c 1.243158,2.1086807 2.249873,3.8707097 2.237144,3.9156097 -0.01273,0.0449 -0.994488,1.809923 -2.181686,3.922274 l -2.158541,3.840636 -0.588992,0.03946 c -0.323945,0.0217 -2.34896,0.05572 -4.5000319,0.07559 l -3.9110433,0.03613 z"
		id="A" />
	<path
		style="fill:${selectedPaths.contains("B") ? "#9C27B0" : "#AEAEAE"};stroke-width:0.0729123;paint-order:fill markers stroke"
		d="m 18.029344,23.025513 c -0.06183,-0.0963 -1.097687,-1.839477 -2.301901,-3.873725 l -2.189479,-3.698631 2.180696,-3.877708 c 1.199383,-2.132739 2.206619,-3.901079 2.238302,-3.929643 0.03168,-0.02857 2.063896,-0.07253 4.516027,-0.09769 l 4.45842,-0.04576 2.267027,3.825684 c 1.246865,2.104127 2.275562,3.852933 2.285992,3.886235 0.02001,0.06389 -4.299273,7.797421 -4.384324,7.849986 -0.02722,0.01682 -2.053982,0.05438 -4.503914,0.08347 l -4.454423,0.05288 z"
		id="B" />
	<path
		style="fill:${selectedPaths.contains("C") ? "#2196F3" : "#AEAEAE"};stroke-width:0.0729123;paint-order:fill markers stroke"
		d="M 2.6357003,27.318125 C 1.3948188,25.220986 0.37955199,23.447274 0.37955199,23.376547 c 0,-0.07073 0.96791441,-1.853578 2.15092081,-3.961887 l 2.1509208,-3.833295 0.5833006,-0.04201 c 0.3208154,-0.02311 2.3535989,-0.05156 4.5172979,-0.06323 l 3.9339919,-0.02122 2.283667,3.858786 c 1.256016,2.122326 2.274625,3.880387 2.263575,3.906799 -0.01105,0.02641 -1.002181,1.792497 -2.202514,3.924634 l -2.182423,3.876617 -0.879905,0.0099 c -0.483948,0.0054 -2.505896,0.03004 -4.4932179,0.05468 l -3.6133175,0.04481 z"
		id="C" />
</svg>""";
  }
}
