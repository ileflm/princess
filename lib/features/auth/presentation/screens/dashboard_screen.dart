import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_routes.dart';
import 'package:princess_app/core/constants/app_spacing.dart';
import 'package:princess_app/core/widgets/app_button.dart';
import 'package:princess_app/features/auth/presentation/controllers/auth_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Princess Console',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w200,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.error),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
              context.go(AppRoutes.welcome);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // Welcome Banner
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 54,
                          backgroundColor: AppColors.cardBg,
                          backgroundImage: AssetImage('assets/images/avatar_profile.png'),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome, ${user?.fullName ?? "Princess Dev"}!',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 24,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      AppSpacing.hS,
                      Text(
                        user?.email ?? 'dev@princess.io',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              AppButton(
                text: 'Sign Out',
                isSecondary: true,
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signOut();
                  context.go(AppRoutes.welcome);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
