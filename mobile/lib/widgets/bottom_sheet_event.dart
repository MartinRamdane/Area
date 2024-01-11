import 'package:area/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetEventEdit extends StatefulWidget {
  const BottomSheetEventEdit({super.key, required this.event, this.delete});
  final EventModel event;
  final VoidCallback? delete;

  @override
  State<BottomSheetEventEdit> createState() => _BottomSheetEventEditState();
}

class _BottomSheetEventEditState extends State<BottomSheetEventEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 300),
      decoration: BoxDecoration(
        color: Color(0xFF09090B),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            widget.delete != null ? "Do you want to update or delete this event?" : "Do you want to update this event?",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Color(0xFFA1A1AA),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6D28D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Update",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (widget.delete != null)
          SizedBox(
            height: 10,
          ),
          if (widget.delete != null)
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7F1D1D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                widget.delete!();
                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
