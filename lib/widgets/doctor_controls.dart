import 'package:flutter/material.dart';

import '../cubits/home/home_state.dart';

class DoctorControls extends StatelessWidget {
  final DoctorFilter selectedFilter;
  final DoctorSort selectedSort;
  final ValueChanged<DoctorFilter> onFilterSelected;
  final ValueChanged<DoctorSort> onSortSelected;

  const DoctorControls({
    super.key,
    required this.selectedFilter,
    required this.selectedSort,
    required this.onFilterSelected,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _filterChip('All', DoctorFilter.all),
              _filterChip('General', DoctorFilter.general),
              _filterChip('Dental', DoctorFilter.dental),
              _filterChip('Child', DoctorFilter.child),
              _filterChip('Favorites', DoctorFilter.favorites),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: PopupMenuButton<DoctorSort>(
            tooltip: 'Sort doctors',
            initialValue: selectedSort,
            onSelected: onSortSelected,
            icon: const Icon(Icons.sort),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: DoctorSort.nameAscending,
                child: Text('Name A-Z'),
              ),
              PopupMenuItem(
                value: DoctorSort.nameDescending,
                child: Text('Name Z-A'),
              ),
              PopupMenuItem(
                value: DoctorSort.distanceAscending,
                child: Text('Nearest first'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _filterChip(String label, DoctorFilter filter) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selectedFilter == filter,
        onSelected: (_) => onFilterSelected(filter),
      ),
    );
  }
}
