import 'package:flutter/material.dart';
import 'package:school_erp/enums/button_type.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/form_button.dart';

class AnimatedCustomModal<T> {

    static void show(BuildContext context, List<Widget> content) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
                return AnimatedDialog(content: content);
            },
        );
    }

}

class AnimatedDialog extends StatefulWidget {
    final List<Widget> content;

    const AnimatedDialog({super.key, required this.content});

    @override
    createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
    late AnimationController _controller;
    late Animation<double> _scaleAnimation;

    @override
    void initState() {
        super.initState();
        _controller = AnimationController(
            duration: Duration(milliseconds: 100),
            // For matching the refresh rate of the device. 
            // (I, Horhe, aprub, but debatable for older devices.)
            // Need SingleTickerProviderStateMixin to have access to this (vsync). 
            vsync: this,
        );
        _scaleAnimation = Tween<double>(begin: 0, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
                _controller.forward(); 
            });
    }

    @override
    void dispose() {
        _controller.dispose();
        super.dispose();
    }

    void closeDialog(BuildContext context) {
        _controller.reverse().then((_) {
                Navigator.pop(context);
            });
    }

    @override
    Widget build(BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;

        double verticalPadding = screenHeight * 0.05; 
        double horizontalPadding = screenWidth * 0.05; 

        return GestureDetector(
            onTap: () {
                closeDialog(context);
            },
            child: Material(
                color: Colors.black.withOpacity(0.2),
                child: Center(
                    child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
                                child: SingleChildScrollView(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            ...widget.content,
                                            FormButton(
                                                buttonLabel: "Close", 
                                                buttonType: ButtonType.button, 
                                                buttonFn: () {
                                                    closeDialog(context);
                                                },
                                            )
                                        ],
                                    ),
                                ),
                            ),
                        ),
                    ),
                ),
            ),
        );
    }
}
