import 'package:flutter/material.dart';

void main() {
  runApp(const BioLoopApp());
}

class BioLoopApp extends StatelessWidget {
  const BioLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BioLoop Smart Lab',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isMenuVisible = false;
  String _currentSection = 'Home';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigateTo(String section) {
    setState(() {
      _currentSection = section;
    });
    // On narrow screens, close drawer after selection
    if (MediaQuery.of(context).size.width < 800 && _scaffoldKey.currentState?.isDrawerOpen == true) {
      Navigator.of(context).pop();
    }
  }

  void _toggleMenu() {
    if (MediaQuery.of(context).size.width < 800) {
      if (_scaffoldKey.currentState?.isDrawerOpen == true) {
        Navigator.of(context).pop();
      } else {
        _scaffoldKey.currentState?.openDrawer();
      }
    } else {
      setState(() {
        _isMenuVisible = !_isMenuVisible;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Default to visible on wide screens
    if (MediaQuery.of(context).size.width >= 800) {
      _isMenuVisible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isDesktop ? null : Drawer(child: _buildSideMenu()),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDesktop && _isMenuVisible)
                    SizedBox(
                      width: 250,
                      child: _buildSideMenu(),
                    ),
                  Expanded(
                    child: _buildContentArea(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 65,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, size: 28),
            onPressed: _toggleMenu,
          ),
          const SizedBox(width: 8),
          const Icon(Icons.science, size: 32, color: Colors.blue), // Placeholder for Logo
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'BIOLOOP\nSMART LAB',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Text('🔔', style: TextStyle(fontSize: 20)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSideMenu() {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('BIOLOOP\nSMART LAB', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('SMART BIOGAS RESEARCH', style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          _buildMenuButton('🏠  HOME', 'Home'),
          _buildMenuButton('🧪  VIRTUAL LAB', 'VirtualLab'),
          _buildMenuButton('🌿  ALGAE LAB', 'AlgaeLab'),
          _buildMenuButton('⚛️  NANO-IRON LAB', 'NanoLab'),
          _buildMenuButton('💨  GAS LAB', 'GasLab'),
          _buildMenuButton('🔬  SENSOR LAB', 'SensorLab'),
          _buildMenuButton('🌱  DIGESTATE LAB', 'DigestateLab'),
          const Divider(),
          _buildMenuButton('🧪  TREATMENT CALCULATOR', 'Treatment'),
          _buildMenuButton('🧬  EXPERIMENT LIBRARY', 'Experiments'),
          _buildMenuButton('📊  COMPARE', 'Compare'),
          const Divider(),
          _buildMenuButton('💼  INVESTOR MODE', 'Investor'),
          _buildMenuButton('💰  FINANCIAL WHAT-IF', 'Financial'),
          _buildMenuButton('⚠️  RISK DASHBOARD', 'Risk'),
          _buildMenuButton('📈  ANALYTICS / REPORT', 'Analytics'),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String title, String section) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 14)),
      selected: _currentSection == section,
      onTap: () => _navigateTo(section),
    );
  }

  Widget _buildContentArea() {
    switch (_currentSection) {
      case 'Home':
        return _buildHome();
      case 'VirtualLab':
        return const Center(child: Text('🧪 VIRTUAL LAB', style: TextStyle(fontSize: 24)));
      case 'AlgaeLab':
        return const Center(child: Text('🌿 ALGAE LAB', style: TextStyle(fontSize: 24)));
      case 'NanoLab':
        return const Center(child: Text('⚛️ NANO-IRON LAB', style: TextStyle(fontSize: 24)));
      case 'GasLab':
        return const Center(child: Text('💨 GAS LAB', style: TextStyle(fontSize: 24)));
      case 'SensorLab':
        return const Center(child: Text('🔬 SENSOR LAB', style: TextStyle(fontSize: 24)));
      case 'DigestateLab':
        return const Center(child: Text('🌱 DIGESTATE LAB', style: TextStyle(fontSize: 24)));
      case 'Treatment':
        return const Center(child: Text('🧪 TREATMENT CALCULATOR', style: TextStyle(fontSize: 24)));
      case 'Experiments':
        return const Center(child: Text('🧬 EXPERIMENT LIBRARY', style: TextStyle(fontSize: 24)));
      case 'Compare':
        return const Center(child: Text('📊 COMPARE', style: TextStyle(fontSize: 24)));
      case 'Investor':
        return const Center(child: Text('💼 INVESTOR MODE', style: TextStyle(fontSize: 24)));
      case 'Financial':
        return const Center(child: Text('💰 FINANCIAL WHAT-IF', style: TextStyle(fontSize: 24)));
      case 'Risk':
        return const Center(child: Text('⚠️ RISK DASHBOARD', style: TextStyle(fontSize: 24)));
      case 'Analytics':
        return const Center(child: Text('📈 ANALYTICS / REPORT', style: TextStyle(fontSize: 24)));
      default:
        return const Center(child: Text('Section not found'));
    }
  }

  Widget _buildHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('BIOLOOP DASHBOARD', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text('Integrated Biogas & Environmental Smart Laboratory', style: TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('●', style: TextStyle(color: Colors.green, fontSize: 18)),
              const SizedBox(width: 8),
              const Text('SYSTEM STATUS: ACTIVE', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              int columns = constraints.maxWidth > 600 ? 4 : 2;
              return GridView.count(
                crossAxisCount: columns,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildStatCard('💨 BIOGAS', '-- Nm³/day'),
                  _buildStatCard('CH₄', '-- %'),
                  _buildStatCard('CO₂ REMOVAL', '-- %'),
                  _buildStatCard('H₂S', '-- ppm'),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          const Text('LAST EXPERIMENT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const Text('No experiments recorded yet.'),
          ),
          const SizedBox(height: 24),
          const Text('QUICK ACTIONS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => _navigateTo('VirtualLab'),
                child: const Text('▶ START SIMULATION'),
              ),
              ElevatedButton(
                onPressed: () => _navigateTo('SensorLab'),
                child: const Text('🔬 SENSOR DASHBOARD'),
              ),
              ElevatedButton(
                onPressed: () => _navigateTo('Investor'),
                child: const Text('💼 INVESTOR MODE'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
