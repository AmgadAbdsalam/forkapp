import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/presntation/home/home_view/widget/custom_dialog.dart';
import 'package:responsive/presntation/home/home_view_model/home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  final TransformationController transformationController =
  TransformationController();

  // User-defined number of icons in X and Y axes
  int numIconsX = 3; // Number of columns
  int numIconsY = 3; // Number of rows

  // Spacing and icon size
  double spacing = 150.0;
  double iconSize = 50.0;


  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(homeProvider.notifier).start(3, 3));
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = (numIconsX * spacing) + iconSize;
    double containerHeight = (numIconsY * spacing) + iconSize;

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: true,
          title: Text(
            'Configuration',
          ),
          centerTitle: false,
        ),
        const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            )),
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
                      ...ref.watch(homeProvider).map((node) =>
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
                              const Icon(Icons.abc)  :node.isCharged ==  true? const Icon(Icons.access_alarm):const Icon(Icons.ac_unit_rounded)
                          )
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

