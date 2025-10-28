import 'package:flutter/material.dart';

class FontPreviewPage extends StatelessWidget {
  const FontPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    Widget sample(String label, TextStyle? style) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 6),
        Text(label.replaceAll(' — ', ' '), style: style),
        const SizedBox(height: 18),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Font preview')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              'Typography preview',
              style: t.headlineSmall?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            sample(
              'Hero Title — 36',
              t.displayLarge?.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            sample(
              'Page Title — 24',
              t.headlineSmall?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            sample(
              'Section Header — 20',
              t.titleLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            sample('Large Body — 18', t.bodyLarge?.copyWith(fontSize: 18)),
            sample('Standard Body — 16', t.bodyMedium?.copyWith(fontSize: 16)),
            sample('Small Body — 14', t.bodySmall?.copyWith(fontSize: 14)),
            sample('Caption — 12', t.labelSmall?.copyWith(fontSize: 12)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: Text('Primary button', style: t.labelLarge),
            ),
          ],
        ),
      ),
    );
  }
}
