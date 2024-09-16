import 'package:flutter/material.dart';

import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<CarouselItem> carouselItems = [
    CarouselItem(
      imagePath: 'assets/transaction.png',
      title: 'Welcome to ',
      title_2: 'Finanger',
      description: 'Manage your personal finances effortlessly.',
    ),
    CarouselItem(
      imagePath: 'assets/budget.png',
      title: 'Track ',
      title_2: 'Your Expenses',
      description:
          'Easily track where your money goes and budget your expenses.',
    ),
    // CarouselItem(
    //   imagePath: 'assets/save-money.png',
    //   title: 'Set ',
    //   title_2: 'Saving Goals',
    //   description: 'Achieve your goals with detailed insights.',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: carouselItems.length,
              itemBuilder: (context, index) {
                return CarouselPage(
                  item: carouselItems[index],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(carouselItems.length, (index) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                width: 6.0,
                height: 6.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: _currentPage == carouselItems.length - 1
                  ? () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    }
                  : () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
              child: Text(
                _currentPage == carouselItems.length - 1
                    ? 'Get Started'
                    : 'Next',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselPage extends StatelessWidget {
  final CarouselItem item;

  const CarouselPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          item.imagePath,
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 50),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: item.title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
              ),
              TextSpan(
                text: item.title_2,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            item.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black54,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class CarouselItem {
  final String imagePath;
  final String title;
  final String? title_2;
  final String description;

  CarouselItem({
    required this.imagePath,
    required this.title,
    required this.title_2,
    required this.description,
  });
}
