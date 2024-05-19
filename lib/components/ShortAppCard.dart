import 'package:enplus_market/components/AppCheckbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:go_router/go_router.dart';

class ShortAppCard extends StatefulWidget {
  final ShortAppModel app;
  final bool isSelected;
  final ValueChanged<bool> onCheckboxValueChanged;

  const ShortAppCard({
    super.key,
    required this.app,
    required this.onCheckboxValueChanged,
    required this.isSelected,
  });



  @override
  State<ShortAppCard> createState() => _ShortAppCardState();
}

class _ShortAppCardState extends State<ShortAppCard> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/main/appCard/${widget.app.id}');
      },
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        shadowColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(20), // Image radius
                  child: Image.network(widget.app.icon, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      widget.app.name.isNotEmpty
                          ? widget.app.name
                          : 'Название отсутствует',
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: 2),
                  Text(
                    '${widget.app.size}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )),
              const SizedBox(width: 5),
              Icon(
                widget.app.isInstalled == true
                    ? Icons.check_circle_outline
                    : null,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              AppCheckbox(
                value: widget.isSelected,
                onChanged: (value) {
                  widget.onCheckboxValueChanged(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
