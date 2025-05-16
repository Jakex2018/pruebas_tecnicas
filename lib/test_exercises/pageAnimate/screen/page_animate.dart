import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prueba_tecnica_01/test_exercises/pageAnimate/models/phone.dart';
import 'package:prueba_tecnica_01/test_exercises/pageAnimate/screen/details_screen.dart';

class PageAnimate extends StatefulWidget {
  const PageAnimate({super.key});

  @override
  State<PageAnimate> createState() => _PageAnimateState();
}

class _PageAnimateState extends State<PageAnimate> {
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double page = controller.hasClients && controller.page != null
              ? controller.page!
              : controller.initialPage.toDouble();

          int current = page.floor();
          int next = (current + 1).clamp(0, phones.length - 1);

          final color1 = Color.lerp(
              phones[current].color01, phones[next].color01, page - current);
          final color2 = Color.lerp(
              phones[current].color02, phones[next].color02, page - current);
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [color1!, color2!],
                    begin: AlignmentDirectional.topCenter,
                    end: Alignment.bottomRight)),
            child: Stack(
              children: [
                Positioned(
                  top: 70,
                  left: 0,
                  right: 0,
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      int index =
                          controller.hasClients && controller.page != null
                              ? controller.page!.round()
                              : controller.initialPage;

                      final phone = phones[index.clamp(0, phones.length - 1)];

                      return Center(
                        child: Column(
                          children: [
                            Text(
                              phone.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              phone.desc,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white30,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: PageView.builder(
                      controller: controller,
                      itemCount: phones.length,
                      itemBuilder: (context, index) {
                        final phone = phones[index];
                        return AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            double value = 0;
                            if (controller.hasClients &&
                                controller.position.haveDimensions) {
                              value = controller.page! - index;
                            } else {
                              value = controller.initialPage.toDouble() - index;
                            }

                            value = value.clamp(-1, 1);

                            final double rotationY = pi / 12 * value;
                            final double scale = 1 - 0.2 * value.abs();

                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(rotationY)
                                ..scale(scale),
                              child: child,
                            );
                          },
                          child: _buildCard(context, index, phone),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index, Phone phone) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailsScreen(
              phone: phone,
              index: index,
            ),
          ),
        );
      },
      child: Hero(
        tag: '${phone.image}-$index',
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              phone.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
