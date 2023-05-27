import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/generated/locale_keys.g.dart';
import 'package:trade_stat/screens/add_edit_deal_screen/components/select_photo_options_screen.dart';

import '../../../models/image_path.dart';
import '../../../repository/deals_repository.dart';
import '../../../styles/style_exports.dart';

mixin AddEditDealMethods<T extends StatefulWidget> on State<T> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> hashtags = [];
  final _hashtagController = TextEditingController();
  List<String> imagePaths = [];
  final DealsRepository dealsRepository = DealsRepository();
  List<DealImage> dealImages = <DealImage>[];

  @override
  void dispose() {
    _hashtagController.dispose();
    super.dispose();
  }

  FutureOr<void> onFetchImagePaths(int dealId) async {
    List<DealImage> imagePath = await dealsRepository.getImagePath(dealId);
    setState(() {
      dealImages = imagePath;
      for (var element in imagePath) {
        imagePaths.add(element.imagePath!);
      }
    });
  }

  Future<int> getLastId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt("lastId") ?? 0;
  }

  Future setHashtag(List<String> setHashtags) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList("Hashtags", setHashtags);
    hashtags = prefs.getStringList("Hashtags") ??
        <String>[LocaleKeys.add_hashtag.tr()];
  }

  Future<List<String>> getHashtags() async {
    final SharedPreferences prefs = await _prefs;
    hashtags = prefs.getStringList("Hashtags") as List<String>;
    for (var element in hashtags) {
      context.read<DealsBloc>().add(AddHashtag(hashtag: element));
    }
    return hashtags;
  }

  FutureOr<void> showHashtagDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            LocaleKeys.add_hashtag_desc.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  letterSpacing: 0,
                  fontSize: 18,
                ),
          ),
          content: TextField(
            controller: _hashtagController,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                fontSize: 12, color: colorDarkGrey, letterSpacing: 1),
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
            decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: colorDarkGrey),
                ),
                hintText: LocaleKeys.add_hashtag.tr(),
                hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 12, color: colorDarkGrey, letterSpacing: 1)),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                LocaleKeys.save.tr(),
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 15, color: colorBlue, letterSpacing: 1),
              ),
              onPressed: () async {
                if (_hashtagController.value.text.isNotEmpty) {
                  var hashtag = _hashtagController.value.text;
                  hashtags.add(hashtag);
                  setHashtag(hashtags);
                  context.read<DealsBloc>().add(AddHashtag(hashtag: hashtag));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  FutureOr<void> showHashtagDeleteDialog(
      String value, String currentValue) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            context.locale == Locale('ru')
                ? 'Если Вы удалите хэштег #$value, то он удалится во всех сделках.'
                    '\nВы уверены что хотите удалить #$value хэштег?'
                : 'If you delete a hashtag #$value, it will be deleted in all deals.'
                    '\nDo you really want to delete #$value hashtag?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: Colors.red,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    LocaleKeys.cancel.tr(),
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontSize: 15, color: colorBlue, letterSpacing: 1),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    LocaleKeys.delete.tr(),
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontSize: 15,
                        color: Colors.red,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    hashtags.remove(value);
                    setHashtag(hashtags);
                    context
                        .read<DealsBloc>()
                        .add(UpdateDealDeletedHashtag(hashtag: value));
                    context
                        .read<DealsBloc>()
                        .add(DeleteHashtag(hashtag: value));
                    Navigator.pop(context);
                    if (currentValue == LocaleKeys.add_hashtag.tr())
                      Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showSelectPhotoOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: pickImage,
              ),
            );
          }),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.camera) {
        PermissionStatus cameraStatus = await Permission.camera.request();
        if (cameraStatus == PermissionStatus.granted) {
          final image = await ImagePicker().pickImage(source: source);
          if (image == null) return;
          final directory = await getApplicationDocumentsDirectory();
          final imageFile = File(image.path);
          final savedFile =
              await imageFile.copy('${directory.path}/${DateTime.now()}.png');
          setState(
              () => imagePaths = List.from(imagePaths)..add(savedFile.path));
        }
        if (cameraStatus == PermissionStatus.denied) {
          showPermissionDialog(context, true);
        }
        if (cameraStatus == PermissionStatus.permanentlyDenied) {
          showPermissionDialog(context, true);
        }
      } else {
        PermissionStatus storageStatus = await Permission.storage.request();
        if (storageStatus == PermissionStatus.granted){
          final List<XFile> selectedImages = await ImagePicker().pickMultiImage();
          if (selectedImages.isNotEmpty) {
            final List<String> selectedImagesPaths = [];
            for (var element in selectedImages) {
              final directory = await getApplicationDocumentsDirectory();
              final imageFile = File(element.path);
              final savedFile =
              await imageFile.copy('${directory.path}/${DateTime.now()}.png');
              selectedImagesPaths.add(savedFile.path);
            }
            setState(() =>
            imagePaths = List.from(imagePaths)..addAll(selectedImagesPaths));
          }
        }
        if (storageStatus == PermissionStatus.denied) {
          showPermissionDialog(context, false);
        }
        if (storageStatus == PermissionStatus.permanentlyDenied) {
          showPermissionDialog(context, false);
        }
      }
    } on PlatformException catch (_) {
      Navigator.of(context).pop();
    }
  }

  void showPermissionDialog(BuildContext context, bool cameraOrStorage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            cameraOrStorage ? "You need to provide camera permission" : "You need to provide storage permission",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: colorBlue,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontSize: 15,
                        color: colorBlue,
                        letterSpacing: 1),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Open Settings",
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontSize: 15,
                        color: colorBlue,
                        letterSpacing: 1)
                  ),
                  onPressed: () {
                    openAppSettings();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
