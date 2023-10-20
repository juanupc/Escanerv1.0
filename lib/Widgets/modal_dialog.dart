import 'package:flutter/material.dart';

void imagePickerModal(BuildContext context, {VoidCallback? onCameraTap, VoidCallback? onGalleryTap}) {
  final AnimationController controller = AnimationController(
    duration: Duration(milliseconds: 800), 
    vsync: Navigator.of(context),
  );

  final Animation<double> _scaleAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.ease,
  ));

  controller.forward();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onCameraTap,
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "CAMARA",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: onGalleryTap,
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo,
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "GALERIA",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
