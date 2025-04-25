import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart_code_viewer_theme.dart';
import 'pre_highlighter.dart';

/// A code viewer for the dart language.
///
/// A code viewer can be used to display dart code. By default the [DartCodeViewer]
/// gives you a Theme based code view. If you are using a [ThemeMode] that is light
/// than you will get the light option. Note that the default background of the code
/// viewer is based off [ColorScheme.background].
///
/// Supplying a non-null [data] String is required as input.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// Requires one of its ancestors to be a [MediaQuery] widget. Typically, these
/// are introduced by the [MaterialApp] or [WidgetsApp] widget at the top of
/// your application widget tree.
///
/// {@tool dartpad --template=stateless_widget_scaffold}
///
/// ![A dart_code_viewer example for light mode.]
/// (https://github.com/JoseAlba/dart_code_viewer/images/import_example)
///
/// Here is an example of a small string that shows up as Dart code in a flutter
/// application.
///
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return DartCodeViewer(r'class DartCodeViewer extends StatelessWidget {}');
/// }
/// ```
/// {@end-tool}
///
/// See also:
///  * [DartCodeViewerTheme] and [DartCodeViewerThemeData] for information about
///  controlling the visual appearance of the DartCodeViewer.
///  * [Code viewer online tool](https://romannurik.github.io/SlidesCodeHighlighter/)
///  is a useful tool that lets you choose the color for each different style.
///  On the left side you put your example code and on the right you can choose
///  the colors you want the code viewer to display.
///    background => backgroundColor
///    plain text => baseStyle
///    Punctuation => punctuationStyle
///    String, values => stringStyle
///    Keywords, tags => keywordStyle
///    Comments => commentStyle
///    Types => classStyle
///    Numbers => numberStyle
///    Declarations => constantStyle
///  * [MediaQuery], from which the default height and width factor is obtained.
class DartCodeViewer extends StatelessWidget {
  /// DartCodeViewer requires a [String] that will be the code shown within the
  /// code viewer. This should be dart code and it is preferable if you use a raw
  /// string by adding an r before the string.
  const DartCodeViewer(
    this.data, {
    Key? key,
    this.baseStyle,
    this.classStyle,
    this.commentStyle,
    this.constantStyle,
    this.keywordStyle,
    this.numberStyle,
    this.punctuationStyle,
    this.stringStyle,
    this.backgroundColor,
    this.copyButtonText,
    this.showCopyButton,
    this.height,
    this.width,
  }) : super(key: key);

  /// Create a DartCodeViewer based of one [TextStyle]. Optional [Color] parameters
  /// which change the TextStyle color for that highlighter type.
  ///
  /// The default [TextStyle] is [RobotoMono].
  ///
  /// Useful parameter when you want to use one [TextStyle].
  factory DartCodeViewer.textColor(
    String data, {
    TextStyle? textStyle,
    Color? baseColor,
    Color? classColor,
    Color? commentColor,
    Color? constantColor,
    Color? keywordColor,
    Color? numberColor,
    Color? punctuationColor,
    Color? stringColor,
    Color? backgroundColor,
    Text? copyButtonText,
    bool? showCopyButton,
    double? height,
    double? width,
  }) {
    return DartCodeViewer(
      data,
      baseStyle: textStyle?.copyWith(color: baseColor),
      classStyle: textStyle?.copyWith(color: classColor),
      commentStyle: textStyle?.copyWith(color: commentColor),
      constantStyle: textStyle?.copyWith(color: constantColor),
      keywordStyle: textStyle?.copyWith(color: keywordColor),
      numberStyle: textStyle?.copyWith(color: numberColor),
      punctuationStyle: textStyle?.copyWith(color: punctuationColor),
      stringStyle: textStyle?.copyWith(color: stringColor),
      backgroundColor: backgroundColor,
      copyButtonText: copyButtonText,
      showCopyButton: showCopyButton,
      height: height,
      width: width,
    );
  }

  /// Common code viewer highlighter for [ThemeMode.light].
  factory DartCodeViewer.light(String data) {
    return DartCodeViewer.textColor(
      data,
      baseColor: Colors.blueGrey.shade800,
      classColor: Colors.purple.shade500,
      commentColor: Colors.pink.shade600,
      constantColor: Colors.indigo.shade500,
      keywordColor: Colors.indigo.shade500,
      numberColor: Colors.red.shade700,
      punctuationColor: Colors.blueGrey.shade800,
      stringColor: Colors.green.shade700,
      backgroundColor: Colors.grey.shade100,
    );
  }

  /// Code viewer light alternative for [ThemeMode.light].
  factory DartCodeViewer.lightAlt(String data) {
    return DartCodeViewer.textColor(
      data,
      baseColor: Colors.black,
      classColor: const Color(0xFF673AB7),
      commentColor: const Color(0xFF999999),
      constantColor: const Color(0xFFE67C73),
      keywordColor: const Color(0xFF4285F4),
      numberColor: const Color(0xFFDB4437),
      punctuationColor: const Color(0xFFA3A3A3),
      stringColor: const Color(0xFF0F9D58),
      backgroundColor: const Color(0xFFEEEEEE),
    );
  }

  /// Common code viewer highlighter for [ThemeMode.dark].
  factory DartCodeViewer.dark(String data) {
    return DartCodeViewer.textColor(
      data,
      baseColor: Colors.blueGrey.shade50,
      classColor: Colors.purple.shade200,
      commentColor: Colors.pink.shade300,
      constantColor: Colors.yellow.shade700,
      keywordColor: Colors.cyan.shade300,
      numberColor: Colors.yellow.shade700,
      punctuationColor: Colors.blueGrey.shade50,
      stringColor: Colors.lightGreen.shade400,
      backgroundColor: Colors.grey.shade900,
    );
  }

  /// Code viewer dark alternative for [ThemeMode.dark].
  factory DartCodeViewer.darkAlt(String data) {
    return DartCodeViewer.textColor(
      data,
      baseColor: Colors.white,
      classColor: const Color(0xFFFF8A65),
      commentColor: const Color(0xFFAAAAAA),
      constantColor: const Color(0xFFE67C73),
      keywordColor: const Color(0xFF7BAAF7),
      numberColor: const Color(0xFFF4B400),
      punctuationColor: const Color(0xFFA3A3A3),
      stringColor: const Color(0xFF57BB8A),
      backgroundColor: const Color(0xFF000000),
    );
  }

  /// Code viewer highlighter with a great dark design for [ThemeMode.dark].
  factory DartCodeViewer.designDark(String data) {
    return DartCodeViewer.textColor(
      data,
      baseColor: Colors.white,
      classColor: const Color(0xFFFF8A80),
      commentColor: const Color(0xFF607D8B),
      constantColor: const Color(0xFF90A4AE),
      keywordColor: const Color(0xFF26C6DA),
      numberColor: const Color(0xFFFFBC00),
      punctuationColor: const Color(0xFF90A4AE),
      stringColor: const Color(0xFF00BFA4),
      backgroundColor: const Color(0xFF263238),
    );
  }

  /// Code viewer highlighter for Google IO 2017.
  factory DartCodeViewer.io17(String data) {
    return DartCodeViewer.textColor(
      data,
      baseColor: Colors.white,
      classColor: const Color(0xFFFF8857),
      commentColor: const Color(0xFFFF5CB4),
      constantColor: const Color(0xFF90A4AE),
      keywordColor: const Color(0xFF00E4FF),
      numberColor: const Color(0xFFFFD500),
      punctuationColor: const Color(0xFF90A4AE),
      stringColor: const Color(0xFF1CE8b5),
      backgroundColor: const Color(0xFF263238),
    );
  }

  /// Code viewer highlighter for Google IO 2019.
  factory DartCodeViewer.io19(String data) {
    return DartCodeViewer.textColor(
      data,
      baseColor: Colors.white,
      classColor: const Color(0xFFEE675C),
      commentColor: const Color(0xFF9AA0A6),
      constantColor: const Color(0xFFFCC934),
      keywordColor: const Color(0xFF669DF6),
      numberColor: const Color(0xFFFCC934),
      punctuationColor: const Color(0xFF9AA0A6),
      stringColor: const Color(0xFF5BB974),
      backgroundColor: const Color(0xFF202124),
    );
  }

  /// Code viewer highlighter for Flutter Interact 2019.
  factory DartCodeViewer.flutterInteract19(String data) {
    return DartCodeViewer.textColor(
      data,
      baseColor: const Color(0xFFFAFBFB),
      classColor: const Color(0xFFD65BAD),
      commentColor: const Color(0xFF808080),
      constantColor: const Color(0xFFFF8383),
      keywordColor: const Color(0xFF1CDEC9),
      numberColor: const Color(0xFFBD93F9),
      punctuationColor: const Color(0xFF8BE9FD),
      stringColor: const Color(0xFFffa65c),
      backgroundColor: const Color(0xFF241e30),
    );
  }

  /// The string that is transformed into code. This is a required variable.
  final String data;

  /// The text style for the plain text in code.
  final TextStyle? baseStyle;

  /// The text style for the code types in the code.
  ///
  /// For example:
  /// * The class name.
  /// * StatelessWidget and StatefulWidget.
  final TextStyle? classStyle;

  /// The text style for the commented out code.
  final TextStyle? commentStyle;

  /// The text style for the constant style code.
  final TextStyle? constantStyle;

  /// The text style for keywords. For example:
  /// * else
  /// * enum
  /// * export
  /// * external
  /// * factory
  /// * false
  final TextStyle? keywordStyle;

  /// The text style for numbers within the code.
  final TextStyle? numberStyle;

  /// The text style for punctuation code like periods and commas.
  final TextStyle? punctuationStyle;

  /// The text style for Strings. For example the data when using the [Text] widget.
  final TextStyle? stringStyle;

  /// The background Color of the code. By default it is [Theme.of(context).colorScheme.background].
  final Color? backgroundColor;

  /// The text shown in the copy button by default it is 'COPY ALL'.
  final Text? copyButtonText;

  /// Shows copy button that lets user copy all the code as a raw string. By
  /// default the button is showing.
  final bool? showCopyButton;

  /// The height of the [DartCodeViewer] by default it uses the [MediaQuery.of(context).size.height]
  final double? height;

  /// The width of the [DartCodeViewer] by default it uses the [MediaQuery.of(context).size.width]
  final double? width;

  @override
  Widget build(BuildContext context) {
    final codeTextStyle = Theme.of(context).textTheme.bodyLarge;

    final lightModeOn = Theme.of(context).brightness == Brightness.light;

    // These are defaults for the different types of text styles. The default
    // returns two different types of styles depending on the brightness of the
    // application.
    final defaultBaseStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.blueGrey.shade800 : Colors.blueGrey.shade50,
    );
    final defaultClassStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.purple.shade500 : Colors.purple.shade200,
    );
    final defaultCommentStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.pink.shade600 : Colors.pink.shade300,
    );
    final defaultConstantStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.indigo.shade500 : Colors.yellow.shade700,
    );
    final defaultKeywordStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.indigo.shade500 : Colors.cyan.shade300,
    );
    final defaultNumberStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.red.shade700 : Colors.yellow.shade700,
    );
    final defaultPunctuationalStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.blueGrey.shade800 : Colors.blueGrey.shade50,
    );
    final defaultStringStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.green.shade700 : Colors.lightGreen.shade400,
    );

    const defaultCopyButtonText = Text('COPY ALL');
    const defaultShowCopyButton = true;

    var dartCodeViewerThemeData = DartCodeViewerTheme.of(context);
    dartCodeViewerThemeData = dartCodeViewerThemeData.copyWith(
      baseStyle:
          baseStyle ?? dartCodeViewerThemeData.baseStyle ?? defaultBaseStyle,
      classStyle:
          classStyle ?? dartCodeViewerThemeData.classStyle ?? defaultClassStyle,
      commentStyle:
          commentStyle ??
          dartCodeViewerThemeData.commentStyle ??
          defaultCommentStyle,
      constantStyle:
          constantStyle ??
          dartCodeViewerThemeData.constantStyle ??
          defaultConstantStyle,
      keywordStyle:
          keywordStyle ??
          dartCodeViewerThemeData.keywordStyle ??
          defaultKeywordStyle,
      numberStyle:
          numberStyle ??
          dartCodeViewerThemeData.numberStyle ??
          defaultNumberStyle,
      punctuationStyle:
          punctuationStyle ??
          dartCodeViewerThemeData.punctuationStyle ??
          defaultPunctuationalStyle,
      stringStyle:
          stringStyle ??
          dartCodeViewerThemeData.stringStyle ??
          defaultStringStyle,
      backgroundColor:
          backgroundColor ??
          dartCodeViewerThemeData.backgroundColor ??
          Theme.of(context).colorScheme.background,
      copyButtonText:
          copyButtonText ??
          dartCodeViewerThemeData.copyButtonText ??
          defaultCopyButtonText,
      showCopyButton:
          showCopyButton ??
          dartCodeViewerThemeData.showCopyButton ??
          defaultShowCopyButton,
      height:
          height ??
          dartCodeViewerThemeData.height ??
          MediaQuery.of(context).size.height,
      width:
          width ??
          dartCodeViewerThemeData.width ??
          MediaQuery.of(context).size.width,
    );

    return DartCodeViewerTheme(
      data: dartCodeViewerThemeData,
      child: Container(
        color: dartCodeViewerThemeData.backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: dartCodeViewerThemeData.height,
        width: dartCodeViewerThemeData.width,
        child: _DartCodeViewerPage(codifyString(data, dartCodeViewerThemeData)),
      ),
    );
  }

  InlineSpan codifyString(
    String content,
    DartCodeViewerThemeData dartCodeViewerThemeData,
  ) {
    final textSpans = <TextSpan>[];
    final codeSpans = DartSyntaxPreHighlighter().format(content);
    // Converting CodeSpan to TextSpan by first converting to a string and then TextSpan.
    for (final span in codeSpans) {
      textSpans.add(stringToTextSpan(span.toString(), dartCodeViewerThemeData));
    }
    return TextSpan(children: textSpans);
  }

  TextSpan stringToTextSpan(
    String string,
    DartCodeViewerThemeData dartCodeViewerThemeData,
  ) {
    return TextSpan(
      style: () {
        final String? styleString = RegExp(
          r'codeStyle.\w*',
        ).firstMatch(string)?.group(0);
        final dartCodeViewerTheme = dartCodeViewerThemeData;

        switch (styleString) {
          case 'codeStyle.baseStyle':
            return dartCodeViewerTheme.baseStyle;
          case 'codeStyle.numberStyle':
            return dartCodeViewerTheme.numberStyle;
          case 'codeStyle.commentStyle':
            return dartCodeViewerTheme.commentStyle;
          case 'codeStyle.keywordStyle':
            return dartCodeViewerTheme.keywordStyle;
          case 'codeStyle.stringStyle':
            return dartCodeViewerTheme.stringStyle;
          case 'codeStyle.punctuationStyle':
            return dartCodeViewerTheme.punctuationStyle;
          case 'codeStyle.classStyle':
            return dartCodeViewerTheme.classStyle;
          case 'codeStyle.constantStyle':
            return dartCodeViewerTheme.constantStyle;
          default:
            return dartCodeViewerTheme.baseStyle;
        }
      }(),
      text: () {
        final textString = RegExp('\'.*\'').firstMatch(string)?.group(0);
        final subString = textString!.substring(1, textString.length - 1);
        return decodeString(subString);
      }(),
    );
  }

  /// Read raw string as regular String. Converts Unicode characters to actual
  /// numbers.
  String decodeString(String string) {
    return string
        .replaceAll(r'\u000a', '\n')
        .replaceAll(r'\u0027', '\'')
        .replaceAll(r'\u0009', '\t')
        .replaceAll(r'\u0022', '"')
        .replaceAll(r'\u0024', '\$');
  }
}

class _DartCodeViewerPage extends StatelessWidget {
  const _DartCodeViewerPage(this.code);
  final InlineSpan code;

  @override
  Widget build(BuildContext context) {
    final richTextCode = code;
    final plainTextCode = richTextCode.toPlainText();

    void showSnackBarOnCopySuccess(dynamic result) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Copied to Clipboard')));
    }

    void showSnackBarOnCopyFailure(Object exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failure to copy to clipboard: $exception')),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (DartCodeViewerTheme.of(context).showCopyButton!)
          ElevatedButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: plainTextCode))
                  .then(showSnackBarOnCopySuccess)
                  .catchError(showSnackBarOnCopyFailure);
            },
            child: DartCodeViewerTheme.of(context).copyButtonText,
          ),
        Expanded(
          child: SingleChildScrollView(
            child: SelectableText.rich(
              TextSpan(
                text: "",
                children: [richTextCode],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ],
    );
  }
}
