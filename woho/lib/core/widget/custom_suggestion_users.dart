import 'package:flutter/material.dart';
import 'package:woho/core/colorpallete.dart';

class SuggestionUserWidget extends StatefulWidget {
  final String userimage;
  final String username;
  final String useremail;
  final VoidCallback? onProfileTap;
  final VoidCallback? onFollowTap;

  const SuggestionUserWidget({
    super.key,
    required this.userimage,
    required this.username,
    required this.useremail,
    this.onProfileTap,
    this.onFollowTap,
  });

  @override
  State<SuggestionUserWidget> createState() => _SuggestionUserWidgetState();
}

class _SuggestionUserWidgetState extends State<SuggestionUserWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  bool isFollowing = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.88,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });

    widget.onFollowTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: GestureDetector(
            onTap: widget.onProfileTap,
            child: Container(
              width: 155,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: ColorPalette.primary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.black.withOpacity(0.06)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 15,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ==============================
                  // PROFILE IMAGE
                  // ==============================
                  Hero(
                    tag: "suggestion_${widget.useremail}",
                    child: Container(
                      height: 78,
                      width: 78,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.08),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(child: _buildUserImage()),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ==============================
                  // USERNAME
                  // ==============================
                  Text(
                    widget.username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF171717),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),

                  const SizedBox(height: 3),

                  // ==============================
                  // EMAIL
                  // ==============================
                  Text(
                    widget.useremail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.45),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ==============================
                  // FOLLOW BUTTON
                  // ==============================
                  GestureDetector(
                    onTap: _handleFollow,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      height: 36,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isFollowing
                            ? Colors.white
                            : const Color(0xFF171717),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isFollowing
                              ? Colors.black.withOpacity(0.10)
                              : Colors.transparent,
                        ),
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: Text(
                            isFollowing ? "Following ✓" : "Follow",
                            key: ValueKey(isFollowing),
                            style: TextStyle(
                              color: isFollowing
                                  ? const Color(0xFF171717)
                                  : Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==============================
  // USER IMAGE
  // ==============================
  Widget _buildUserImage() {
    if (widget.userimage.isNotEmpty) {
      return Image.network(
        widget.userimage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return _imagePlaceholder();
        },
      );
    }

    return _imagePlaceholder();
  }

  Widget _imagePlaceholder() {
    return Container(
      color: ColorPalette.primary,
      child: const Center(
        child: Icon(Icons.person_rounded, size: 40, color: Colors.white),
      ),
    );
  }
}
