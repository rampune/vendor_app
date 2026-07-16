import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/features/event/load_save_event.dart';
import 'package:new_pubup_partner/utils/string_to_int.dart';
import '../../../config/theme.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';
import '../event_controller/event_controller.dart';
import '../model/EventPostModel.dart';
import '../widget/ticket_button.dart';
import '../widget/yes_no_toggle.dart';

class EventAddTable extends StatefulWidget {
  const EventAddTable({super.key});

  @override
  State<EventAddTable> createState() => _EventAddTableState();
}

class _EventAddTableState extends State<EventAddTable> {
  // ─── Table Benefits ─────────────────────────────────────────────────────────
  static const List<String> _staticBenefits = [
    'Free Dinner',
    'Free Starter',
    'Dance Area',
    'Complimentary salads',
  ];

  final Map<String, bool> _selectedBenefits = {
    for (var b in _staticBenefits) b: false,
  };

  final List<String> _customBenefits = [];
  bool _showAddBenefitField = false;
  final TextEditingController _newBenefitController = TextEditingController();

  bool _isRefundable = false;
  final TextEditingController _advancePriceController = TextEditingController();
  final TextEditingController _refundablePriceController = TextEditingController();
  final TextEditingController _refundablePricePercentageController = TextEditingController();
  final TextEditingController _refundableTillDateController = TextEditingController();

  DateTime? _parseDateString(String text) {
    text = text.trim();
    if (text.isEmpty) return null;
    String formatted = text.replaceAll('/', '-');
    try {
      List<String> parts = formatted.split('-');
      if (parts.length == 3) {
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (_) {}
    return DateTime.tryParse(text);
  }

  void _calculatePercentage() {
    final priceStr = _advancePriceController.text.trim();
    final refPriceStr = _refundablePriceController.text.trim();
    if (priceStr.isEmpty || refPriceStr.isEmpty) {
      _refundablePricePercentageController.text = '';
      return;
    }
    final price = int.tryParse(priceStr) ?? 0;
    final refPrice = int.tryParse(refPriceStr) ?? 0;
    if (price > 0 && refPrice > 0) {
      final pct = ((refPrice / price) * 100).round();
      final newText = pct.toString();
      if (_refundablePricePercentageController.text != newText) {
        _refundablePricePercentageController.text = newText;
      }
    } else {
      _refundablePricePercentageController.text = '';
    }
  }

  void _calculatePrice() {
    final priceStr = _advancePriceController.text.trim();
    final pctStr = _refundablePricePercentageController.text.trim();
    if (priceStr.isEmpty || pctStr.isEmpty) {
      _refundablePriceController.text = '';
      return;
    }
    final price = int.tryParse(priceStr) ?? 0;
    final pct = int.tryParse(pctStr) ?? 0;
    if (price > 0 && pct > 0) {
      final refPrice = ((pct / 100) * price).round();
      final newText = refPrice.toString();
      if (_refundablePriceController.text != newText) {
        _refundablePriceController.text = newText;
      }
    } else {
      _refundablePriceController.text = '';
    }
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────────
  List<String> get _selectedBenefitsList =>
      _selectedBenefits.entries.where((e) => e.value).map((e) => e.key).toList();

  void _resetBenefits() {
    for (final key in _selectedBenefits.keys.toList()) {
      _selectedBenefits[key] = false;
    }
    _customBenefits.clear();
    _showAddBenefitField = false;
    _newBenefitController.clear();
  }

  // ─── Validation ──────────────────────────────────────────────────────────────
  bool _validateTableFields() {
    if (EventController.numbTableController.text.trim().isEmpty) {
      showToast("Enter Number of Tables");
      return false;
    }
    if (EventController.sittingTableController.text.trim().isEmpty) {
      showToast("Enter Sitting Capacity");
      return false;
    }
    if (EventController.priceTableController.text.trim().isEmpty) {
      showToast("Enter Table Price");
      return false;
    }
    if (EventController.coverChargeTableController.text.trim().isEmpty) {
      showToast("Enter Cover Charges");
      return false;
    }
    if (_isRefundable) {
      if (_advancePriceController.text.trim().isEmpty) {
        showToast("Enter Advance Price");
        return false;
      }
      if (_refundablePriceController.text.trim().isEmpty) {
        showToast("Enter Refundable Price");
        return false;
      }
      final refPriceText = _refundablePriceController.text.trim();
      if (refPriceText.isNotEmpty && (int.tryParse(refPriceText) == 0)) {
        showAlert(context, "Refundable amounts cannot be zero");
        return false;
      }
      if (_refundablePricePercentageController.text.trim().isEmpty) {
        showToast("Enter Refundable Price Percentage");
        return false;
      }
      if (_refundableTillDateController.text.trim().isEmpty) {
        showToast("Select Refundable Till Date");
        return false;
      }

      final int tablePrice = int.tryParse(EventController.priceTableController.text.trim()) ?? 0;
      final int advancePrice = int.tryParse(_advancePriceController.text.trim()) ?? 0;
      final int refundablePrice = int.tryParse(_refundablePriceController.text.trim()) ?? 0;

      if (refundablePrice > advancePrice) {
        showAlert(context, "Refundable amount cannot be more than the pre-booking amount");
        return false;
      }

      if ((advancePrice + refundablePrice) > tablePrice) {
        showAlert(context, "Advance and Refundable  amount cannot be more than the table  amount");
        return false;
      }
    }
    return true;
  }

  // ─── Actions ─────────────────────────────────────────────────────────────────
  void _addTableAndClear() {
    if (!_validateTableFields()) return;
    setState(() {
      EventController.listEventTable.add(EventTableModel(
        numberOfTables: EventController.numbTableController.text,
        tablePrice: stringToInt(EventController.priceTableController.text),
        sittingCapacity: EventController.sittingTableController.text,
        coverCharges: EventController.coverChargeTableController.text,
        tableBenefits: _selectedBenefitsList,
        isRefundable: _isRefundable,
        advancePrice: _isRefundable ? stringToInt(_advancePriceController.text) : null,
        refundablePrice: _isRefundable ? stringToInt(_refundablePriceController.text) : null,
        refundablePricePercentage: _isRefundable ? stringToInt(_refundablePricePercentageController.text) : null,
        refundableTillDate: _isRefundable ? _refundableTillDateController.text : null,
      ));
      EventController.numbTableController.clear();
      EventController.priceTableController.clear();
      EventController.sittingTableController.clear();
      EventController.coverChargeTableController.clear();
      _advancePriceController.clear();
      _refundablePriceController.clear();
      _refundablePricePercentageController.clear();
      _refundableTillDateController.clear();
      _isRefundable = false;
      _resetBenefits();
    });
    LoadSaveEvent.instance.saveEventToHive();
  }

  void _addTableAndNext() {
    hideKeyboard();
    if (EventController.numbTableController.text.trim().isNotEmpty) {
      if (!_validateTableFields()) return;
      setState(() {
        EventController.listEventTable.add(EventTableModel(
          numberOfTables: EventController.numbTableController.text,
          tablePrice: stringToInt(EventController.priceTableController.text),
          sittingCapacity: EventController.sittingTableController.text,
          coverCharges: EventController.coverChargeTableController.text,
          tableBenefits: _selectedBenefitsList,
          isRefundable: _isRefundable,
          advancePrice: _isRefundable ? stringToInt(_advancePriceController.text) : null,
          refundablePrice: _isRefundable ? stringToInt(_refundablePriceController.text) : null,
          refundablePricePercentage: _isRefundable ? stringToInt(_refundablePricePercentageController.text) : null,
          refundableTillDate: _isRefundable ? _refundableTillDateController.text : null,
        ));
        EventController.numbTableController.clear();
        EventController.priceTableController.clear();
        EventController.sittingTableController.clear();
        EventController.coverChargeTableController.clear();
        _advancePriceController.clear();
        _refundablePriceController.clear();
        _refundablePricePercentageController.clear();
        _refundableTillDateController.clear();
        _isRefundable = false;
        _resetBenefits();
      });
    }
    LoadSaveEvent.instance.saveEventToHive();
    EventController.eventPageController.animateToPage(
      3,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _newBenefitController.dispose();
    _advancePriceController.dispose();
    _refundablePriceController.dispose();
    _refundablePricePercentageController.dispose();
    _refundableTillDateController.dispose();
    super.dispose();
  }

  // ─── Build ───────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final tablePriceText = EventController.priceTableController.text.trim();
    final bool isTableFree = tablePriceText.isNotEmpty && (int.tryParse(tablePriceText) == 0);
    if (isTableFree && _isRefundable) {
      _isRefundable = false;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Form(
          key: EventController.addTableFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Tables to Event", style: context.titleLarge()),
              10.height(),
              Text("Add Tables to your events", style: context.titleSmall()),
              10.height(),

              // ── Added tables chips ────────────────────────────────────────
              Wrap(
                children: EventController.listEventTable
                    .map((item) => PremiumTicketButton(
                          title: item.numberOfTables ?? '',
                          ticketType: '',
                          price: '${item.tablePrice}',
                          onDelete: () {
                            setState(() {
                              EventController.listEventTable.remove(item);
                            });
                          },
                          onEdit: () {
                            setState(() {
                              EventController.numbTableController.text = item.numberOfTables ?? '';
                              EventController.sittingTableController.text = item.sittingCapacity ?? '';
                              EventController.priceTableController.text = item.tablePrice == null ? '' : '${item.tablePrice}';
                              EventController.coverChargeTableController.text = item.coverCharges ?? '';
                              
                              _resetBenefits();
                              if (item.tableBenefits != null) {
                                for (var benefit in item.tableBenefits) {
                                  if (_selectedBenefits.containsKey(benefit)) {
                                    _selectedBenefits[benefit] = true;
                                  } else {
                                    _customBenefits.add(benefit);
                                    _selectedBenefits[benefit] = true;
                                  }
                                }
                              }

                              _isRefundable = item.isRefundable ?? false;
                              _advancePriceController.text = item.advancePrice == null ? '' : '${item.advancePrice}';
                              _refundablePriceController.text = item.refundablePrice == null ? '' : '${item.refundablePrice}';
                              _refundablePricePercentageController.text = item.refundablePricePercentage == null ? '' : '${item.refundablePricePercentage}';
                              _refundableTillDateController.text = item.refundableTillDate ?? '';

                              EventController.listEventTable.remove(item);
                            });
                          },
                        ))
                    .toList(),
              ),
              10.height(),

              // ── Form fields ───────────────────────────────────────────────
              CustomTextField(
                isNumber: true,
                textController: EventController.numbTableController,
                title: "Number of Tables",
                placeHolderText: "e.g 100",
              ),
              20.height(),
              CustomTextField(
                isNumber: true,
                textController: EventController.sittingTableController,
                title: "Sitting Capacity",
                placeHolderText: "",
              ),
              20.height(),
              CustomTextField(
                textController: EventController.priceTableController,
                title: "Table Price",
                isNumber: true,
                onChanged: (val) {
                  setState(() {});
                  return null;
                },
              ),
              20.height(),
              CustomTextField(
                textController: EventController.coverChargeTableController,
                title: "Cover Charges",
              ),
              if (!isTableFree) ...[
                20.height(),
                YesNoToggle(
                  title: "Is Refundable",
                  isYes: _isRefundable,
                  callBack: (bool result) {
                    setState(() {
                      _isRefundable = result;
                    });
                  },
                ),
                if (_isRefundable) ...[
                  20.height(),
                  CustomTextField(
                    textController: _advancePriceController,
                    title: "Advance Price",
                    isNumber: true,
                    placeHolderText: "eg. 1200",
                    onChanged: (val) {
                      if (_isRefundable) {
                        _calculatePercentage();
                      }
                      return null;
                    },
                  ),
                  20.height(),
                  CustomTextField(
                    textController: _refundablePriceController,
                    title: "Refundable Price",
                    isNumber: true,
                    placeHolderText: "eg. 800",
                    onChanged: (val) {
                      _calculatePercentage();
                      return null;
                    },
                  ),
                  20.height(),
                  CustomTextField(
                    textController: _refundablePricePercentageController,
                    title: "Refundable Price Percentage (%)",
                    isNumber: true,
                    placeHolderText: "eg. 75",
                    onChanged: (val) {
                      _calculatePrice();
                      return null;
                    },
                  ),
                  20.height(),
                   CustomTextField(
                    textController: _refundableTillDateController,
                    title: "Refundable Till Date",
                    readOnly: true,
                    placeHolderText: "Select Date",
                    onTap: () async {
                      DateTime now = DateTime.now();
                      DateTime today = DateTime(now.year, now.month, now.day);
                      DateTime lastDate = today;

                      if (EventController.eventDateController.text.isNotEmpty) {
                        DateTime? parsedEventDate = _parseDateString(EventController.eventDateController.text);
                        if (parsedEventDate != null) {
                          lastDate = parsedEventDate;
                        } else {
                          lastDate = DateTime(2101);
                        }
                      } else {
                        lastDate = DateTime(2101);
                      }

                      DateTime firstDate = today;
                      if (lastDate.isBefore(firstDate)) {
                        firstDate = lastDate;
                      }

                      DateTime initialDate = today;
                      if (initialDate.isBefore(firstDate)) {
                        initialDate = firstDate;
                      } else if (initialDate.isAfter(lastDate)) {
                        initialDate = lastDate;
                      }

                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: initialDate,
                        firstDate: firstDate,
                        lastDate: lastDate,
                        barrierColor: Colors.black.withOpacity(0.5),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: AppColors.themeColor,        // Header background color
                                onPrimary: Colors.white,     // Header text color
                                onSurface: Colors.black,     // Body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.themeColor, // Button text color
                                ),
                              ),
                              dialogBackgroundColor: Colors.white, // Background of the dialog
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        String selectedDateStr = "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                        setState(() {
                          _refundableTillDateController.text = selectedDateStr;
                        });
                      }
                    },
                  ),
                ],
              ],
              20.height(),

              // ── Table Benefits ────────────────────────────────────────────
              _buildBenefitsSection(),
              20.height(),

              Text(
                "If you have multiple table types",
                style: const TextStyle(color: Colors.red),
              ),
              10.height(),

              // ── Buttons ───────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonColor: AppColors.black,
                      buttonText: "+ Add More Tables",
                      onPress: _addTableAndClear,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      buttonColor: Colors.amber,
                      buttonText: "Next",
                      onPress: _addTableAndNext,
                    ),
                  ),
                ],
              ),
              20.height(),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Benefits Section ─────────────────────────────────────────────────────
  Widget _buildBenefitsSection() {
    final allBenefits = [..._staticBenefits, ..._customBenefits];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Table Benefits",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        8.height(),

        // ── Selectable benefit chips ──────────────────────────────────────
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allBenefits.map((benefit) {
            final isSelected = _selectedBenefits[benefit] ?? false;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedBenefits[benefit] = !isSelected;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.black : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.black : Colors.grey.shade400,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      const Icon(Icons.check, size: 14, color: Colors.white),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      benefit,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        12.height(),

        // ── Inline add-benefit text field ─────────────────────────────────
        if (_showAddBenefitField) ...[
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newBenefitController,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,

                  ),
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Enter benefit name…",
                    hintStyle:
                        TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppColors.black, width: 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 11),
                ),
                onPressed: () {
                  final newBenefit = _newBenefitController.text.trim();
                  if (newBenefit.isEmpty) {
                    showToast("Please enter a benefit name");
                    return;
                  }
                  if (_selectedBenefits.containsKey(newBenefit)) {
                    showToast("Benefit already exists");
                    return;
                  }
                  setState(() {
                    _customBenefits.add(newBenefit);
                    _selectedBenefits[newBenefit] = true; // auto-selected
                    _newBenefitController.clear();
                    _showAddBenefitField = false;
                  });
                },
                child: const Text("Add", style: TextStyle(fontSize: 13)),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () {
                  setState(() {
                    _newBenefitController.clear();
                    _showAddBenefitField = false;
                  });
                },
                icon: const Icon(Icons.close, size: 18),
                color: Colors.grey.shade600,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          10.height(),
        ],

        // ── "Add New Benefits" button ──────────────────────────────────────
        if (!_showAddBenefitField)
          GestureDetector(
            onTap: () {
              setState(() {
                _showAddBenefitField = true;
              });
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 16, color: Colors.grey.shade700),
                  const SizedBox(width: 4),
                  Text(
                    "Add New Benefits",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}