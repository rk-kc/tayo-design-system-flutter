import 'package:flutter/material.dart';
import 'package:tayo_design_system/tayo_design_system.dart';

import 'showcase/overlays_page.dart';
import 'showcase/patterns_page.dart';
import 'showcase/primitives_page.dart';
import 'showcase/tokens_page.dart';

void main() {
  runApp(const TayoShowcaseApp());
}

class TayoShowcaseApp extends StatelessWidget {
  const TayoShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tayo Design System',
      theme: TayoTheme.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const _ShowcaseShell(),
    );
  }
}

class _ShowcaseShell extends StatefulWidget {
  const _ShowcaseShell();

  @override
  State<_ShowcaseShell> createState() => _ShowcaseShellState();
}

class _ShowcaseShellState extends State<_ShowcaseShell> {
  int _index = 0;

  static const List<_ShowcaseSection> _sections = <_ShowcaseSection>[
    _ShowcaseSection(title: '01 · Tokens', builder: TokensPage.new),
    _ShowcaseSection(title: '02 · Primitives', builder: PrimitivesPage.new),
    _ShowcaseSection(title: '03 · Overlays', builder: OverlaysPage.new),
    _ShowcaseSection(title: '04 · Patterns', builder: PatternsPage.new),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TayoColors.ink,
      body: Stack(
        children: <Widget>[
          const AmbientOrbs(),
          SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        for (int i = 0; i < _sections.length; i++) ...<Widget>[
                          if (i > 0) const SizedBox(width: 8),
                          TayoButton(
                            label: _sections[i].title,
                            variant: i == _index
                                ? TayoButtonVariant.primary
                                : TayoButtonVariant.secondary,
                            size: TayoButtonSize.sm,
                            onPressed: () => setState(() => _index = i),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Expanded(child: _sections[_index].builder()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowcaseSection {
  const _ShowcaseSection({required this.title, required this.builder});

  final String title;
  final Widget Function() builder;
}
