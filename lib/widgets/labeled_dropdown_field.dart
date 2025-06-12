import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/statics/app_styles.dart';

class LabeledDropdownField<T> extends ConsumerStatefulWidget {
  final String label;
  final ProviderBase<AsyncValue<List<T>>> itemsProvider;
  final String? initialHintText;
  final String? loadingHintText;
  final String? emptyDataHintText;
  final String? errorHintText;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final FormFieldValidator<T?>? validator;
  final String Function(T item) itemText;
  final FocusNode? focusNode;

  const LabeledDropdownField({
    super.key,
    required this.label,
    required this.itemsProvider,
    this.initialHintText,
    this.loadingHintText,
    this.emptyDataHintText,
    this.errorHintText,
    this.onChanged,
    this.value,
    this.validator,
    required this.itemText,
    this.focusNode,
  });

  @override
  ConsumerState<LabeledDropdownField<T>> createState() =>
      _LabeledDropdownFieldState<T>();
}

class _LabeledDropdownFieldState<T>
    extends ConsumerState<LabeledDropdownField<T>> {
  final GlobalKey<FormFieldState<T>> _formFieldKey =
      GlobalKey<FormFieldState<T>>();
  
  // _hasValidationOrApiError is correctly used to style the border/icon for ANY error (validation or API)
  bool _hasValidationOrApiError = false; 
  // This will store the specific validation error message string for custom display
  String? _displayedValidationErrorText; 

  late FocusNode _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant LabeledDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      if (oldWidget.focusNode == null &&
          _internalFocusNode != widget.focusNode) {
        _internalFocusNode.dispose();
      }
      _internalFocusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  // This is the validator passed to DropdownButtonFormField's `validator` prop
  String? _dropdownFormFieldValidator(T? value) {
    final errorString = widget.validator?.call(value);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Update the displayed validation error text
        if (_displayedValidationErrorText != errorString) {
          setState(() {
            _displayedValidationErrorText = errorString;
          });
        }

        // Update the general error styling flag
        // This flag turns true if there's a validation error OR an API error.
        final bool hasValidationError = errorString != null;
        final bool isApiLoadingError = ref.read(widget.itemsProvider) is AsyncError;
        final bool newOverallErrorState = hasValidationError || isApiLoadingError;

        if (_hasValidationOrApiError != newOverallErrorState) {
          setState(() {
            _hasValidationOrApiError = newOverallErrorState;
          });
        }
      }
    });
    // IMPORTANT: Return null to prevent DropdownButtonFormField from showing its own error text.
    // The FormFieldState (accessed via _formFieldKey.currentState) will still correctly update its `hasError`
    // property based on what widget.validator returns, which allows us to change border colors.
    return null;
  }

  void _handleChanged(T? newValue) {
    widget.onChanged?.call(newValue);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _formFieldKey.currentState != null) {
        // This will call _dropdownFormFieldValidator
        _formFieldKey.currentState!.validate(); 
      }
      // Optionally unfocus after selection, if desired
      // _internalFocusNode.unfocus(); 
    });
  }

  Widget _buildDropdownItself({ // Renamed to avoid confusion with the outer _buildDropdownUI
    required List<T> items,
    required String? hint,
    bool isLoading = false,
    // bool isApiError = false, // isApiError is now part of _hasValidationOrApiError logic
    // VoidCallback? onRetry, // API retry is handled in the main build method now
  }) {
    // showErrorStyling is driven by _hasValidationOrApiError which includes API and validation errors
    bool showErrorStyling = _hasValidationOrApiError;

    return DropdownButtonFormField<T>(
      key: _formFieldKey,
      focusNode: _internalFocusNode,
      value: widget.value,
      hint: hint != null
          ? Text(hint,
              style: hintTextStyling.copyWith(
                  color: hintTextStyling.color, 
                  overflow: TextOverflow.ellipsis))
          : null,
      items: items.map((itemValue) {
        return DropdownMenuItem<T>(
          value: itemValue,
          child: Text(widget.itemText(itemValue),
              overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: isLoading ? null : _handleChanged,
      validator: _dropdownFormFieldValidator, // Use the wrapper validator
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: inputTextStyling,
      dropdownColor: Colors.white,
      iconEnabledColor: showErrorStyling ? errorBorderColor : iconColor,
      iconDisabledColor: showErrorStyling ? errorBorderColor : iconColor,
      decoration: _inputDecoration(showErrorStyling).copyWith(
        // Ensure default error display is suppressed
        errorText: null, // Explicitly set to null
        errorStyle: const TextStyle(height: 0, fontSize: 0), // Hide space for default error
      ),
      isExpanded: true,
      selectedItemBuilder: (BuildContext context) {
        if (widget.value == null && hint != null) {
           return [ Text(hint, style: hintTextStyling.copyWith(overflow: TextOverflow.ellipsis)) ];
        }
        return items.map<Widget>((T item) {
          return Text(
            widget.itemText(item),
            style: inputTextStyling,
            overflow: TextOverflow.ellipsis,
          );
        }).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncItems = ref.watch(widget.itemsProvider);

    // Update _hasValidationOrApiError if API call results in an error
    // This ensures border/icon styling reflects API errors immediately
    final bool isCurrentlyApiError = asyncItems is AsyncError;
    if (_hasValidationOrApiError != (isCurrentlyApiError || (_displayedValidationErrorText != null))) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _hasValidationOrApiError = isCurrentlyApiError || (_displayedValidationErrorText != null);
          });
        }
      });
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (_internalFocusNode.canRequestFocus && asyncItems is! AsyncLoading ) { // Don't open if loading
              _internalFocusNode.requestFocus();
            }
          },
          child: Text(widget.label, style: labelStyle)),
        const SizedBox(height: 4.0),
        asyncItems.when(
          data: (items) {
            String currentHint = widget.initialHintText ?? 'Pilih item';
            if (items.isEmpty && widget.value == null) {
              currentHint =
                  widget.emptyDataHintText ?? 'Tidak ada item tersedia';
            }
            return _buildDropdownItself(
              items: items,
              hint: widget.value != null ? null : currentHint,
              // isApiError: false, // Handled by _hasValidationOrApiError
            );
          },
          loading: () {
            return _buildDropdownItself(
              items: [],
              hint: widget.loadingHintText ?? 'Memuat...',
              isLoading: true,
              // isApiError: false, // Handled by _hasValidationOrApiError
            );
          },
          error: (err, stack) {
            // For API error, hint will show errorHintText
            // _hasValidationOrApiError will be true, styling borders/icons red.
            return _buildDropdownItself(
              items: [],
              hint: widget.errorHintText ?? 'Gagal memuat',
              // isApiError: true, // Handled by _hasValidationOrApiError
            );
          },
        ),

        // Custom Validation Error Text Display
        if (_displayedValidationErrorText != null && _displayedValidationErrorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Text(
              _displayedValidationErrorText!,
              style: const TextStyle(color: errorBorderColor, fontSize: 12.0),
            ),
          ),

        // API Error and Retry Button Display
        if (asyncItems is AsyncError) ...[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(widget.errorHintText ?? 'Gagal memuat data.',
                        style: const TextStyle(
                            color: errorBorderColor, fontSize: 12))),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      textStyle: const TextStyle(fontSize: 12)),
                  onPressed: () {
                     // Reset error states before retrying
                    if (mounted) {
                      setState(() {
                        _displayedValidationErrorText = null; // Clear validation error
                        _hasValidationOrApiError = false; // Reset general error flag before API call
                      });
                    }
                    ref.invalidate(widget.itemsProvider);
                  },
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }

  InputDecoration _inputDecoration(bool isError) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
            color: isError ? errorBorderColor : borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
            color: isError ? errorBorderColor : borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
            color: isError ? errorBorderColor : borderColor, width: 2.0),
      ),
      // These are for the FormField's own error state, which we are overriding
      // for text display, but the state itself (hasError) is still useful for border.
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorBorderColor, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorBorderColor, width: 2.0),
      ),
       // Ensure no default error text or space is shown by InputDecoration
      errorStyle: const TextStyle(height: 0, fontSize: 0),
      errorText: null, // Explicitly null
    );
  }
}
