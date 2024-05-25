import 'package:enplus_market/components/app_checkbox.dart';
import 'package:enplus_market/services/app_version_checker.dart';
import 'package:enplus_market/services/client_info.dart';
import 'package:enplus_market/services/enums.dart';
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
  bool _isLoaded = false;

  late OS _os;
  late bool _isCompatible;

  late bool _isUpdatable;

  void setClientInfo() {
    final ver = int.parse(ClientInfo.instance.info.osVersion);

    if (ClientInfo.instance.info.osName == "Android") {
      _os = OS.android;
      if (widget.app.minAndroid!.isNotEmpty &&
          ver >= int.parse(widget.app.minAndroid!.split(".")[0])) {
        _isCompatible = true;
      } else {
        _isCompatible = false;
      }
    } else {
      _os = OS.ios;
      if (widget.app.minIos!.isNotEmpty &&
          ver >= int.parse(widget.app.minIos!.split(".")[0])) {
        _isCompatible = true;
      } else {
        _isCompatible = false;
      }
    }
  }

  void checkUpdate() async {
    _isUpdatable = await AppVersionChecker.isUpdatable(app: widget.app);
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    setClientInfo();
    checkUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoaded
        ? SizedBox.shrink()
        : InkWell(
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
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/img/placeholder.png",
                          image: widget.app.icon,
                          fit: BoxFit.fill,
                        ),
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
                    Icon(widget.app.isInstalled!
                          ? (_isUpdatable
                              ? Icons.autorenew_rounded
                              : Icons.check_circle_outline)
                          : null,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                    SizedBox.square(
                      dimension: 40,
                      child: (_isCompatible)
                          ? AppCheckbox(
                              value: widget.isSelected,
                              onChanged: (value) {
                                widget.onCheckboxValueChanged(value);
                              },
                            )
                          : const Icon(
                              Icons.indeterminate_check_box_outlined,
                              color: Colors.black,
                            ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
