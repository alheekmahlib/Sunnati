import 'dart:io';
import 'dart:ui' as ui;

import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../utils/constants/lottie.dart';
import '../../utils/constants/svg_picture.dart';
import '../widgets.dart';

ArabicNumbers arabicNumber = ArabicNumbers();

/// Share Hadith
Future<Uint8List> createHadithImage(
    String hadithText, String bookName, int hadithNumber) async {
  // Set a fixed canvas width
  const canvasWidth = 960.0;
  // const fixedWidth = canvasWidth;

  final textHadith = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: hadithText,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.normal,
              fontFamily: 'naskh',
              color: Color(0xff3C2A21),
            ),
          ),
        ],
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify);
  textHadith.layout(maxWidth: 800);

  const padding = 32.0;
  // final imagePadding = 20.0;

  // Load the PNG image
  final pngBytes = await rootBundle.load('assets/images/frame.png');
  final codec = await ui.instantiateImageCodec(pngBytes.buffer.asUint8List());
  final frameInfo = await codec.getNextFrame();
  final pngImage = frameInfo.image;

  // Load the second PNG image
  final pngBytes2 = await rootBundle.load('assets/images/sunti_logo.png');
  final codec2 = await ui.instantiateImageCodec(pngBytes2.buffer.asUint8List());
  final frameInfo2 = await codec2.getNextFrame();
  final pngImage2 = frameInfo2.image;

  // Calculate the image sizes and positions
  final imageWidth = pngImage.width.toDouble() / 1.0;
  final imageHeight = pngImage.height.toDouble() / 1.0;
  final imageX = (canvasWidth - imageWidth) / 2; // Center the first image
  const imageY = padding - 20;

  final image2Width = pngImage2.width.toDouble() / 8.0;
  final image2Height = pngImage2.height.toDouble() / 8.0;
  const image2X = padding + 750; // Center the second image
  final image2Y = imageHeight + padding - 55; // Adjust this value as needed

  // Set the text position
  final textX =
      (canvasWidth - textHadith.width) / 2; // Center the text horizontally
  final textY = image2Y +
      image2Height +
      padding +
      20; // Position the text below the second image

  final pngBytes3 = await rootBundle.load('assets/images/frame.png');
  final codec3 = await ui.instantiateImageCodec(pngBytes3.buffer.asUint8List());
  final frameInfo3 = await codec3.getNextFrame();
  final pngImage3 = frameInfo3.image;

  // Calculate the canvas width and height
  double canvasHeight = textHadith.height + imageHeight + 3 * padding;

  // Calculate the new image sizes and positions
  final image3Width = pngImage3.width.toDouble() / 1.0;
  final image3Height = pngImage3.height.toDouble() / 1.0;
  final image3X =
      (canvasWidth - image3Width) / 2; // Center the image horizontally

  // String? countZkr;
  // if (cubit.shareTafseerValue == 1) {
  //   countZkr = cubit.radioValue != 3 ? null : AppLocalizations.of(context)!.tafSaadiN;
  // } else if (cubit.shareTafseerValue == 2) {
  //   countZkr = transName[cubit.transIndex!];
  // }

  final nameBook = TextPainter(
      text: TextSpan(
        text: bookName,
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.normal,
          fontFamily: 'kufi',
          color: const Color(0xff3C2A21),
          backgroundColor: const Color(0xff3C2A21).withOpacity(.2),
        ),
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right);
  nameBook.layout(maxWidth: 400);

  const nameBookX = padding + 10;
  const nameBookY = padding + 50;

  // Create the new text painter
  final numberHadith = TextPainter(
      text: TextSpan(
        text: '$hadithNumber',
        style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.normal,
            fontFamily: 'kufi',
            color: const Color(0xff3C2A21),
            backgroundColor: const Color(0xff3C2A21).withOpacity(.3)),
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify);
  numberHadith.layout(maxWidth: 800);

  const numberHadithX = padding + 50;
  final numberHadithY = textY + textHadith.height + padding + 10;

  double image3Y;
  // Calculate the position of the new image to be below the new text
  /// FIXME: The type of the right operand [('String')] isn't a subtype or a supertype of the left operand ('int').
  hadithNumber == ""
      ? (image3Y = textY + textHadith.height + 40)
      : image3Y = numberHadithY + numberHadith.height + 20;

  // Calculate the minimum height
  final minHeight = imageHeight + image2Height + image3Height + 4 * padding;

  // Set the canvas width and height
  canvasHeight = textHadith.height +
      numberHadith.height +
      imageHeight +
      image2Height +
      image3Height * padding;

  /// FIXME: The type of the right operand [('String')] isn't a subtype or a supertype of the left operand ('int').
  final countZkrY = hadithNumber == ""
      ? textY + textHadith.height + padding + 5
      : textY + textHadith.height + numberHadith.height + padding + 40;
  // Check if the total height is less than the minimum height
  if (canvasHeight < minHeight) {
    canvasHeight = minHeight;
  }

  // Update the canvas height
  canvasHeight += image3Height + numberHadith.height + 30 + padding;

  final pictureRecorder = ui.PictureRecorder();
  final canvas = Canvas(
      pictureRecorder,
      Rect.fromLTWH(
          0, 0, canvasWidth, canvasHeight)); // Add Rect to fix the canvas size

  const borderRadius = 25.0;
  final borderPaint = Paint()
    ..color = const Color(0xff3C2A21)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 25;

  final backgroundPaint = Paint()..color = const Color(0xffF7F1EC);

  final rRect = RRect.fromLTRBR(
      0, 0, canvasWidth, canvasHeight, const Radius.circular(borderRadius));

  canvas.drawRRect(rRect, backgroundPaint);
  canvas.drawRRect(rRect, borderPaint);
  nameBook.paint(canvas, const Offset(nameBookX, nameBookY));
  textHadith.paint(canvas, Offset(textX, textY));
  canvas.drawImageRect(
    pngImage,
    Rect.fromLTWH(0, 0, pngImage.width.toDouble(), pngImage.height.toDouble()),
    Rect.fromLTWH(imageX, imageY, imageWidth, imageHeight),
    Paint(),
  );

  canvas.drawImageRect(
    pngImage2,
    Rect.fromLTWH(
        0, 0, pngImage2.width.toDouble(), pngImage2.height.toDouble()),
    Rect.fromLTWH(image2X, image2Y, image2Width, image2Height),
    Paint(),
  );

  canvas.drawImageRect(
    pngImage3,
    Rect.fromLTWH(
        0, 0, pngImage3.width.toDouble(), pngImage3.height.toDouble()),
    Rect.fromLTWH(image3X, image3Y, image3Width, image3Height),
    Paint(),
  );

  numberHadith.paint(canvas, Offset(numberHadithX, numberHadithY));

  final picture = pictureRecorder.endRecording();
  final imgWidth = canvasWidth
      .toInt(); // Use canvasWidth instead of (textHadith.width + 2 * padding)
  /// FIXME: The type of the right operand [('String')] isn't a subtype or a supertype of the left operand ('int').
  final imgHeight = hadithNumber == ""
      ? (textHadith.height + imageHeight + image3Height + 5.6 * padding).toInt()
      : (textHadith.height +
              numberHadith.height +
              imageHeight +
              image3Height +
              7.1 * padding)
          .toInt();

  const imgScaleFactor = 1; // Increase this value for a higher resolution image
  final imgScaled = await picture.toImage(
      imgWidth * imgScaleFactor, imgHeight * imgScaleFactor);

  // Convert the image to PNG bytes
  final pngResultBytes =
      await imgScaled.toByteData(format: ui.ImageByteFormat.png);

  // Decode the PNG bytes to an image object
  final decodedImage = img.decodePng(pngResultBytes!.buffer.asUint8List());

  // Scale down the image to the desired resolution
  final resizedImage =
      img.copyResize(decodedImage!, width: imgWidth, height: imgHeight);

  // Convert the resized image back to PNG bytes
  final resizedPngBytes = img.encodePng(resizedImage);

  return resizedPngBytes;
}

Future<Uint8List> createHadithWithTranslateImage(
    int hadithNumber,
    int bookNumber,
    String hadithText,
    String hadithTranslate,
    String bookName) async {
  // Set a fixed canvas width
  const canvasWidth = 960.0;
  // const fixedWidth = canvasWidth;

  final textZkr = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: hadithText,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.normal,
              fontFamily: 'naskh',
              color: Color(0xff3C2A21),
            ),
          ),
          // TextSpan(
          //   text: ' ${arabicNumber.convert(zkrCount)}\n',
          //   style: TextStyle(
          //     fontSize: 50,
          //     fontWeight: FontWeight.normal,
          //     fontFamily: 'kufi',
          //     color: ThemeProvider.themeOf(context).id == 'dark'
          //         ? Colors.white
          //         : const Color(0xff3C2A21),
          //   ),
          // ),
        ],
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify);
  textZkr.layout(maxWidth: 800);

  const padding = 32.0;
  // final imagePadding = 20.0;

  // Load the PNG image
  final pngBytes = await rootBundle.load('assets/images/frame.png');
  final codec = await ui.instantiateImageCodec(pngBytes.buffer.asUint8List());
  final frameInfo = await codec.getNextFrame();
  final pngImage = frameInfo.image;

  // Load the second PNG image
  final pngBytes2 = await rootBundle.load('assets/images/sunti_logo.png');
  final codec2 = await ui.instantiateImageCodec(pngBytes2.buffer.asUint8List());
  final frameInfo2 = await codec2.getNextFrame();
  final pngImage2 = frameInfo2.image;

  // Calculate the image sizes and positions
  final imageWidth = pngImage.width.toDouble() / 1.0;
  final imageHeight = pngImage.height.toDouble() / 1.0;
  final imageX = (canvasWidth - imageWidth) / 2; // Center the first image
  const imageY = padding - 20;

  final image2Width = pngImage2.width.toDouble() / 8.0;
  final image2Height = pngImage2.height.toDouble() / 8.0;
  const image2X = padding + 750; // Center the second image
  final image2Y = imageHeight + padding - 50; // Adjust this value as needed

  // Set the text position
  final textX =
      (canvasWidth - textZkr.width) / 2; // Center the text horizontally
  final textY = image2Y +
      image2Height +
      padding +
      20; // Position the text below the second image

  final pngBytes3 = await rootBundle.load('assets/images/frame.png');
  final codec3 = await ui.instantiateImageCodec(pngBytes3.buffer.asUint8List());
  final frameInfo3 = await codec3.getNextFrame();
  final pngImage3 = frameInfo3.image;

  // Calculate the canvas width and height
  double canvasHeight = textZkr.height + imageHeight + 3 * padding;

  // Calculate the new image sizes and positions
  final image3Width = pngImage3.width.toDouble() / 1.0;
  final image3Height = pngImage3.height.toDouble() / 1.0;
  final image3X =
      (canvasWidth - image3Width) / 2; // Center the image horizontally

  // String? numberHadith;
  // if (cubit.shareTafseerValue == 1) {
  //   numberHadith = cubit.radioValue != 3 ? null : AppLocalizations.of(context)!.tafSaadiN;
  // } else if (cubit.shareTafseerValue == 2) {
  //   numberHadith = transName[cubit.transIndex!];
  // }

  final nameBook = TextPainter(
      text: TextSpan(
        text: '\n$bookName',
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.normal,
          fontFamily: 'kufi',
          color: const Color(0xff3C2A21),
          backgroundColor: const Color(0xff3C2A21).withOpacity(.2),
        ),
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right);
  nameBook.layout(maxWidth: 400);

  const nameBookX = padding + 10;
  const nameBookY = padding + 50;

  final numberHadith = TextPainter(
      text: TextSpan(
        text: '${arabicNumber.convert(hadithNumber)} \n',
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.normal,
          fontFamily: 'naskh',
          color: const Color(0xff3C2A21),
          backgroundColor: const Color(0xff3C2A21).withOpacity(.2),
        ),
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center);
  numberHadith.layout(maxWidth: 800);

  const numberHadithX = padding + 150;

  final numberBook = TextPainter(
      text: TextSpan(
        text: '$bookNumber',
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.normal,
          fontFamily: 'kufi',
          color: const Color(0xff3C2A21),
          backgroundColor: const Color(0xff3C2A21).withOpacity(.2),
        ),
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right);
  numberBook.layout(maxWidth: 400);

  const numberBookX = padding + 150;
  const numberBookY = padding + 50;

  // Calculate the position of the new image to be below the new text
  // final image3Y = numberHadithY + numberHadith.height + padding - 20;

  // final referenceZkr = TextPainter(
  //     text: TextSpan(
  //       text: '$azkarReference',
  //       style: TextStyle(
  //           fontSize: 35,
  //           fontWeight: FontWeight.normal,
  //           fontFamily: 'kufi',
  //           color: ThemeProvider.themeOf(context).id == 'dark'
  //               ? Colors.white
  //               : const Color(0xff3C2A21),
  //           backgroundColor: const Color(0xff41644A).withOpacity(.1)),
  //     ),
  //     textDirection: TextDirection.rtl,
  //     textAlign: TextAlign.right);
  // referenceZkr.layout(maxWidth: 800);
  //
  // final referenceZkrX = padding + 50;
  // final referenceZkrY = textY + textZkr.height + padding - 30;
  // Create the new text painter
  final translateHadith = TextPainter(
      text: TextSpan(
        text: '$hadithTranslate\n',
        style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.normal,
            fontFamily: 'kufi',
            color: const Color(0xff3C2A21),
            backgroundColor: const Color(0xff3C2A21).withOpacity(.3)),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.justify);
  translateHadith.layout(maxWidth: 800);

  const translateHadithX = padding + 50;
  final translateHadithY = textY + textZkr.height + padding + 40;

  double image3Y;
  // Calculate the position of the new image to be below the new text
  hadithTranslate == ""
      ? (image3Y = textY + textZkr.height + 40)
      : image3Y = translateHadithY + translateHadith.height - 10;

  // Calculate the minimum height
  final minHeight = imageHeight + image2Height + image3Height + 4 * padding;

  // Set the canvas width and height
  canvasHeight = textZkr.height +
      translateHadith.height +
      imageHeight +
      image2Height +
      image3Height * padding;
  final numberHadithY = textY + textZkr.height;
  // Check if the total height is less than the minimum height
  if (canvasHeight < minHeight) {
    canvasHeight = minHeight;
  }

  // Update the canvas height
  canvasHeight += image3Height + translateHadith.height + 30 + padding;

  final pictureRecorder = ui.PictureRecorder();
  final canvas = Canvas(
      pictureRecorder,
      Rect.fromLTWH(
          0, 0, canvasWidth, canvasHeight)); // Add Rect to fix the canvas size

  const borderRadius = 25.0;
  final borderPaint = Paint()
    ..color = const Color(0xff3C2A21)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 25;

  final backgroundPaint = Paint()..color = const Color(0xffF5EFE7);

  final rRect = RRect.fromLTRBR(
      0, 0, canvasWidth, canvasHeight, const Radius.circular(borderRadius));

  canvas.drawRRect(rRect, backgroundPaint);
  canvas.drawRRect(rRect, borderPaint);
  nameBook.paint(canvas, const Offset(nameBookX, nameBookY));
  numberBook.paint(canvas, const Offset(numberBookX, numberBookY));
  textZkr.paint(canvas, Offset(textX, textY));
  canvas.drawImageRect(
    pngImage,
    Rect.fromLTWH(0, 0, pngImage.width.toDouble(), pngImage.height.toDouble()),
    Rect.fromLTWH(imageX, imageY, imageWidth, imageHeight),
    Paint(),
  );

  canvas.drawImageRect(
    pngImage2,
    Rect.fromLTWH(
        0, 0, pngImage2.width.toDouble(), pngImage2.height.toDouble()),
    Rect.fromLTWH(image2X, image2Y, image2Width, image2Height),
    Paint(),
  );

  canvas.drawImageRect(
    pngImage3,
    Rect.fromLTWH(
        0, 0, pngImage3.width.toDouble(), pngImage3.height.toDouble()),
    Rect.fromLTWH(image3X, image3Y, image3Width, image3Height),
    Paint(),
  );

  translateHadith.paint(canvas, Offset(translateHadithX, translateHadithY));
  numberHadith.paint(canvas, Offset(numberHadithX, numberHadithY));

  final picture = pictureRecorder.endRecording();
  final imgWidth = canvasWidth
      .toInt(); // Use canvasWidth instead of (textZkr.width + 2 * padding)
  final imgHeight = hadithTranslate == ""
      ? (textZkr.height + imageHeight + image3Height + 5.6 * padding).toInt()
      : (textZkr.height +
              translateHadith.height +
              imageHeight +
              image3Height +
              7.1 * padding)
          .toInt();

  const imgScaleFactor = 1; // Increase this value for a higher resolution image
  final imgScaled = await picture.toImage(
      imgWidth * imgScaleFactor, imgHeight * imgScaleFactor);

  // Convert the image to PNG bytes
  final pngResultBytes =
      await imgScaled.toByteData(format: ui.ImageByteFormat.png);

  // Decode the PNG bytes to an image object
  final decodedImage = img.decodePng(pngResultBytes!.buffer.asUint8List());

  // Scale down the image to the desired resolution
  final resizedImage =
      img.copyResize(decodedImage!, width: imgWidth, height: imgHeight);

  // Convert the resized image back to PNG bytes
  final resizedPngBytes = img.encodePng(resizedImage);

  return resizedPngBytes;
}

shareText(String hadithText, String bookName, int hadithNumber) {
  Share.share(
      '﴿$hadithText﴾ '
      '[$bookName-'
      '$hadithNumber]',
      subject: bookName);
}

Future<void> shareHadithWithTranslate(int hadithNumber, int bookNumber,
    String hadithText, String hadithTranslate, String bookName) async {
  final imageData = await createHadithWithTranslateImage(
      hadithNumber, bookNumber, hadithText, hadithTranslate, bookName);

  // Save the image to a temporary directory
  final directory = await getTemporaryDirectory();
  final filename = 'verse_${DateTime.now().millisecondsSinceEpoch}.png';
  final imagePath = '${directory.path}/$filename';
  final imageFile = File(imagePath);
  await imageFile.writeAsBytes(imageData);

  if (imageFile.existsSync()) {
    await Share.shareXFiles([XFile((imagePath))], text: 'appName'.tr);
  } else {
    debugPrint('Failed to save and share image');
  }
}

Future<void> shareHadith(BuildContext context, String hadithText,
    String bookName, int hadithNumber) async {
  final imageData2 =
      await createHadithImage(hadithText, bookName, hadithNumber);

  // Save the image to a temporary directory
  final directory = await getTemporaryDirectory();
  final filename = 'verse_${DateTime.now().millisecondsSinceEpoch}.png';
  final imagePath = '${directory.path}/$filename';
  final imageFile = File(imagePath);
  await imageFile.writeAsBytes(imageData2);

  if (imageFile.existsSync()) {
    await Share.shareXFiles([XFile((imagePath))], text: 'appName'.tr);
  } else {
    debugPrint('Failed to save and share image');
  }
}

Future<void> showHadithOptionsBottomSheet(
    BuildContext context,
    int hadithNumber,
    int bookNumber,
    String hadithText,
    String hadithTranslate,
    String bookName) async {
  // Call createVerseWithTranslateImage and get the image data
  Uint8List imageData = await createHadithWithTranslateImage(
      hadithNumber, bookNumber, hadithText, hadithTranslate, bookName);
  Uint8List imageData2 =
      await createHadithImage(hadithText, bookName, hadithNumber);

  screenModalBottomSheet(
    context,
    Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            button_curve(context),
            GestureDetector(
              child: close(context, height: 30.0),
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                )),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      margin: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: shareLottie(width: 140.0)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90.0),
                  child: ListView(
                    children: [
                      GestureDetector(
                        child: beigeContainer(
                          context,
                          Column(
                            children: [
                              Text(
                                'shareText'.tr,
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context).id ==
                                            'dark'
                                        ? Theme.of(context).colorScheme.surface
                                        : Theme.of(context).primaryColorDark,
                                    fontSize: 16,
                                    fontFamily: 'kufi'),
                              ),
                              whiteContainer(
                                  context,
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.text_fields,
                                          color: Color(0xff91a57d),
                                          size: 24,
                                        ),
                                        SizedBox(
                                          width: orientation(
                                              context,
                                              MediaQuery.sizeOf(context).width *
                                                  .7,
                                              MediaQuery.sizeOf(context).width /
                                                  1 /
                                                  3),
                                          child: Text(
                                            hadithText,
                                            style: TextStyle(
                                                color: ThemeProvider.themeOf(
                                                                context)
                                                            .id ==
                                                        'dark'
                                                    ? Theme.of(context)
                                                        .canvasColor
                                                    : Theme.of(context)
                                                        .primaryColorDark,
                                                fontSize: 16,
                                                fontFamily: 'uthmanic2'),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  width: MediaQuery.sizeOf(context).width),
                            ],
                          ),
                        ),
                        onTap: () {
                          shareText(hadithText, bookName, hadithNumber);
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        height: 2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        width: MediaQuery.sizeOf(context).width * .3,
                        color: const Color(0xffE6DAC8),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: GestureDetector(
                              child: beigeContainer(
                                context,
                                Column(
                                  children: [
                                    Text(
                                      'shareImage'.tr,
                                      style: TextStyle(
                                          color:
                                              ThemeProvider.themeOf(context)
                                                          .id ==
                                                      'dark'
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .surface
                                                  : Theme.of(context)
                                                      .primaryColorDark,
                                          fontSize: 16,
                                          fontFamily: 'kufi'),
                                    ),
                                    Image.memory(
                                      imageData2,
                                      // height: 150,
                                      // width: 150,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                shareHadith(context, hadithText, bookName,
                                    hadithNumber);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 32.0,
                          ),
                          Expanded(
                            flex: 4,
                            child: GestureDetector(
                              child: beigeContainer(
                                context,
                                Column(
                                  children: [
                                    Text(
                                      'shareImageWTrans'.tr,
                                      style: TextStyle(
                                        color:
                                            ThemeProvider.themeOf(context)
                                                        .id ==
                                                    'dark'
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .surface
                                                : Theme.of(context)
                                                    .primaryColorDark,
                                        fontSize: 16,
                                        fontFamily: 'kufi',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.memory(
                                      imageData,
                                      // height: 150,
                                      // width: 150,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                shareHadithWithTranslate(
                                    hadithNumber,
                                    bookNumber,
                                    hadithText,
                                    hadithTranslate,
                                    bookName);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
