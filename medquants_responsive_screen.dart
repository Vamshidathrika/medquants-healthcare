import 'dart:ui';
import 'package:flutter/material.dart';

/// MedQuants Brand Color Palette (Amethyst Purple Primary)
class MedQuantsTheme {
  static const Color primary = Color(0xFF8E2DA8); // Amethyst Purple (Primary)
  static const Color primaryDark = Color(0xFF5E1473); // Royal Deep Purple
  static const Color primaryLight = Color(0xFFA235BF); // Vibrant Purple Accent
  static const Color secondary = Color(0xFF6D1E82); // Deep Royal Violet
  static const Color tertiary = Color(0xFFFFCA74); // Brand Amber / VIP Gold
  static const Color lightPurple = Color(0xFFFBEEFF); // Soft Lavender Tint
  static const Color offWhite = Color(0xFFF8FAFC);
  static const Color offBlack = Color(0xFF2A2530);
  static const Color brandRed = Color(0xFFDC2626);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color success = Color(0xFF10B981);

  // Atmospheric Purple Tint Linear Gradient Background (Ultra-Subtle Whisper Tint)
  static const LinearGradient purpleCanvasGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFFDFBFF),
      Color(0xFFF9F4FC),
      Color(0xFFF4EBF8),
    ],
  );

  // Royal Amethyst Multi-Stop Card Gradient
  static const LinearGradient royalAmethystGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFA438C5),
      Color(0xFF8E2DA8),
      Color(0xFF59126D),
    ],
  );

  // Deep Orchid Accent Gradient
  static const LinearGradient clinicalTealGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF9C27B0),
      Color(0xFF8E2DA8),
      Color(0xFF5E1473),
    ],
  );

  // Breakpoints following `flutter-build-responsive-layout`
  static const double compactBreakpoint = 600.0;
  static const double mediumBreakpoint = 900.0;
  static const double maxContentWidth = 1140.0;
}

/// Adaptive MedQuants Dashboard implementing `flutter-build-responsive-layout`
class MedQuantsResponsiveScreen extends StatefulWidget {
  const MedQuantsResponsiveScreen({super.key});

  @override
  State<MedQuantsResponsiveScreen> createState() =>
      _MedQuantsResponsiveScreenState();
}

class _MedQuantsResponsiveScreenState extends State<MedQuantsResponsiveScreen> {
  int _selectedNavigationIndex = 0;
  final Map<String, int> _cartItems = {'Thyroid Profile': 1};
  final Map<String, double> _itemPrices = {
    'Thyroid Profile': 550.0,
    'CBC Test Profile': 199.0,
    'Vitamin D (25-OH)': 699.0,
    'Full Body Wellness 72': 899.0,
    'Dolo 650mg': 25.0,
    'Benadryl Syrup': 98.0,
  };

  void _addItem(String name, double price) {
    setState(() {
      _cartItems[name] = (_cartItems[name] ?? 0) + 1;
      _itemPrices[name] = price;
    });
  }

  void _removeItem(String name) {
    setState(() {
      if (_cartItems.containsKey(name)) {
        if (_cartItems[name]! > 1) {
          _cartItems[name] = _cartItems[name]! - 1;
        } else {
          _cartItems.remove(name);
        }
      }
    });
  }

  int get _totalCartCount => _cartItems.values.fold(0, (sum, q) => sum + q);
  double get _totalCartAmount {
    double total = 0;
    _cartItems.forEach((name, qty) {
      total += qty * (_itemPrices[name] ?? 0.0);
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // Determine layout strictly based on parent constraints per skill guidelines
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen =
            constraints.maxWidth > MedQuantsTheme.compactBreakpoint;
        final bool isDesktop =
            constraints.maxWidth > MedQuantsTheme.mediumBreakpoint;

        return Scaffold(
          backgroundColor: MedQuantsTheme.offWhite,
          body: isLargeScreen
              ? _buildLargeScreenScaffold(isDesktop)
              : _buildMobileScaffold(),
          bottomNavigationBar: isLargeScreen ? null : _buildMobileBottomBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              (!isLargeScreen && _totalCartCount > 0)
                  ? _buildFloatingCartPill()
                  : null,
        );
      },
    );
  }

  // ===========================================================================
  // MOBILE ADAPTIVE SCAFFOLD (< 600px)
  // ===========================================================================
  Widget _buildMobileScaffold() {
    return Container(
      decoration: const BoxDecoration(
        gradient: MedQuantsTheme.purpleCanvasGradient,
      ),
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
            slivers: [
              _buildSliverLocationHeader(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroBanner(),
                      const SizedBox(height: 16),
                      _buildHealthCategories(),
                      const SizedBox(height: 20),
                      _buildPopularTestsSection(),
                      const SizedBox(height: 20),
                      _buildCuratedPackagesSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

  // ===========================================================================
  // LARGE SCREEN / TABLET ADAPTIVE SCAFFOLD (>= 600px)
  // Prevents horizontal stretching using ConstrainedBox & Side Navigation
  // ===========================================================================
  Widget _buildLargeScreenScaffold(bool isDesktop) {
    return Row(
      children: [
        // Navigation Rail for Wide Screens
        NavigationRail(
          selectedIndex: _selectedNavigationIndex,
          onDestinationSelected: (index) {
            setState(() => _selectedNavigationIndex = index);
          },
          backgroundColor: Colors.white,
          selectedIconTheme:
              const IconThemeData(color: MedQuantsTheme.primary),
          unselectedIconTheme:
              const IconThemeData(color: MedQuantsTheme.textSecondary),
          selectedLabelTextStyle: const TextStyle(
            color: MedQuantsTheme.primary,
            fontWeight: FontWeight.bold,
          ),
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CircleAvatar(
              backgroundColor: MedQuantsTheme.primary,
              radius: 20,
              child: const Icon(Icons.medical_services_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.biotech_outlined),
              selectedIcon: Icon(Icons.biotech_rounded),
              label: Text('Lab Tests'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.medication_outlined),
              selectedIcon: Icon(Icons.medication_rounded),
              label: Text('Pharmacy'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.calendar_today_outlined),
              selectedIcon: Icon(Icons.calendar_today_rounded),
              label: Text('Bookings'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.account_circle_outlined),
              selectedIcon: Icon(Icons.account_circle_rounded),
              label: Text('Account'),
            ),
          ],
        ),

        const VerticalDivider(width: 1, color: Color(0xFFE2E8F0)),

        // Centered Constrained Content Area
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: MedQuantsTheme.maxContentWidth,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Content Stream
                  Expanded(
                    flex: 7,
                    child: CustomScrollView(
                      slivers: [
                        _buildSliverLocationHeader(),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeroBanner(),
                                const SizedBox(height: 20),
                                _buildHealthCategories(),
                                const SizedBox(height: 24),
                                _buildPopularTestsGrid(),
                                const SizedBox(height: 24),
                                _buildCuratedPackagesSection(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Dedicated Side Cart Panel for Tablets/Desktops
                  if (isDesktop) ...[
                    const VerticalDivider(width: 1, color: Color(0xFFE2E8F0)),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(20),
                        child: _buildSideCartSummary(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // HERO BANNER WITH 3D PIXAR MEDICINE BOTTLE & TABLETS
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            MedQuantsTheme.primaryDark,
            MedQuantsTheme.primary,
            MedQuantsTheme.primaryLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: MedQuantsTheme.primary.withOpacity(0.24),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ambient Glows
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.12),
              ),
            ),
          ),

          // 3D Disney Pixar Pill Bottle & Floating Tablets
          Positioned(
            right: 0,
            top: 10,
            bottom: 10,
            width: 150,
            child: Image.asset(
              'assets/images/pixar_pill_bottle_3d.png',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => _buildVector3DFallback(),
            ),
          ),

          // Banner Left Text Content
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Trust Tag
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_user_rounded,
                          color: Colors.white, size: 12),
                      SizedBox(width: 4),
                      Text(
                        'NABL Accredited Labs',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),

                // Main Offer Text
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Body Wellness',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    Text(
                      '72 Essential Parameters',
                      style: TextStyle(
                        color: MedQuantsTheme.lightTeal,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Free Phlebotomist Home Sample Collection',
                      style: TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                  ],
                ),

                // Pricing Row
                Row(
                  children: [
                    const Text('₹899',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(width: 6),
                    const Text('₹2,200',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                          decoration: TextDecoration.lineThrough,
                        )),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: MedQuantsTheme.tertiary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('60% OFF',
                          style: TextStyle(
                              color: MedQuantsTheme.offBlack,
                              fontSize: 9,
                              fontWeight: FontWeight.w800)),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () =>
                          _addItem('Full Body Wellness 72', 899.0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: MedQuantsTheme.primary,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        minimumSize: Size.zero,
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Book',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w800)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded, size: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // REUSABLE POPULAR TESTS & STEPPERS
  // ===========================================================================
  Widget _buildPopularTestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Popular Lab Tests',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: MedQuantsTheme.offBlack,
                  ),
                ),
                Text(
                  'Fast 6-12 hour report turnaround',
                  style: TextStyle(
                      fontSize: 11, color: MedQuantsTheme.textSecondary),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Explore',
                style: TextStyle(
                    color: MedQuantsTheme.primary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 185,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              _buildTestCard(
                name: 'CBC Test Profile',
                parameters: '35 Parameters • Blood',
                badge: '6 HR REPORT',
                badgeColor: MedQuantsTheme.lightTeal,
                badgeTextColor: const Color(0xFF0E7482),
                icon: Icons.science_outlined,
                price: 199.0,
                mrp: 500.0,
              ),
              const SizedBox(width: 12),
              _buildTestCard(
                name: 'Thyroid Profile',
                parameters: 'T3, T4, TSH Ultra',
                badge: 'FASTING',
                badgeColor: MedQuantsTheme.lightPurple,
                badgeTextColor: MedQuantsTheme.secondary,
                icon: Icons.biotech_outlined,
                price: 550.0,
                mrp: 850.0,
              ),
              const SizedBox(width: 12),
              _buildTestCard(
                name: 'Vitamin D (25-OH)',
                parameters: 'Bone & Immunity',
                badge: '12 HR',
                badgeColor: const Color(0xFFFEF3C7),
                badgeTextColor: const Color(0xFF92400E),
                icon: Icons.wb_sunny_outlined,
                price: 699.0,
                mrp: 1200.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Tablet Grid Representation for Tests
  Widget _buildPopularTestsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Lab Tests',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: MedQuantsTheme.offBlack,
          ),
        ),
        const SizedBox(height: 12),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 260,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          children: [
            _buildTestCard(
              name: 'CBC Test Profile',
              parameters: '35 Parameters • Blood',
              badge: '6 HR REPORT',
              badgeColor: MedQuantsTheme.lightTeal,
              badgeTextColor: const Color(0xFF0E7482),
              icon: Icons.science_outlined,
              price: 199.0,
              mrp: 500.0,
            ),
            _buildTestCard(
              name: 'Thyroid Profile',
              parameters: 'T3, T4, TSH Ultra',
              badge: 'FASTING',
              badgeColor: MedQuantsTheme.lightPurple,
              badgeTextColor: MedQuantsTheme.secondary,
              icon: Icons.biotech_outlined,
              price: 550.0,
              mrp: 850.0,
            ),
            _buildTestCard(
              name: 'Vitamin D (25-OH)',
              parameters: 'Bone & Immunity',
              badge: '12 HR',
              badgeColor: const Color(0xFFFEF3C7),
              badgeTextColor: const Color(0xFF92400E),
              icon: Icons.wb_sunny_outlined,
              price: 699.0,
              mrp: 1200.0,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTestCard({
    required String name,
    required String parameters,
    required String badge,
    required Color badgeColor,
    required Color badgeTextColor,
    required IconData icon,
    required double price,
    required double mrp,
  }) {
    final int qty = _cartItems[name] ?? 0;

    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(
                        color: badgeTextColor,
                        fontSize: 8.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.star, size: 11, color: Color(0xFFF59E0B)),
                      SizedBox(width: 2),
                      Text('4.9',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: MedQuantsTheme.lightTeal,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: MedQuantsTheme.primary, size: 18),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: MedQuantsTheme.offBlack,
                ),
              ),
              Text(
                parameters,
                style: const TextStyle(
                  fontSize: 10,
                  color: MedQuantsTheme.textSecondary,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.top(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('₹${mrp.toInt()}',
                        style: const TextStyle(
                          fontSize: 9,
                          color: MedQuantsTheme.textSecondary,
                          decoration: TextDecoration.lineThrough,
                        )),
                    Text('₹${price.toInt()}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: MedQuantsTheme.offBlack,
                        )),
                  ],
                ),
                _buildTactileStepper(
                  qty: qty,
                  onAdd: () => _addItem(name, price),
                  onRemove: () => _removeItem(name),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Apple Spring Tactile Stepper
  Widget _buildTactileStepper({
    required int qty,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    if (qty == 0) {
      return InkWell(
        onTap: onAdd,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: MedQuantsTheme.lightTeal,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Text(
            'ADD',
            style: TextStyle(
              color: MedQuantsTheme.primary,
              fontWeight: FontWeight.w800,
              fontSize: 11,
            ),
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: MedQuantsTheme.primary,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: MedQuantsTheme.primary.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.remove, size: 12, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '$qty',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            child: const Icon(Icons.add, size: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // DYNAMIC ISLAND FLOATING CART PILL
  // ===========================================================================
  Widget _buildFloatingCartPill() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: MedQuantsTheme.offBlack.withOpacity(0.92),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: MedQuantsTheme.primary.withOpacity(0.28),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: MedQuantsTheme.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$_totalCartCount',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 11),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '₹${_totalCartAmount.toInt()} Total',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12),
              ),
              const Text(
                'Sample Pickup in 15 mins',
                style: TextStyle(
                    color: MedQuantsTheme.textSecondary, fontSize: 9),
              ),
            ],
          ),
          const SizedBox(width: 18),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: MedQuantsTheme.primary,
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              minimumSize: Size.zero,
            ),
            child: const Text('Checkout →',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  // Tablet Side Cart Summary Panel
  Widget _buildSideCartSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your Order Cart',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: MedQuantsTheme.offBlack)),
        const SizedBox(height: 12),
        Expanded(
          child: _cartItems.isEmpty
              ? const Center(
                  child: Text('Your cart is empty',
                      style: TextStyle(color: MedQuantsTheme.textSecondary)))
              : ListView(
                  children: _cartItems.entries.map((entry) {
                    final price = _itemPrices[entry.key] ?? 0.0;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(entry.key,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: Text('₹${price.toInt()} each'),
                      trailing: _buildTactileStepper(
                        qty: entry.value,
                        onAdd: () => _addItem(entry.key, price),
                        onRemove: () => _removeItem(entry.key),
                      ),
                    );
                  }).toList(),
                ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Grand Total:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('₹${_totalCartAmount.toInt()}',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: MedQuantsTheme.primary)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _totalCartCount == 0 ? null : () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: MedQuantsTheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            child: const Text('Proceed to Checkout',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  // Supporting Sub-Components
  Widget _buildSliverLocationHeader() {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0.92),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: MedQuantsTheme.lightTeal,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.location_on_rounded,
                color: MedQuantsTheme.primary, size: 16),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Deliver To Home',
                  style: TextStyle(
                      fontSize: 10,
                      color: MedQuantsTheme.textSecondary,
                      fontWeight: FontWeight.w700)),
              Text('Green Glen Towers, 402',
                  style: TextStyle(
                      fontSize: 13,
                      color: MedQuantsTheme.offBlack,
                      fontWeight: FontWeight.w800)),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            backgroundColor: MedQuantsTheme.lightTeal,
            child: const Text('NS',
                style: TextStyle(
                    color: MedQuantsTheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthCategories() {
    final categories = [
      {'name': 'Blood', 'icon': Icons.water_drop_outlined, 'color': MedQuantsTheme.lightTeal, 'text': MedQuantsTheme.primary},
      {'name': 'Heart', 'icon': Icons.favorite_border_rounded, 'color': MedQuantsTheme.lightPurple, 'text': MedQuantsTheme.secondary},
      {'name': 'Thyroid', 'icon': Icons.biotech_outlined, 'color': MedQuantsTheme.lightTeal, 'text': MedQuantsTheme.primary},
      {'name': 'Diabetes', 'icon': Icons.timeline_rounded, 'color': const Color(0xFFFEF3C7), 'text': const Color(0xFF92400E)},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((cat) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black.withOpacity(0.04)),
            ),
            child: Column(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: cat['color'] as Color,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(cat['icon'] as IconData,
                      color: cat['text'] as Color, size: 20),
                ),
                const SizedBox(height: 6),
                Text(
                  cat['name'] as String,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: MedQuantsTheme.offBlack),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCuratedPackagesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: MedQuantsTheme.lightPurple,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.health_and_safety_outlined,
                color: MedQuantsTheme.secondary, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Diabetic Care Advanced',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: MedQuantsTheme.offBlack)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: MedQuantsTheme.lightPurple,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('55% OFF',
                          style: TextStyle(
                              color: MedQuantsTheme.secondary,
                              fontSize: 9,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'HbA1c, Fasting Sugar, Lipid Panel & Kidney clearance.',
                  style: TextStyle(
                      fontSize: 11, color: MedQuantsTheme.textSecondary),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('₹899',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: MedQuantsTheme.offBlack)),
                    ElevatedButton(
                      onPressed: () =>
                          _addItem('Diabetic Care Advanced', 899.0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MedQuantsTheme.secondary,
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        minimumSize: Size.zero,
                        elevation: 0,
                      ),
                      child: const Text('Select Package',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVector3DFallback() {
    return const Icon(Icons.medication_rounded,
        size: 70, color: Colors.white70);
  }

  Widget _buildMobileBottomBar() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        border: Border(
            top: BorderSide(color: Colors.black.withOpacity(0.04))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _BottomNavItem(
              icon: Icons.biotech_rounded,
              label: 'Diagnostics',
              isSelected: true),
          _BottomNavItem(
              icon: Icons.medication_outlined,
              label: 'Pharmacy',
              isSelected: false),
          _BottomNavItem(
              icon: Icons.calendar_today_outlined,
              label: 'Booking',
              isSelected: false),
          _BottomNavItem(
              icon: Icons.person_outline_rounded,
              label: 'Account',
              isSelected: false),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,
            size: 22,
            color: isSelected
                ? MedQuantsTheme.primary
                : MedQuantsTheme.textSecondary),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: isSelected
                ? MedQuantsTheme.primary
                : MedQuantsTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
