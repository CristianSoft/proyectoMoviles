import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/providers/login_provider.dart';
import 'package:proyecto/providers/person_provider.dart';
import 'package:proyecto/providers/signup_provider.dart';
import 'package:proyecto/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/screens/signup_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => PersonProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider(),)
      ],
      child: MaterialApp(
        title: 'Pokedex',
           //home: new MainWidget(),
           initialRoute: LoginScreen.routeName,
           routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
           },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF91659)),
          primaryColor: const Color(0xFFF91659),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFFFFFFF),
              backgroundColor: const
                  Color(0xFFF91659), // Color del texto del botón (blanco)
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor:
                  Colors.blue, // Color del texto para los botones de texto (azul)
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(color: Color(0xFFF91659)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  100.0), // Bordes completamente redondeados
              borderSide: const BorderSide(color: Color(0xFFF91659)),
              gapPadding: 8.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  100.0), // Bordes completamente redondeados
              borderSide: const BorderSide(color: Color(0xFFF91659)),
              gapPadding: 8.0,
            ),
          ),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
