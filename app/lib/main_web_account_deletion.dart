import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forui/forui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'inside/blocs/account_deletion/bloc.dart';
import 'inside/blocs/account_deletion/event.dart';
import 'inside/blocs/account_deletion/state.dart';
import 'inside/i18n/translations.g.dart';
import 'outside/repositories/account_deletion/account_deletion_repository.dart';
import 'outside/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleSettings.useDeviceLocale();
  await Supabase.initialize(
    url: kDebugMode
        ? 'http://192.168.40.13:54321'
        : 'https://fpfpxsfqphascipoibbj.supabase.co',
    anonKey: kDebugMode
        ? 'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH'
        : 'sb_publishable_4a0xrMFx7ZnwQ2HYOi6MkQ_XhsCwK98',
    debug: false,
  );
  runApp(const AccountDeletionWebApp());
}

class AccountDeletionWebApp extends StatelessWidget {
  const AccountDeletionWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Heroes - Account Deletion',
      theme: OutsideThemes.lightTheme.materialThemeData,
      darkTheme: OutsideThemes.darkTheme.materialThemeData,
      themeMode: ThemeMode.light,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: TranslationProvider(
        child: BlocProvider(
          create: (_) => AccountDeletion_Bloc(
            repository: AccountDeletion_Repository.fromClient(
              supabaseClient: Supabase.instance.client,
            ),
          ),
          child: const AccountDeletionWebPage(),
        ),
      ),
    );
  }
}

class AccountDeletionWebPage extends StatelessWidget {
  const AccountDeletionWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;

    return Scaffold(
      backgroundColor: context.solidColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.solidColors.background,
              context.solidColors.surfaceVariant.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icon/duo_icon.png',
                      // width: isTablet ? 350 : 100,
                      // height: isTablet ? 350 : 100,
                    ),
                    Text(
                      'Habit Heroes',
                      style: context.typography.hero?.copyWith(
                        fontSize: isTablet ? 48 : 40,
                        fontWeight: FontWeight.w800,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [
                              context.colors.parentsPrimary.start,
                              context.colors.parentsPrimary.end,
                            ],
                          ).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      t.settings.accountDeletion.title,
                      style: context.typography.pageTitle?.copyWith(
                        fontSize: isTablet ? 28 : 24,
                        color: context.solidColors.onBackground,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    const AccountDeletionForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AccountDeletionForm extends StatefulWidget {
  const AccountDeletionForm({super.key});

  @override
  State<AccountDeletionForm> createState() => _AccountDeletionFormState();
}

class _AccountDeletionFormState extends State<AccountDeletionForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return BlocBuilder<AccountDeletion_Bloc, AccountDeletion_State>(
      builder: (context, state) {
        if (state.status == AccountDeletion_Status.success) {
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: context.solidColors.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: context.solidColors.border.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.colors.kidsManagementGreen.start,
                        context.colors.kidsManagementGreen.end,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 48,
                    color: context.solidColors.onPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  t.settings.accountDeletion.dialog.success.title,
                  style: context.typography.sectionHeader?.copyWith(
                    color: context.solidColors.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  t.settings.accountDeletion.dialog.success.message,
                  style: context.typography.body?.copyWith(
                    color: context.solidColors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: context.solidColors.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: context.solidColors.border.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                t.settings.accountDeletion.dialog.message,
                style: context.typography.body?.copyWith(
                  color: context.solidColors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FTextFormField(
                controller: _emailController,
                label: Text(t.settings.accountDeletion.dialog.form.email.label),
                hint: t.settings.accountDeletion.dialog.form.email.hint,
                keyboardType: TextInputType.emailAddress,
                enabled: state.status != AccountDeletion_Status.loading,
              ),
              const SizedBox(height: 16),
              FTextFormField(
                controller: _reasonController,
                label: Text(
                  t.settings.accountDeletion.dialog.form.reason.label,
                ),
                hint: t.settings.accountDeletion.dialog.form.reason.hint,
                maxLines: 4,
                enabled: state.status != AccountDeletion_Status.loading,
              ),
              if (state.status == AccountDeletion_Status.failure &&
                  state.errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.solidColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.solidColors.error.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: context.solidColors.error,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          state.errorMessage!,
                          style: context.typography.bodySmall?.copyWith(
                            color: context.solidColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  gradient: state.status == AccountDeletion_Status.loading
                      ? null
                      : LinearGradient(
                          colors: [
                            context.colors.parentsPrimary.start,
                            context.colors.parentsPrimary.end,
                          ],
                        ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: state.status == AccountDeletion_Status.loading
                      ? null
                      : [
                          BoxShadow(
                            color: context.colors.parentsPrimary.start
                                .withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                ),
                child: ElevatedButton(
                  onPressed: state.status == AccountDeletion_Status.loading
                      ? null
                      : () {
                          final email = _emailController.text.trim();
                          final reason = _reasonController.text.trim();
                          if (email.isEmpty) {
                            context.read<AccountDeletion_Bloc>().add(
                              const AccountDeletion_Event_Submit(email: ''),
                            );
                            return;
                          }
                          context.read<AccountDeletion_Bloc>().add(
                            AccountDeletion_Event_Submit(
                              email: email,
                              reason: reason.isEmpty ? null : reason,
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: state.status == AccountDeletion_Status.loading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.solidColors.primary,
                            ),
                          ),
                        )
                      : Text(
                          t.settings.accountDeletion.dialog.submit,
                          style: context.typography.button?.copyWith(
                            color: context.solidColors.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _reasonController.dispose();
    super.dispose();
  }
}
