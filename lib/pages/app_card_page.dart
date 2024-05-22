import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/pages/app_updates_page.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:enplus_market/services/enums.dart';
import 'package:enplus_market/providers/installation_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:enplus_market/models/AppModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../components/common_appbar.dart';
import 'package:enplus_market/pages/app_about_page.dart';
import 'package:enplus_market/pages/app_review_page.dart';

class appCard extends StatefulWidget {
  final int appId;

  const appCard({super.key, required this.appId});

  @override
  State<appCard> createState() => _appCardState();
}

class _appCardState extends State<appCard> {
  final TextEditingController _searchController = TextEditingController();

  AppModel? app;

  MultiImageProvider? multiImageProvider;

  AppFetchStatus _fetchStatus = AppFetchStatus.loading;

  Future<void> fetchAppDetails(int appId) async {
    try {
      final apiService = ApiService();
      final response = await apiService.getAppDetails(appId);

      setState(() {
        app = AppModel.fromJson(response["object"]);
        if (app!.images!.isNotEmpty) {
          List<NetworkImage> imageList = app!.images!.map((imageString) {
            return NetworkImage(imageString);
          }).toList();
          multiImageProvider = MultiImageProvider(imageList);
        }
        _fetchStatus = AppFetchStatus.success;
      });
    } catch (e) {
      setState(() {
        _fetchStatus = AppFetchStatus.error;
      });
    }
  }

  // Future<void> installApk(String apkFilePath) async {
  //   try {
  //     PackageManagerStatus status = await AndroidPackageManager.execute(
  //         PackageManagerActionType.install, apkFilePath);
  //
  //     if (status == PackageManagerStatus.success) {
  //       print('APK installed successfully!');
  //     } else {
  //       throw Exception('Installation failed: ${status.name}');
  //     }
  //   } catch (error) {
  //     throw Exception('Error installing APK: $error');
  //   }
  // }

  // void updateProgress(double progress){
  //   if (_progressValue != progress) {
  //     setState(() {
  //       if (_progressValue < 1.0) {
  //         _progressValue = progress;
  //         _labelText = 'Скачивание ${(progress * 100).toStringAsFixed(0)} %';
  //       } else {
  //         _progressValue = 0.0;
  //         _labelText = '';
  //       }
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    fetchAppDetails(widget.appId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: _buildAppDetails(),
    );
  }

  Widget _buildAppDetails() {
    switch (_fetchStatus) {
      case AppFetchStatus.loading:
        return Center(
          child: SpinKitThreeBounce(
            color: Theme.of(context).primaryColor,
          ),
        );
      case AppFetchStatus.success:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Часть 1: Картинка и название приложения
              _buildTopSection(),
              Container(
                  padding: const EdgeInsets.only(left: 109),
                  child: Text(
                    app!.developer ?? '',
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).primaryColor),
                  )),

              // Часть 2: Версия приложения и размер
              _buildVersionSection(),

              // Часть 3: Кнопка "Установить"
              _buildButton(),

              // Часть 4: Набор картинок
              app!.images!.isNotEmpty
                  ? _buildImageGallery()
                  : SizedBox.shrink(),

              // Часть 5: Ссылки "О приложении" и "Обновления"
              _buildLinksSection(context),
            ],
          ),
        );
      case AppFetchStatus.error:
        return const Center(
          child: Text('Произошла ошибка. Попробуйте позже.'),
        );
      default:
        return const Center(
          child: Text('Что-то пошло не так...'),
        );
    }
  }

  Widget _buildTopSection() {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 84,
            height: 84,
            child: FadeInImage.assetNetwork(
              placeholder: "assets/img/placeholder.png",
              image: app!.icon!,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(app!.name,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3),
              ]),
        ),
      ]),
    );
  }

  Widget _buildVersionSection() {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.access_time_sharp, size: 30),
                Text(
                  app!.lastUpdate.version,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            height: 24,
            width: 1,
            color: Colors.black,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_circle_outline, size: 30),
                Text(
                  app!.minIos!,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: app!.isInstalled == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(
                            width: 1.0,
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Удалить',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        elevation: 0,
                      ),
                      child: const Text(
                        'Открыть',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: _buildInstallation()),
                ],
              ));
  }

  Widget _buildInstallation() {
    if (context.watch<InstallationManagerProvider>().installationStatus !=
            InstallationManagerStatus.idle &&
        context.watch<InstallationManagerProvider>().processingApp!.id ==
            app!.id) {
      return _buildProgressBar();
    } else if (context
                .watch<InstallationManagerProvider>()
                .installationStatus !=
            InstallationManagerStatus.idle &&
        context
            .watch<InstallationManagerProvider>()
            .installationManager
            .getQueue()
            .any((element) => element.id == app!.id)) {
      return _buildCancelButton();
    } else {
      return _buildInstallButton();
    }
  }

  Widget _buildInstallButton() {
    return ElevatedButton(
      onPressed: () {
        context
            .read<InstallationManagerProvider>()
            .installationManager
            .addToQueue([ShortAppModel.fromAppModel(app!)]);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(
            width: 1.0,
            color: Theme.of(context).primaryColor,
            style: BorderStyle.solid),
        elevation: 5.0,
      ),
      child: const Text(
        'Установить',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      minHeight: 10,
      borderRadius: BorderRadius.circular(10),
      value: context.watch<InstallationManagerProvider>().installationProgress,
    );
  }

  Widget _buildCancelButton() {
    return ElevatedButton(
      onPressed: () {
        context
            .read<InstallationManagerProvider>()
            .installationManager
            .removeFromQueue(ShortAppModel.fromAppModel(app!));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(
            width: 1.0,
            color: Theme.of(context).primaryColor,
            style: BorderStyle.solid),
        elevation: 5.0,
      ),
      child: const Text(
        'Отменить установку',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return Container(
      height: 200,
      child: InfiniteCarousel.builder(
        itemCount: app!.images!.length,
        itemExtent: 120,
        center: false,
        anchor: 0.0,
        velocityFactor: 0.2,
        axisDirection: Axis.horizontal,
        loop: false,
        itemBuilder: (context, itemIndex, realIndex) {
          return GestureDetector(
            onTap: () {
              showImageViewerPager(
                context,
                multiImageProvider!,
                onPageChanged: (page) {
                  //print("page changed to $page");
                },
                onViewerDismissed: (page) {
                  //print("dismissed while on page $page");
                },
                doubleTapZoomable: true,
                useSafeArea: true,
                backgroundColor: Colors.black87,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/img/placeholder.png",
                  image: app!.images![itemIndex],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLinksSection(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'О приложении',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return aboutApp(app: app!);
                    },
                    barrierColor: Colors.white,
                    isDismissible: false,
                    isScrollControlled: true,
                    enableDrag: true,
                    useSafeArea: true,
                    showDragHandle: false,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(app!.description!,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 3),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Обновления',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return UpdatesApp(app: app!);
                    },
                    barrierColor: Colors.white,
                    isDismissible: false,
                    isScrollControlled: true,
                    enableDrag: true,
                    useSafeArea: true,
                    showDragHandle: false,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Последняя версия: ${app!.lastUpdate.version}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Дата обновления: ${DateFormat('dd.MM.yyyy').format(app!.lastUpdate.date)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Краткое описание последнего обновления',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Оставить отзыв',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return reviewApp(app: app!);
                    },
                    barrierColor: Colors.white,
                    isDismissible: false,
                    isScrollControlled: true,
                    enableDrag: true,
                    useSafeArea: true,
                    showDragHandle: false,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
        ]));
  }
}
