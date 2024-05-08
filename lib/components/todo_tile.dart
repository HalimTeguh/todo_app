import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {super.key,
      required this.title,
      required this.isChecked,
      required this.onchange,
      required this.deleteFunction});

  final String title;
  final bool isChecked;
  final Function(bool?)? onchange;
  final Function(BuildContext?)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 2,
              onPressed: deleteFunction,
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(10),
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.only(top: 12, right: 12, bottom: 12),
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Checkbox(
              activeColor: Colors.white,
              checkColor: Colors.lightBlueAccent,
              side: const BorderSide(color: Colors.white),
              value: isChecked,
              onChanged: onchange,
            ),
            title: Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      decoration: (isChecked == true)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
