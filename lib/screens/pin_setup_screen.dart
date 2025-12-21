import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_settings_provider.dart';
import '../services/auth_service.dart';
import '../utils/theme.dart';
import '../l10n/localization_extension.dart';

class PinSetupScreen extends StatefulWidget {
  final bool isEdit;

  const PinSetupScreen({super.key, this.isEdit = false});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  String _currentPin = '';
  String _confirmPin = '';
  bool _isConfirming = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? context.tr('change_pin') : context.tr('setup_pin'),
        ),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(height: 32),
            _buildTitle(),
            const SizedBox(height: 16),
            _buildSubtitle(),
            const SizedBox(height: 48),
            _buildPinDisplay(),
            const SizedBox(height: 48),
            _buildNumberPad(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.lock_outline,
        size: 64,
        color: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      _isConfirming
          ? context.tr('confirm_your_pin')
          : widget.isEdit
              ? context.tr('enter_new_pin')
              : context.tr('create_security_pin'),
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      _isConfirming
          ? context.tr('enter_pin_again_to_confirm')
          : context.tr('pin_6_digits_for_app_security'),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPinDisplay() {
    final length = _isConfirming ? _confirmPin.length : _currentPin.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < length
                ? AppTheme.primaryColor
                : AppTheme.primaryColor.withOpacity(0.3),
          ),
        );
      }),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 16),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 16),
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 72),
            _buildNumberButton('0'),
            _buildDeleteButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map(_buildNumberButton).toList(),
    );
  }

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: _isLoading ? null : () => _onNumberPressed(number),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.primaryColor.withOpacity(0.1),
          border: Border.all(
            color: AppTheme.primaryColor.withOpacity(0.3),
          ),
        ),
        child: Center(
          child: Text(
            number,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primaryColor,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _onDeletePressed,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(0.1),
          border: Border.all(color: Colors.red.withOpacity(0.3)),
        ),
        child: const Icon(Icons.backspace_outlined, color: Colors.red),
      ),
    );
  }

  void _onNumberPressed(String number) {
    if (_isConfirming) {
      if (_confirmPin.length < 6) {
        setState(() => _confirmPin += number);
        if (_confirmPin.length == 6) _checkPinMatch();
      }
    } else {
      if (_currentPin.length < 6) {
        setState(() => _currentPin += number);
        if (_currentPin.length == 6) {
          Future.delayed(const Duration(milliseconds: 200), () {
            if (mounted) setState(() => _isConfirming = true);
          });
        }
      }
    }
  }

  void _onDeletePressed() {
    setState(() {
      if (_isConfirming) {
        if (_confirmPin.isNotEmpty) {
          _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
        } else {
          _isConfirming = false;
        }
      }
    });
  }

  void _checkPinMatch() {
    if (_currentPin == _confirmPin) {
      _savePin();
    } else {
      _showError(context.tr('pin_not_match_try_again'));
      setState(() => _confirmPin = '');
    }
  }

  Future<void> _savePin() async {
    setState(() => _isLoading = true);

    try {
      final userSettings = context.read<UserSettingsProvider>();
      final hashedPin = AuthService.instance.getHashedPin(_currentPin);

      final success = await userSettings.updatePinSettings(
        pinCode: hashedPin,
        pinEnabled: true,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.isEdit
                  ? context.tr('pin_changed_successfully')
                  : context.tr('pin_created_successfully'),
            ),
            backgroundColor: AppColors.success,
          ),
        );

        Navigator.pop(context, true);
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }
}
