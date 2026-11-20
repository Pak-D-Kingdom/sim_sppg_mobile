import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../injection_container.dart';
import '../../../cuti_tahunan/presentation/bloc/cuti_tahunan_bloc.dart';
import '../../../cuti_tahunan/presentation/bloc/cuti_tahunan_event.dart';
import '../../../cuti_tahunan/presentation/widgets/cuti_tahunan_main_view.dart';
import '../../../izin_darurat/presentation/bloc/izin_darurat_bloc.dart';
import '../../../izin_darurat/presentation/bloc/izin_darurat_event.dart';
import '../../../izin_darurat/presentation/widgets/izin_darurat_main_view.dart';
import '../../../izin_sakit/presentation/bloc/izin_sakit_bloc.dart';
import '../../../izin_sakit/presentation/bloc/izin_sakit_event.dart';
import '../../../izin_sakit/presentation/widgets/izin_sakit_main_view.dart';
import '../../domain/entities/cuti_tab_type.dart';
import '../widgets/main_cuti_header_widget.dart';
import '../widgets/main_cuti_tab_bar_widget.dart';

class MainCutiPage extends StatefulWidget {
  final CutiTabType initialTab;

  const MainCutiPage({
    super.key,
    this.initialTab = CutiTabType.cutiTahunan,
  });

  @override
  State<MainCutiPage> createState() => _MainCutiPageState();
}

class _MainCutiPageState extends State<MainCutiPage> {
  late CutiTabType _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CutiTahunanBloc>(
          create: (_) => sl<CutiTahunanBloc>()
            ..add(const LoadCutiTahunanInitialEvent()),
        ),
        BlocProvider<IzinSakitBloc>(
          create: (_) =>
              sl<IzinSakitBloc>()..add(const LoadIzinSakitInitialEvent()),
        ),
        BlocProvider<IzinDaruratBloc>(
          create: (_) =>
              sl<IzinDaruratBloc>()..add(const LoadIzinDaruratInitialEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Column(
            children: [
              // Header Back Button & Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MainCutiHeaderWidget(
                  onBackTap: () => Navigator.of(context).maybePop(),
                ),
              ),

              // Segmented Tab Bar (Cuti Tahunan | Izin Sakit | Izin Darurat)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MainCutiTabBarWidget(
                  currentTab: _selectedTab,
                  onTabSelected: (tab) {
                    setState(() {
                      _selectedTab = tab;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Dynamic Tab Body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildCurrentTabContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentTabContent() {
    switch (_selectedTab) {
      case CutiTabType.cutiTahunan:
        return const CutiTahunanMainView();
      case CutiTabType.izinSakit:
        return const IzinSakitMainView();
      case CutiTabType.izinDarurat:
        return const IzinDaruratMainView();
    }
  }
}
