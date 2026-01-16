import 'package:flutter/material.dart';

import '../widgets/app_top_bar.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(showUserAction: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Terms and Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Suspendisse malesuada, leo eu sagittis laoreet, ipsum nulla '
              'tincidunt nunc, eget gravida nisl dolor a justo. Integer '
              'porttitor, turpis ut porta finibus, urna lorem finibus nisi, '
              'ut dignissim tortor nisl non urna. Donec ultricies nulla vitae '
              'purus auctor, quis congue orci bibendum. Mauris ut dui ut '
              'ligula sagittis dictum. Donec vitae risus sed velit rhoncus '
              'viverra. Sed euismod, mauris nec volutpat maximus, augue '
              'tellus accumsan nulla, sed blandit arcu est vel neque.',
            ),
          ],
        ),
      ),
    );
  }
}
