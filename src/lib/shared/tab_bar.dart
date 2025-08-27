import 'package:flutter/material.dart';
import 'package:my_app/shared/app_colors.dart';

class CustomTabBar extends StatefulWidget {
  final List<TabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final double? height;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.height,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 48,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: kcSurfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: kcPrimaryTextColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == widget.selectedIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onTabSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isSelected ? kcPrimaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: _buildTabContent(tab, isSelected),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent(TabItem tab, bool isSelected) {
    final textColor = isSelected ? Colors.white : kcSecondaryTextColor;

    if (tab.icon != null && tab.text != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            tab.icon,
            size: 18,
            color: textColor,
          ),
          const SizedBox(height: 2),
          Text(
            tab.text!,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    } else if (tab.icon != null) {
      return Icon(
        tab.icon,
        size: 20,
        color: textColor,
      );
    } else {
      return Text(
        tab.text!,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}

class TabItem {
  final IconData? icon;
  final String? text;

  const TabItem({
    this.icon,
    this.text,
  }) : assert(
            icon != null || text != null, 'Tab must have either icon or text');
}
