import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:responsive/presntation/configration/config_view_model/config_view_model.dart'; // No longer needed for configState

import 'package:responsive/presntation/home/home_view/widget/custom_dialog.dart';
import 'package:responsive/presntation/home/home_view_model/home_view_model.dart';
import 'package:responsive/presntation/resources/assets_manager.dart';
import 'package:responsive/presntation/resources/routes_manager.dart';

import '../../../domain/models/models.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  final TransformationController transformationController =
  TransformationController();

  // Spacing and icon size are still constant for consistent layout
  double spacing = 150.0;
  double iconSize = 50.0;


  @override
  void initState() {
    super.initState();
    // Start the home view model to fetch or generate nodes
    // The parameters (3, 5) likely define initial grid generation limits for the provider
    Future.microtask(() => ref.read(homeProvider.notifier).start(3, 5));
  }

  Widget _contentHomeWidget(List<NodeModel> nodes) {
    // Determine grid dimensions dynamically based on the nodes list
    int dynamicNumIconsX = 0;
    int dynamicNumIconsY = 0;

    if (nodes.isNotEmpty) {
      // Add 1 to the maximum axis value because coordinates are typically 0-indexed.
      // E.g., if max xAxis is 9, you need 10 columns (0 to 9).
      dynamicNumIconsX = nodes.map((node) => node.xAxis).reduce((a, b) => a > b ? a : b) + 1;
      dynamicNumIconsY = nodes.map((node) => node.yAxis).reduce((a, b) => a > b ? a : b) + 1;
    } else {
      // Fallback for an empty nodes list or if no max could be found.
      // This ensures a minimum visible grid even if no nodes are loaded yet.
      dynamicNumIconsX = 5; // Default if no nodes or no max found
      dynamicNumIconsY = 5; // Default if no nodes or no max found
    }

    // Ensure there's at least a 1x1 grid to avoid issues with zero dimensions.
    dynamicNumIconsX = dynamicNumIconsX > 0 ? dynamicNumIconsX : 1;
    dynamicNumIconsY = dynamicNumIconsY > 0 ? dynamicNumIconsY : 1;


    // Calculate container width and height based on dynamic icon counts
    double containerWidth = (dynamicNumIconsX * spacing) + iconSize;
    double containerHeight = (dynamicNumIconsY * spacing) + iconSize;

    return SliverFillRemaining(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: InteractiveViewer(
            transformationController: transformationController,
            // Set minScale and maxScale to 1.0 to disable zoom
            minScale: 1.0,
            maxScale: 1.0,
            // Align to top-left to ensure content starts from the corner
            alignment: Alignment.topLeft,
            // The SingleChildScrollView outside handles actual scrolling if content exceeds screen
            // Constrained is true by default and usually desired here for fitting
            constrained: true,
            child: Padding( // Added Padding widget here
              padding: const EdgeInsets.only(left: 20.0), // Padding from the left
              child: Container(
                width: containerWidth,
                height: containerHeight,
                color: Colors.white, // Background color for the grid area
                child: Stack(
                  children: [
                    // Custom painter for dotted lines
                    Positioned.fill(
                      child: CustomPaint(
                        painter: DottedLinePainter(
                          nodes,
                          spacing,
                          // coloredConnections: [
                          //   [
                          //     Offset(0 * spacing + 25, 1 * spacing + 25),
                          //     Offset(1 * spacing + 25, 1 * spacing + 25),
                          //   ],
                          //   [
                          //     Offset(0 * spacing + 25, 1 * spacing + 25),
                          //     Offset(1 * spacing + 25, 1 * spacing + 25),
                          //   ]
                          // ],
                        ),
                      ),
                    ),
                    // Render each node as a positioned widget
                    ...nodes.map(
                          (node) => Positioned(
                        left: node.xAxis * spacing,
                        top: node.yAxis * spacing,
                        child: GestureDetector(
                          onTap: () {
                            // Show dialog for node details
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CustomDialog(nodeModel: node),
                            ).then((_) {
                              // setState(() {}); // No need to call setState here unless CustomDialog modifies node properties
                            });
                          },
                          child: Container(
                            width: iconSize,
                            height: iconSize,
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                if (node.isCharged)
                                  SvgPicture.asset(
                                    ImageAssets.chargedImage,
                                    width: 50,
                                    height: 50,
                                  )
                                else if (node.isBlocked)
                                  SvgPicture.asset(
                                    ImageAssets.blockedImage,
                                    width: 50,
                                    height: 50,
                                  )
                                else
                                  const Icon(Icons.circle, size: 50,color: Colors.black,),// Changed default color for visibility
                                // Coordinate text overlay
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(178),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      // Display coordinates only if not free, blocked, or charged
                                      node.isFree || node.isBlocked || node.isCharged ? '' : '${node.xAxis}${node.yAxis}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider); // Watch the state from the home provider

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [
            IconButton(
              onPressed: () {
                // Navigate to configuration screen
                Navigator.of(context).pushNamed(Routes.configuration);
              },
              icon: const Icon(Icons.confirmation_num),
            )
          ],
          pinned: true,
          title: const Text(
            'Home',
          ),
          centerTitle: false,
        ),
        const SliverToBoxAdapter(
            child: SizedBox(
              height: 10, // Spacer below the app bar
            )),
        // Conditional rendering based on homeState
        homeState.isLoading
            ? const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
            : homeState.isEmpty
            ? const SliverToBoxAdapter(child: Text('No data available'))
            : homeState.errorMessage.isNotEmpty
            ? SliverToBoxAdapter(child: Center(child: Text(homeState.errorMessage)))
            : _contentHomeWidget(homeState.nodes) // Render the grid if data is available
      ],
    );
  }
}

// CustomPainter for drawing dotted lines between nodes
class DottedLinePainter extends CustomPainter {
  final List<NodeModel> nodes;
  final double spacing;
  final List<List<Offset>> coloredConnections;

  DottedLinePainter(this.nodes, this.spacing, {this.coloredConnections = const []});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint normalPaint = Paint()
      ..color = Colors.grey // Default line color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint coloredPaint = Paint()
      ..color = Colors.red // Highlighted line color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 10;
    const double dashSpace = 5;
    const double iconOffset = 25; // Half of iconSize (50/2) to center lines

    // Iterate through all nodes to draw connections
    for (var node in nodes) {
      for (var otherNode in nodes) {
        // Check for horizontal connections (same y-axis, x-axis difference of 1)
        if ((node.xAxis - otherNode.xAxis).abs() == 1 &&
            node.yAxis == otherNode.yAxis) {
          Offset start = Offset(node.xAxis * spacing + iconOffset, node.yAxis * spacing + iconOffset);
          Offset end = Offset(otherNode.xAxis * spacing + iconOffset, otherNode.yAxis * spacing + iconOffset);

          bool isColored = _isColoredConnection(start, end);
          drawDottedLine(canvas, start, end, isColored ? coloredPaint : normalPaint, dashWidth, dashSpace);
        }

        if ((node.yAxis - otherNode.yAxis).abs() == 1 &&
            node.xAxis == otherNode.xAxis) {
          Offset start = Offset(node.xAxis * spacing + iconOffset, node.yAxis * spacing + iconOffset);
          Offset end = Offset(otherNode.xAxis * spacing + iconOffset, otherNode.yAxis * spacing + iconOffset);

          bool isColored = _isColoredConnection(start, end);
          drawDottedLine(canvas, start, end, isColored ? coloredPaint : normalPaint, dashWidth, dashSpace);
        }
      }
    }
  }

  // Helper to check if a connection should be colored
  bool _isColoredConnection(Offset a, Offset b) {
    return coloredConnections.any((pair) =>
    (pair[0] == a && pair[1] == b) || (pair[0] == b && pair[1] == a));
  }

  // Draws a dotted line between two points
  void drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint,
      double dashWidth, double dashSpace) {
    double distance = (end - start).distance;
    double dx = (end.dx - start.dx) / distance;
    double dy = (end.dy - start.dy) / distance;
    double currentX = start.dx;
    double currentY = start.dy;

    while (distance > 0) {
      double segmentLength = dashWidth;
      if (distance < dashWidth) {
        segmentLength = distance; // Draw remaining part if shorter than dashWidth
      }

      canvas.drawLine(
          Offset(currentX, currentY),
          Offset(currentX + dx * segmentLength, currentY + dy * segmentLength),
          paint);

      currentX += dx * (segmentLength + dashSpace);
      currentY += dy * (segmentLength + dashSpace);
      distance -= (segmentLength + dashSpace);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

//
