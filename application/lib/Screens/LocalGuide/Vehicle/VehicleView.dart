import 'package:flutter/material.dart';

class VehicleVi extends StatefulWidget {
  var name;
  var model;
  var type;
  var imageone;
  var imagetwo;

  VehicleVi({
    super.key,
    required this.name,
    required this.model,
    required this.type,
    required this.imageone,
    required this.imagetwo,
  });

  @override
  State<VehicleVi> createState() => _VehicleViState();
}

class _VehicleViState extends State<VehicleVi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: const Color(0x40000000),
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0)
          ],
          color: const Color(0xffffffff)),
      padding: EdgeInsets.fromLTRB(18, 12, 18, 12),
      child: Column(children: [
        Row(
          children: [
            Text("Vehicle details",
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w700,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 24.0),
                textAlign: TextAlign.left),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(widget.name,
                style: const TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0),
                textAlign: TextAlign.left),
          ],
        ),
        Row(
          children: [
            Text(widget.model,
                style: const TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w500,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0),
                textAlign: TextAlign.left),
          ],
        ),
        Row(
          children: [
            Text(widget.type,
                style: const TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w500,
                    fontFamily: "LexendDeca",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0),
                textAlign: TextAlign.left),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 150,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Image(
                    image: NetworkImage(
                        "https://qgbk7vxz-8000.inc1.devtunnels.ms${widget.imageone}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Image(
                    image: NetworkImage(
                        "https://qgbk7vxz-8000.inc1.devtunnels.ms${widget.imagetwo}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
