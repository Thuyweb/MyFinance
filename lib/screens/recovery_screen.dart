import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/restore_provider.dart';
import '../utils/theme.dart';
import '../l10n/localization_extension.dart';
import 'dashboard_screen.dart';
import 'onboarding_screen.dart';

class RecoveryScreen extends StatefulWidget {
  const RecoveryScreen({super.key});

  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _restore(BuildContext context) async {
    final provider = context.read<RestoreProvider>();

    final success = await provider.restore(
      _codeController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      // 👉 Sau restore thành công → về Dashboard
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
        (route) => false,
      );
    } else if (provider.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error!),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _skipRecovery() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RestoreProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('restore_data')),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr('restore_data'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              context.tr('restore_screen_desc'),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: context.tr('recovery_code'),
                hintText: context.tr('enter_recovery_code'),
                border: const OutlineInputBorder(),
              ),
              enabled: !provider.isLoading,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: provider.isLoading ? null : () => _restore(context),
                child: provider.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(context.tr('restore_now')),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: provider.isLoading ? null : _skipRecovery,
                child: Text(context.tr('skip_and_start_new')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
