part of '../login.dart';

class LoginIconAndTexts extends StatelessWidget {
  const LoginIconAndTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 60,
        right: 60,
        top: 20,
        bottom: 30,
      ),
      child: Column(
        children: [
          Lottie.asset(AppAssets.expensio),
          const Text(
            'Expensio',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Track all your Expenses',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
