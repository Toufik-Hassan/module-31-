import 'dart:async';

import 'package:flutter/material.dart';

import '../models/slider_model.dart';

class SliderWidget extends StatefulWidget {
  final List<SliderModel> sliders;

  const SliderWidget({
    super.key,
    required this.sliders,
  });

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _startAutoSlider();
  }

  void _startAutoSlider() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (widget.sliders.isEmpty) return;

        _currentIndex++;

        if (_currentIndex >= widget.sliders.length) {
          _currentIndex = 0;
        }

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sliders.isEmpty) {
      return Container(
        height: 180,
        alignment: Alignment.center,
        child: const Text(
          "No Slider Found",
        ),
      );
    }

    return Column(
      children: [

        SizedBox(
          height: 180,

          child: PageView.builder(
            controller: _pageController,

            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },

            itemCount: widget.sliders.length,

            itemBuilder: (context, index) {
              final slider = widget.sliders[index];

              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: Stack(
                  fit: StackFit.expand,

                  children: [

                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(15),

                      child: Image.network(
                        slider.image,
                        fit: BoxFit.cover,

                        errorBuilder:
                            (_, __, ___) =>
                                Container(
                          color: Colors.grey.shade300,

                          child: const Icon(
                            Icons.image,
                            size: 60,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(15),

                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(.6),
                            Colors.transparent,
                          ],
                          begin:
                              Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),

                    Positioned(
                      left: 15,
                      right: 15,
                      bottom: 15,

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            slider.title,

                            style:
                                const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            slider.shortDescription,

                            maxLines: 2,

                            overflow:
                                TextOverflow.ellipsis,

                            style:
                                const TextStyle(
                              color: Colors.white,
                            ),
                          ),

                        ],
                      ),
                    )

                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: List.generate(
            widget.sliders.length,
            (index) {
              return AnimatedContainer(
                duration:
                    const Duration(milliseconds: 300),

                margin:
                    const EdgeInsets.symmetric(
                  horizontal: 4,
                ),

                width:
                    _currentIndex == index ? 22 : 8,

                height: 8,

                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? Colors.green
                      : Colors.grey,

                  borderRadius:
                      BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
