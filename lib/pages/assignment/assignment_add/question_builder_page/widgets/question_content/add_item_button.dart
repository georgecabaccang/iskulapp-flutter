import 'package:flutter/material.dart';

class AddItemButton extends StatelessWidget {
  final int index;
  final VoidCallback onAddPressed;
  final VoidCallback onRemovePressed;

  const AddItemButton({
    super.key,
    required this.index,
    required this.onAddPressed,
    required this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: index == 0 ? Colors.black : Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(index == 0 ? Icons.add : Icons.remove, color: Colors.white),
        onPressed: index == 0 ? onAddPressed : onRemovePressed,
      ),
    );
  }
}
