import 'package:flutter/material.dart';

/// A generic searchable lookup field that opens a Modal Bottom Sheet for item selection.
/// Supports local filtering of items and handles both LTR and RTL layouts.
class SearchableLookupField<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final String Function(T) itemLabel;
  final List<String> Function(T)? searchStrings;
  final T? value;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final bool isLoading;
  final String? errorText;
  final String? hintText;

  const SearchableLookupField({
    super.key,
    required this.label,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.searchStrings,
    this.value,
    this.validator,
    this.isLoading = false,
    this.errorText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      key: ValueKey(value),
      initialValue: value,
      validator: validator,
      builder: (state) {
        return InkWell(
          onTap: isLoading ? null : () => _showSearchSheet(context, state),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              errorText: state.errorText ?? errorText,
              suffixIcon: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : const Icon(Icons.arrow_drop_down),
            ),
            child: Text(
              value != null ? itemLabel(value as T) : '',
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }

  void _showSearchSheet(BuildContext context, FormFieldState<T> state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return _SearchSheet<T>(
          title: label,
          items: items,
          itemLabel: itemLabel,
          searchStrings: searchStrings,
          initialValue: value,
          hintText: hintText,
          onSelected: (item) {
            onChanged(item);
            state.didChange(item);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

class _SearchSheet<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T) itemLabel;
  final List<String> Function(T)? searchStrings;
  final T? initialValue;
  final String? hintText;
  final void Function(T?) onSelected;

  const _SearchSheet({
    required this.title,
    required this.items,
    required this.itemLabel,
    this.searchStrings,
    this.hintText,
    required this.onSelected,
    this.initialValue,
  });

  @override
  State<_SearchSheet<T>> createState() => _SearchSheetState<T>();
}

class _SearchSheetState<T> extends State<_SearchSheet<T>> {
  late List<T> _filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // أخذ نسخة مستقلة من القائمة لتجنب مشاكل المرجعية (Reference Issues)
    _filteredItems = List.from(widget.items);

    // إضافة مستمع للتأكد من تفاعل واجهة المستخدم (مثل إظهار/إخفاء زر الحذف) بسلاسة
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      final trimmedQuery = query.trim();
      if (trimmedQuery.isEmpty) {
        _filteredItems = List.from(widget.items);
      } else {
        final searchTerm = trimmedQuery.toLowerCase();
        _filteredItems = widget.items.where((item) {
          if (widget.searchStrings != null) {
            return widget.searchStrings!(item).any(
              (s) => s.toLowerCase().contains(searchTerm),
            );
          }
          return widget.itemLabel(item).toLowerCase().contains(searchTerm);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.fromLTRB(16, 16, 16, padding + 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Search...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _filteredItems = List.from(widget.items);
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: _filterItems,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(child: Text('No results found.'))
                : ListView.separated(
                    itemCount: _filteredItems.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      final isSelected = item == widget.initialValue;
                      return ListTile(
                        title: Text(widget.itemLabel(item)),
                        selected: isSelected,
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () => widget.onSelected(item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
