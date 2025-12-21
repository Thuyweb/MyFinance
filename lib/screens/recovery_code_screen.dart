import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recovery_provider.dart';
import '../utils/theme.dart';

class RecoveryCodeScreen extends StatelessWidget {
  const RecoveryCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecoveryProvider()..generateAndSave(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('recovery_code'),
          automaticallyImplyLeading: false,
        ),
        body: Consumer<RecoveryProvider>(
          builder: (context, provider, _) {
            if (!provider.isGenerated) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.key,
                    size: 64,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'save_recovery_code_title',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'save_recovery_code_desc',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // 🔐 RECOVERY CODE
                  SelectableText(
                    provider.recoveryCode!,
                    style: const TextStyle(
                      fontSize: 22,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: () async {
                      await provider.markRecoveryShown();

                      if (context.mounted) {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }
                    },
                    child: const Text('i_have_saved_code'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
