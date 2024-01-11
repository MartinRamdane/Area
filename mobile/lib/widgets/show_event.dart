// ignore_for_file: deprecated_member_use

import 'package:area/model/event_create_model.dart';
import 'package:area/model/event_model.dart';
import 'package:area/model/user_event_model.dart';
import 'package:area/pages/update_action_page.dart';
import 'package:area/utils/delete_additional_actions.dart';
import 'package:area/utils/get_event.dart';
import 'package:area/widgets/bottom_sheet_event.dart';
import 'package:area/widgets/event_card.dart';
import 'package:area/pages/update_trigger_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowEvent extends StatefulWidget {
  const ShowEvent({super.key, required this.event, required this.userEvent});
  final EventCreationModel event;
  final UserEvent userEvent;

  @override
  State<ShowEvent> createState() => _ShowEventState();
}

class _ShowEventState extends State<ShowEvent> {
  EventCreationModel? event;
  @override
  void initState() {
    event ??= widget.event;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 102, minWidth: 320),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF94A3B8).withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      event!.eventName!,
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      event!.eventDescription!,
                      style:
                          GoogleFonts.inter(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
              Container(
                width: 42,
                height: 42,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF94A3B8).withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      "assets/icons/settings.svg",
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Color(0xFFFFFFFF),
          thickness: 0.1,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Trigger event",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
                        EventCreationModel event = EventCreationModel(
                triggerEvent: null,
                responseEvent: null,
                eventName: widget.event.eventName,
                eventDescription: widget.event.eventDescription,
                additionalActions: widget.event.additionalActions);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UpdateTriggerPage(eventCreationModel: event,))).then((value) => setState(() {
                  EventModel? eventModel = value as EventModel?;
                  if (eventModel != null) {
                    widget.event.triggerEvent = eventModel;
                  }
                }));
          },
          child: EventCard(
            desc: event!.triggerEvent!.name,
            name: event!.triggerEvent!.provider,
          ),
        ),
        SizedBox(
          height: 10, 
        ),
        Divider(
          color: Color(0xFFFFFFFF),
          thickness: 0.1,
        ),
        Text(
          "Action event",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            EventCreationModel event = EventCreationModel(
                triggerEvent: widget.event.triggerEvent,
                responseEvent: null,
                eventName: widget.event.eventName,
                eventDescription: widget.event.eventDescription,
                additionalActions: widget.event.additionalActions);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UpdateActionPage(eventCreationModel: event,))).then((value) => setState(() {
                  EventModel? eventModel = value as EventModel?;
                  if (eventModel != null) {
                    widget.event.responseEvent = eventModel;
                  }
                }));

          },
          child: EventCard(
            desc: event!.responseEvent!.name,
            name: event!.responseEvent!.provider,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (event!.additionalActions != null &&
            event!.additionalActions!.isNotEmpty)
          Divider(
            color: Color(0xFFFFFFFF),
            thickness: 0.1,
          ),
        if (event!.additionalActions != null &&
            event!.additionalActions!.isNotEmpty)
          Text(
            "Additional actions",
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
          ),
        SizedBox(
          height: 10,
        ),
        if (event!.additionalActions != null &&
            event!.additionalActions!.isNotEmpty)
          ...event!.additionalActions!.map((e) {
            void deleteAdditional() {
              deleteAdditionalAction(
                      widget.userEvent, event!.additionalActions!.indexOf(e))
                  .then((e) {
                getEventByUuid(widget.userEvent.uuid).then((evt) {
                  event = evt;
                  print(event);
                  setState(() {});
                });
              });
            }

            return InkWell(
              onTap: () async {
                await showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return BottomSheetEventEdit(
                        event: e,
                        delete: deleteAdditional,
                      );
                    });
              },
              child: EventCard(
                desc: e.name,
                name: e.provider,
              ),
            );
          }).toList(),
      ],
    );
  }
}
