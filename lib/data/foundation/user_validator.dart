import 'dart:async';

import 'package:dayaway_partner/data/foundation/extentions/extention.dart';

mixin UserInfoValidators {
  final accountValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.isTextNotEmpty) {
      if (email.isValidEmail()) {
        sink.add(email);
      } else {
        sink.addError('R.strings.emailNotValid');
      }
    } else {
      sink.addError('R.strings.emailRequired');
    }
  });

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 1) {
      sink.add(password);
    } else {
      sink.addError('R.strings.passwordChar');
    }
  });

  final firstNameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isTextNotEmpty) {
        sink.add(data);
      } else {
        sink.addError('R.strings.firstNameRequired');
      }
    },
  );

  final lastNameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isTextNotEmpty) {
        sink.add(data);
      } else {
        sink.addError('R.strings.lastNameRequired');
      }
    },
  );

  final phoneValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (phone, sink) {
      if (phone.isTextNotEmpty) {
        if (phone.isValidPhoneNumber()) {
          sink.add(phone);
        } else {
          sink.addError('R.strings.phoneNotValid');
        }
      } else {
        sink.addError('R.strings.phoneRequired');
      }
    },
  );

  final checkBoxValidator = StreamTransformer<bool, bool>.fromHandlers(
    handleData: (data, sink) {
      if (data) {
        sink.add(true);
      } else {
        sink.addError(false);
      }
    },
  );

  final currentPasswordValidator =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isTextNotEmpty) {
        sink.add(data);
      } else {
        sink.addError('R.strings.currentPasswordRequired');
      }
    },
  );

  final newPasswordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isTextNotEmpty) {
        sink.add(data);
      } else {
        sink.addError('R.strings.newPasswordRequired');
      }
    },
  );

  final confirmPasswordValidator =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isTextNotEmpty) {
        sink.add(data);
      } else {
        sink.addError('R.strings.confirmPasswordRequired');
      }
    },
  );
}
