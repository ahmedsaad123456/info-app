import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BaseOtpField extends StatelessWidget {
  const BaseOtpField(
      {super.key,
      this.onChanged,
      this.length = 4,
      this.spaceBetween = 8,
      this.borderRadius = 8,
      this.fieldWidth = 64,
      this.fieldHeight = 64,
      size});

  final Function(String)? onChanged;
  final int length;
  final double spaceBetween;
  final double borderRadius;
  final double fieldWidth;
  final double fieldHeight;

  @override
  Widget build(BuildContext context) {
    return OTPTextField(
      length: length,
      contentWidth: MediaQuery.of(context).size.width,
      fieldWidth: fieldWidth,
      isDense: true,
      contentPadding: const EdgeInsets.only(
        right: 8,
        left: 8,
        top: 10,
        bottom: 7,
      ),
      spaceBetween: spaceBetween,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Theme.of(context).cardColor,
          ),
      hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Theme.of(context).dividerColor,
          ),
      textFieldAlignment: MainAxisAlignment.center,
      fieldStyle: FieldStyle.box,
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: Colors.transparent,
          borderColor: Theme.of(context).dividerColor,
          disabledBorderColor: Theme.of(context).dividerColor,
          enabledBorderColor: Theme.of(context).dividerColor,
          focusBorderColor: Theme.of(context).primaryColor,
          errorBorderColor: Colors.red),
      borderRadius: borderRadius,
      inputFormatter: [getMaskCode()],
      onChanged: onChanged,
    );
  }
}

RegExp numberExp = RegExp(r'[0-9]');
MaskTextInputFormatter getMaskCode() {
  return MaskTextInputFormatter(
    mask: '#',
    filter: {"#": numberExp},
  );
}

enum FieldStyle { underline, box }

class OtpFieldStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color focusBorderColor;
  final Color disabledBorderColor;
  final Color enabledBorderColor;
  final Color errorBorderColor;

  OtpFieldStyle({
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.black26,
    this.focusBorderColor = Colors.blue,
    this.disabledBorderColor = Colors.grey,
    this.enabledBorderColor = Colors.black26,
    this.errorBorderColor = Colors.red,
  });
}

class OTPTextField extends StatefulWidget {
  final OtpFieldController? controller;
  final int length;
  final double contentWidth;
  final double fieldWidth;
  final double spaceBetween;
  final EdgeInsets contentPadding;
  final TextInputType keyboardType;
  final bool hasError;
  final TextStyle style;
  final TextStyle hintStyle;
  final double borderRadius;
  final MainAxisAlignment textFieldAlignment;
  final bool obscureText;
  final bool isDense;
  final OtpFieldStyle? otpFieldStyle;
  final FieldStyle fieldStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final List<TextInputFormatter>? inputFormatter;

  const OTPTextField({
    super.key,
    this.length = 4,
    this.contentWidth = 10,
    this.controller,
    this.fieldWidth = 30,
    this.spaceBetween = 0,
    this.otpFieldStyle,
    this.hasError = false,
    this.keyboardType = TextInputType.number,
    this.style = const TextStyle(),
    this.hintStyle = const TextStyle(),
    this.borderRadius = 10,
    this.textFieldAlignment = MainAxisAlignment.spaceBetween,
    this.obscureText = false,
    this.fieldStyle = FieldStyle.underline,
    this.onChanged,
    this.inputFormatter,
    this.contentPadding =
        const EdgeInsets.only(right: 4, left: 4, bottom: 8, top: 8),
    this.isDense = false,
    this.onCompleted,
  }) : assert(length > 1);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  late OtpFieldStyle _otpFieldStyle;
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;

  late List<String> _pin;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      widget.controller!.setOtpTextFieldState(this);
    }

    if (widget.otpFieldStyle == null) {
      _otpFieldStyle = OtpFieldStyle();
    } else {
      _otpFieldStyle = widget.otpFieldStyle!;
    }

    _focusNodes = List<FocusNode?>.filled(widget.length, null, growable: false);
    _textControllers = List<TextEditingController?>.filled(widget.length, null,
        growable: false);

    _pin = List.generate(widget.length, (int i) {
      return '';
    });
  }

  @override
  void dispose() {
    for (var controller in _textControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.contentWidth,
      child: Row(
        mainAxisAlignment: widget.textFieldAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(widget.length, (index) {
          return buildTextField(context, index);
        }),
      ),
    );
  }

  InputBorder _getBorder(Color color) {
    final colorOrError =
        widget.hasError ? _otpFieldStyle.errorBorderColor : color;

    return widget.fieldStyle == FieldStyle.box
        ? OutlineInputBorder(
            borderSide: BorderSide(color: colorOrError),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          )
        : UnderlineInputBorder(borderSide: BorderSide(color: colorOrError));
  }

  Widget buildTextField(BuildContext context, int index) {
    if (_focusNodes[index] == null) _focusNodes[index] = FocusNode();

    if (_textControllers[index] == null) {
      _textControllers[index] = TextEditingController();
    }
    final isLast = index == widget.length - 1;

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: isLast ? 0 : widget.spaceBetween),
      child: TextFormField(
        cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
        cursorWidth: 1,
        controller: _textControllers[index],
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.center,
        style: widget.style,
        inputFormatters: widget.inputFormatter,
        maxLength: 1,
        focusNode: _focusNodes[index],
        obscureText: widget.obscureText,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          constraints: BoxConstraints(
            minHeight: widget.fieldWidth,
            minWidth: widget.fieldWidth,
          ),
          isDense: widget.isDense,
          filled: true,
          fillColor: _otpFieldStyle.backgroundColor,
          counterText: "",
          hintText: '0',
          hintStyle: widget.hintStyle,
          contentPadding: widget.contentPadding,
          border: _getBorder(_otpFieldStyle.borderColor),
          focusedBorder: _getBorder(_otpFieldStyle.focusBorderColor),
          enabledBorder: _getBorder(_otpFieldStyle.enabledBorderColor),
          disabledBorder: _getBorder(_otpFieldStyle.disabledBorderColor),
          errorBorder: _getBorder(_otpFieldStyle.errorBorderColor),
          focusedErrorBorder: _getBorder(_otpFieldStyle.errorBorderColor),
          errorText: null,
          errorStyle: const TextStyle(height: 0, fontSize: 0),
        ),
        onChanged: (String str) {
          if (str.length > 1) {
            _handlePaste(str);
            return;
          }

          if (str.isEmpty) {
            if (index == 0) return;
            _focusNodes[index]!.unfocus();
            _focusNodes[index - 1]!.requestFocus();
          }

          setState(() {
            _pin[index] = str;
          });

          if (str.isNotEmpty) _focusNodes[index]!.unfocus();
          if (index + 1 != widget.length && str.isNotEmpty) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }

          String currentPin = _getCurrentPin();

          if (!_pin.contains(null) &&
              !_pin.contains('') &&
              currentPin.length == widget.length) {
            widget.onCompleted?.call(currentPin);
          }

          widget.onChanged!(currentPin);
        },
      ),
    );
  }

  String _getCurrentPin() {
    String currentPin = "";
    for (var value in _pin) {
      currentPin += value;
    }
    return currentPin;
  }

  void _handlePaste(String str) {
    if (str.length > widget.length) {
      str = str.substring(0, widget.length);
    }

    for (int i = 0; i < str.length; i++) {
      String digit = str.substring(i, i + 1);
      _textControllers[i]!.text = digit;
      _pin[i] = digit;
    }

    FocusScope.of(context).requestFocus(_focusNodes[widget.length - 1]);

    String currentPin = _getCurrentPin();

    if (!_pin.contains(null) &&
        !_pin.contains('') &&
        currentPin.length == widget.length) {
      widget.onCompleted?.call(currentPin);
    }
    widget.onChanged!(currentPin);
  }
}

class OtpFieldController {
  late _OTPTextFieldState _otpTextFieldState;

  void setOtpTextFieldState(_OTPTextFieldState state) {
    _otpTextFieldState = state;
  }

  void clear() {
    final textFieldLength = _otpTextFieldState.widget.length;
    _otpTextFieldState._pin = List.generate(textFieldLength, (int i) {
      return '';
    });

    final textControllers = _otpTextFieldState._textControllers;
    for (var textController in textControllers) {
      if (textController != null) {
        textController.text = '';
      }
    }

    final firstFocusNode = _otpTextFieldState._focusNodes[0];
    if (firstFocusNode != null) {
      firstFocusNode.requestFocus();
    }
  }

  void set(List<String> pin) {
    final textFieldLength = _otpTextFieldState.widget.length;
    if (pin.length < textFieldLength) {
      throw Exception(
          "Pin length must be same as field length. Expected: $textFieldLength, Found ${pin.length}");
    }

    _otpTextFieldState._pin = pin;
    String newPin = '';

    final textControllers = _otpTextFieldState._textControllers;
    for (int i = 0; i < textControllers.length; i++) {
      final textController = textControllers[i];
      final pinValue = pin[i];
      newPin += pinValue;

      if (textController != null) {
        textController.text = pinValue;
      }
    }

    final widget = _otpTextFieldState.widget;

    widget.onChanged?.call(newPin);

    widget.onCompleted?.call(newPin);
  }

  void setValue(String value, int position) {
    final maxIndex = _otpTextFieldState.widget.length - 1;
    if (position > maxIndex) {
      throw Exception(
          "Provided position is out of bounds for the OtpTextField");
    }

    final textControllers = _otpTextFieldState._textControllers;
    final textController = textControllers[position];
    final currentPin = _otpTextFieldState._pin;

    if (textController != null) {
      textController.text = value;
      currentPin[position] = value;
    }

    String newPin = "";
    for (var item in currentPin) {
      newPin += item;
    }

    final widget = _otpTextFieldState.widget;
    if (widget.onChanged != null) {
      widget.onChanged!(newPin);
    }
  }

  void setFocus(int position) {
    final maxIndex = _otpTextFieldState.widget.length - 1;
    if (position > maxIndex) {
      throw Exception(
          "Provided position is out of bounds for the OtpTextField");
    }

    final focusNodes = _otpTextFieldState._focusNodes;
    final focusNode = focusNodes[position];

    if (focusNode != null) {
      focusNode.requestFocus();
    }
  }
}
