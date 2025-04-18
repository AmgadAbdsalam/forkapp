import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  // User-defined number of icons in X and Y axes
  int numIconsX = 5; // Number of columns
  int numIconsY = 5; // Number of rows

  // Spacing and icon size
  double spacing = 150.0;
  double iconSize = 50.0;


  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(homeProvider.notifier).start(3, 5));
  }

  Widget _contentHomeWidget(List <NodeModel> nodes){
    double containerWidth = (numIconsX * spacing) + iconSize;
    double containerHeight = (numIconsY * spacing) + iconSize;
    return
        SliverFillRemaining(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: InteractiveViewer(
                transformationController: transformationController,
                alignment: Alignment.center,
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.8,
                maxScale: 5.0,
                child: Container(
                  width: containerWidth,
                  height: containerHeight,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Positioned.fill(child: CustomPaint(painter: DottedLinePainter(nodes, spacing),)),
                      ...nodes.map((node) =>
                          Positioned(
                              left: node.xAxis * spacing,
                              top: node.yAxis * spacing,
                              child: IconButton(onPressed: () {
                                showDialog(context: context, builder: (BuildContext context)=>CustomDialog(nodeModel: node,)).then((_){
                                  setState(() {
                                  });
                                });
                              },
                                  icon:node.isFree ?
                                  SvgPicture.asset(ImageAssets.freeImage,width: 50,height: 50,)  :node.isCharged ==  true? SvgPicture.asset(ImageAssets.chargedImage,width: 50,height: 50,):SvgPicture.asset(ImageAssets.blockedImage,width: 50,height: 50,)
                              )
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
            );
  }


  @override
  Widget build(BuildContext context) {
    final homeState= ref.watch(homeProvider);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [IconButton(onPressed: (){
            Navigator.of(context).pushNamed(Routes.configuration);
          }, icon: const Icon(Icons.confirmation_num))],
          pinned: true,
          title: const Text(
            'Home',
          ),
          centerTitle: false,
        ),
        const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            )),
        homeState.isLoading
            ? const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
            : homeState.isEmpty
            ? const SliverToBoxAdapter(child: Text('No data available'))
            : homeState.errorMessage.isNotEmpty
            ? SliverToBoxAdapter(child: Center(child: Text(homeState.errorMessage)))
            : _contentHomeWidget(homeState.nodes)
      ],
    )
    ;
  }
}



/*icon:node.isFree ?  SvgPicture.asset(ImageAssets.freeImage)  :node.isCharged ==  true? SvgPicture.asset(ImageAssets.chargedImage):SvgPicture.asset(ImageAssets.blockedImage)*/
class DottedLinePainter extends CustomPainter {
  final List<NodeModel> nodes;
  final double spacing;

  DottedLinePainter(this.nodes, this.spacing);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 10;
    const double dashSpace = 5;

    for (var node in nodes) {
      for (var otherNode in nodes) {
        if ((node.xAxis - otherNode.xAxis).abs() == 1 &&
            node.yAxis == otherNode.yAxis) {
          // رسم الخط الأفقي
          drawDottedLine(
              canvas,
              Offset(node.xAxis * spacing + 25, node.yAxis * spacing + 25),
              Offset(otherNode.xAxis * spacing + 25,
                  otherNode.yAxis * spacing + 25),
              paint,
              dashWidth,
              dashSpace);
        }

        if ((node.yAxis - otherNode.yAxis).abs() == 1 &&
            node.xAxis == otherNode.xAxis) {
          // رسم الخط العمودي
          drawDottedLine(
              canvas,
              Offset(node.xAxis * spacing + 25, node.yAxis * spacing + 25),
              Offset(otherNode.xAxis * spacing + 25,
                  otherNode.yAxis * spacing + 25),
              paint,
              dashWidth,
              dashSpace);
        }
      }
    }
  }

  void drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint,
      double dashWidth, double dashSpace) {
    double distance = (end - start).distance;
    double dx = (end.dx - start.dx) / distance;
    double dy = (end.dy - start.dy) / distance;
    double startX = start.dx, startY = start.dy;

    while (distance > 0) {
      double currentDashWidth = distance < dashWidth ? distance : dashWidth;
      canvas.drawLine(
          Offset(startX, startY),
          Offset(startX + dx * currentDashWidth, startY + dy * currentDashWidth),
          paint);
      startX += dx * (currentDashWidth + dashSpace);
      startY += dy * (currentDashWidth + dashSpace);
      distance -= (currentDashWidth + dashSpace);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

