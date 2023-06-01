import 'package:flutter/material.dart';

class CatagoryList extends StatefulWidget {
  const CatagoryList({super.key});

  @override
  State<CatagoryList> createState() => _CatagoryListState();
}

class _CatagoryListState extends State<CatagoryList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.14,
              child: ElevatedButton(
                child: const Text('Önerilen Duvar Kağıtları'),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.14,
              child: ElevatedButton(
                child: const Text('Stok Duvar Kağıtları'),
                onPressed: () {
                  Navigator.pushNamed(context, '/stockwallpapers');
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.14,
              child: ElevatedButton(
                child: const Text('Amoled Duvar Kağıtları'),
                onPressed: () {
                  Navigator.pushNamed(context, '/stockwallpapers');
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.14,
              child: ElevatedButton(
                child: const Text('Minimal Duvar Kağıtları'),
                onPressed: () {
                  Navigator.pushNamed(context, '/stockwallpapers');
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.14,
              child: ElevatedButton(
                child: const Text('Gradyan Duvar Kağıtları'),
                onPressed: () {
                  Navigator.pushNamed(context, '/stockwallpapers');
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.14,
              child: ElevatedButton(
                child: const Text('Sinema Duvar Kağıtları'),
                onPressed: () {
                  Navigator.pushNamed(context, '/stockwallpapers');
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.14,
              child: ElevatedButton(
                child: const Text('Abstract Duvar Kağıtları'),
                onPressed: () {
                  Navigator.pushNamed(context, '/stockwallpapers');
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.14,
              child: ElevatedButton(
                child: const Text('Anime Duvar Kağıtları'),
                onPressed: () {
                  Navigator.pushNamed(context, '/stockwallpapers');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
