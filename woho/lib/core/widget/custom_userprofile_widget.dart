import 'package:flutter/material.dart';
import 'package:woho/core/colorpallete.dart';

class CustomUserprofileWidget extends StatefulWidget {
  final String userimage;
  final String username;
  final String useremail;
  final bool isHorizontal;

  const CustomUserprofileWidget({
    super.key,
    required this.userimage,
    required this.username,
    required this.useremail,
    this.isHorizontal = false,
  });

  @override
  State<CustomUserprofileWidget> createState() =>
      _CustomUserprofileWidgetState();
}

class _CustomUserprofileWidgetState extends State<CustomUserprofileWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // Profile image scale animation
    _scaleAnimation = Tween<double>(
      begin: 0.75,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    // Card slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.08, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isHorizontal) {
      return _buildHorizontalProfile();
    } else {
      return _buildVerticalProfile();
    }
  }

  // ============================================================
  // HORIZONTAL GEN-Z PROFILE
  // ============================================================

  Widget _buildHorizontalProfile() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorPalette.primary,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.black.withOpacity(0.07)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Lavender decorative circle
              Positioned(
                right: 50,
                top: -25,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE4D9FF).withOpacity(0.55),
                  ),
                ),
              ),

              // Decorative star
              const Positioned(
                right: 20,
                top: 12,
                child: Text(
                  "✦",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    // ============================================
                    // PROFILE IMAGE
                    // ============================================
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Transform.rotate(
                        angle: -0.04,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 10,
                                offset: const Offset(2, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(19),
                            child: SizedBox(
                              height: 72,
                              width: 72,
                              child: _buildUserImage(iconSize: 38),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // ============================================
                    // USER INFO
                    // ============================================
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.username,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF171717),
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            widget.useremail,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF77736D),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              _buildStatusBadge(),

                              const SizedBox(width: 6),

                              const Text("🫶", style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ============================================
                    // ARROW
                    // ============================================
                    _buildArrowButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // VERTICAL GEN-Z PROFILE
  // ============================================================

  Widget _buildVerticalProfile() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          height: 350,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorPalette.primary.withOpacity(0.8),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.black.withOpacity(0.07)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ============================================
              // DECORATIVE LAVENDER CIRCLE
              // ============================================
              Positioned(
                right: -20,
                top: -25,
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE4D9FF).withOpacity(0.6),
                  ),
                ),
              ),

              // ============================================
              // DECORATIVE SMALL CIRCLE
              // ============================================
              Positioned(
                left: -20,
                bottom: 40,
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFD9C7).withOpacity(0.5),
                  ),
                ),
              ),

              // ============================================
              // DECORATIVE STAR
              // ============================================
              const Positioned(
                right: 24,
                top: 20,
                child: Text(
                  "✦",
                  style: TextStyle(fontSize: 26, color: Color(0xFF171717)),
                ),
              ),

              const Positioned(
                left: 22,
                top: 25,
                child: Text(
                  "✦",
                  style: TextStyle(fontSize: 13, color: Colors.black38),
                ),
              ),

              // ============================================
              // MAIN CONTENT
              // ============================================
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ============================================
                    // POLAROID IMAGE
                    // ============================================
                    Center(
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Transform.rotate(
                          angle: -0.025,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 18,
                                  offset: const Offset(3, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(21),
                              child: SizedBox(
                                height: 190,
                                width: double.infinity,
                                child: _buildUserImage(iconSize: 70),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ============================================
                    // USER DETAILS
                    // ============================================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Name & Email
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.username,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF171717),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -1,
                                ),
                              ),

                              const SizedBox(height: 3),

                              Text(
                                widget.useremail,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF77736D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Arrow
                        _buildArrowButton(),
                      ],
                    ),

                    const Spacer(),

                    // ============================================
                    // BOTTOM STATUS
                    // ============================================
                    Row(
                      children: [
                        _buildStatusBadge(),

                        const SizedBox(width: 8),

                        const Text("🫶", style: TextStyle(fontSize: 17)),

                        const Spacer(),

                        Text(
                          "living life, kinda.",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.45),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // USER IMAGE
  // ============================================================

  Widget _buildUserImage({required double iconSize}) {
    if (widget.userimage.isNotEmpty) {
      return Image.network(
        widget.userimage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return _buildImagePlaceholder(iconSize);
        },
      );
    } else {
      return _buildImagePlaceholder(iconSize);
    }
  }

  // ============================================================
  // IMAGE PLACEHOLDER
  // ============================================================

  Widget _buildImagePlaceholder(double iconSize) {
    return Container(
      color: ColorPalette.primary,
      child: Center(
        child: Icon(Icons.face_rounded, size: iconSize, color: Colors.white),
      ),
    );
  }

  // ============================================================
  // STATUS BADGE
  // ============================================================

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF171717),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Text(
        "in my era ✦",
        style: TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  // ============================================================
  // ARROW BUTTON
  // ============================================================

  Widget _buildArrowButton() {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(
        Icons.arrow_outward_rounded,
        color: Color(0xFF171717),
        size: 19,
      ),
    );
  }
}
