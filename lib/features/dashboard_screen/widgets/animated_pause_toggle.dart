import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/theme.dart';

class AnimatedPauseToggle extends StatelessWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final bool isLoading;

  const AnimatedPauseToggle({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = isLoading ? !initialValue : initialValue;
    return GestureDetector(
      onTap: isLoading
          ? null
          : () {
              final bool newValue = !initialValue;
              final String msg = newValue
                  ? "Pause your venue? Your listing will be temporarily unavailable to users, and all new bookings and reservations will be disabled until you reactivate it."
                  : "Resume your venue? Your listing will become visible to users again, and new bookings and reservations will be enabled once reactivated.";
              askConfirmation(
                context,
                msg,
                confirmCallBack: () {
                  onChanged(newValue);
                },
              );
            },
      child: Opacity(
        opacity: isLoading ? 0.6 : 1.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 50,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: active
                    ? AppColors.redLight.withOpacity(0.2)
                    : Colors.green.withOpacity(0.2),
                border: Border.all(
                  color: active ? AppColors.redLight : Colors.green,
                  width: 1.5,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    left: active ? 28.0 : 4.0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: active ? AppColors.redLight : Colors.green,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}