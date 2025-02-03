
import 'package:flutter/material.dart';
import 'package:interview/color.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(177),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF347c78),
                    image: DecorationImage(
                      image: AssetImage('asset/Frame 28 (1).png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'asset/profile.png',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error, size: 50, color: Colors.grey);
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Kamjoo Bayat",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "+973 56 89 52 41",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("asset/tabler-icon-wallet (1).png"),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text("Total Order", style: TextStyle(color: Colors.white)),
                          Text("56", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(width: 20),
                      Container(height: 50, width: 1, color: Colors.white54),
                      SizedBox(width: 20),
                      Image.asset("asset/tabler-icon-award.png"),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text("Reward Point", style: TextStyle(color: Colors.white)),
                          Text("128", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22),
        child: Container(
          height: 495,
          width: 350,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView(
                    children: [
                      _buildProfileItems(
                          'Wallet Balance', 'BHD 86.000', 'asset/tabler-icon-wallet (1).png', true),
                      Divider(color: backgroundColor, thickness: 1),
                      _buildProfileItems(
                          'Address',
                          '107, Omar Bin Abdulaziz Avenue\nAl Hoora, Manama, Capital \nGovernorate, Bahrain, 0319.',
                          'asset/tabler-icon-address-book.png',
                          true),
                      Divider(color: backgroundColor, thickness: 1),
                      _buildProfileItem('Privacy Policy', '', 'asset/tabler-icon-file-invoice.png', false),
                      Divider(color: backgroundColor3, thickness: 1),
                      _buildProfileItem('Communication', '', 'asset/tabler-icon-message.png', false),
                      Divider(color: backgroundColor3, thickness: 1),
                      _buildProfileItem('About Us', '', 'asset/tabler-icon-help-hexagon.png', false),
                      Divider(color: backgroundColor3, thickness: 1),
                      _buildProfileItem('Rate us on Google Play Store', '', 'asset/tabler-icon-jewish-star.png', false),
                      Divider(color: backgroundColor3, thickness: 1),
                      _buildProfileItem('Contact Us', '', 'asset/Vector (1).png', false),
                      Divider(color: backgroundColor3, thickness: 1),
                      _buildProfileItem('Logout', '', 'asset/tabler-icon-logout-2.png', false, isLogout: true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItems(String title, String subtitle, String iconPath, bool showArrow) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(iconPath, width: 40, height: 40),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: backgroundColor4,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: backgroundColor4,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ],
        ),
        if (showArrow) Image.asset("asset/Vector.png", width: 24, height: 24),
      ],
    );
  }

  Widget _buildProfileItem(String title, String subtitle, String iconPath, bool showArrow, {bool isLogout = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(iconPath, width: 40, height: 40),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isLogout ? Colors.red : backgroundColor3,
                    fontSize: 16,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: backgroundColor4,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ],
        ),
        if (showArrow) Image.asset("asset/Vector.png", width: 24, height: 24),
      ],
    );
  }
}
