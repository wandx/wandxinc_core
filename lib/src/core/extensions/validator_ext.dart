/// Validator extension on String
extension ValidatorExtOnString on String {
  /// Validate if the string is required
  String? Function(String?) validateRequired() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return this;
      }
      return null;
    };
  }

  /// Validate if the string is an email
  String? Function(String?) validateEmail() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return this;
      }
      return null;
    };
  }

  /// Validate if string is number
  String? Function(String?) validateNumber() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      final numberRegex = RegExp(r'^[0-9]+$');
      if (!numberRegex.hasMatch(value)) {
        return this;
      }
      return null;
    };
  }

  /// Validate if string has minimum length
  String? Function(String?) validateMinLength(int minLength) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (value.length < minLength) {
        return this;
      }
      return null;
    };
  }

  /// Validate if string has maximum length
  String? Function(String?) validateMaxLength(int maxLength) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (value.length > maxLength) {
        return this;
      }
      return null;
    };
  }

  /// Validate string should match other string
  String? Function(String?) validateMatch(String other) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (value != other) {
        return this;
      }
      return null;
    };
  }

  /// Validate need at least 1 uppercase letter
  String? Function(String?) validateAtLeastOneUpperCase() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      final upperCaseRegex = RegExp('[A-Z]');
      if (!upperCaseRegex.hasMatch(value)) {
        return this;
      }
      return null;
    };
  }

  /// Validate need at least 1 lowercase letter
  String? Function(String?) validateAtLeastOneLowerCase() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      final lowerCaseRegex = RegExp('[a-z]');
      if (!lowerCaseRegex.hasMatch(value)) {
        return this;
      }
      return null;
    };
  }

  /// Validate need at least 1 number
  String? Function(String?) validateAtLeastOneNumber() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      final numberRegex = RegExp('[0-9]');
      if (!numberRegex.hasMatch(value)) {
        return this;
      }
      return null;
    };
  }

  /// Validate need at least 1 special character
  String? Function(String?) validateAtLeastOneSpecialCharacter() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      final specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
      if (!specialCharacterRegex.hasMatch(value)) {
        return this;
      }
      return null;
    };
  }
}

/// Validator extension on List of Functions
extension ValidatorExtOnList on List<String? Function(String?)> {
  /// Validate a list of validators
  String? Function(String?)? compose() {
    if (isEmpty) {
      return null;
    }
    return (String? value) {
      for (final validator in this) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }
}
