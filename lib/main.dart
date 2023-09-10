import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/providers/chat_provider.dart';
import 'package:proyecto/providers/event_provider.dart';
import 'package:proyecto/providers/login_provider.dart';
import 'package:proyecto/providers/password_reset_provider.dart';
import 'package:proyecto/providers/person_provider.dart';
import 'package:proyecto/providers/signup_provider.dart';
import 'package:proyecto/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/screens/contacts_screen.dart';
import 'package:proyecto/screens/password_reset_screen.dart';
import 'package:proyecto/screens/signup_screen.dart';
import 'package:proyecto/screens/sugerencia_screen.dart';
import 'package:proyecto/widgets/event_list.dart';
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
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => PersonProvider()),
        ChangeNotifierProvider(create: (context) => PasswordResetProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider())
      ],
      child: MaterialApp(
        title: 'PoliMatch',
        //home: new MainWidget(),
        initialRoute: LoginScreen.routeName,
        routes: {
          MainWidget.routeName: (context) => const MainWidget(),
          LoginScreen.routeName: (context) => LoginScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          PasswordResetScreen.routeName: (context) => PasswordResetScreen(),
          ContactsScreen.routeName: (context) => const ContactsScreen()
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF91659)),
          primaryColor: const Color(0xFFF91659),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFFFFFFF),
              backgroundColor:
                  const Color(0xFFF91659), // Color del texto del botón (blanco)
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors
                  .blue, // Color del texto para los botones de texto (azul)
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
      ),
    );
  }
}

class MainWidget extends StatefulWidget {
  static const routeName = '/';

  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _selectedIndex = 0;

  final List<Widget> _mainWidgets = [
    SugerenciasWidget(),
    ContactsScreen(),
    EventList(),
  ];

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/images/logoLogin.png', // Ruta de la imagen del logotipo
            ),
            label: 'Sugerencias',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.messenger,
              color: Colors.white,
            ),
            label: 'Pokemons',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
            label: 'Favoritos',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
            ),
            label: 'Favoritos',
          )
        ],
        backgroundColor: const Color(0xFFF91659),
        currentIndex: _selectedIndex,
        onTap: _onTapItem,
      ),
    );
  }
}
