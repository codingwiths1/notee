// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/note/repo/note_repo.dart' as _i892;
import 'note_module.dart' as _i136;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final noteModule = _$NoteModule();
    gh.lazySingleton<_i454.SupabaseClient>(() => noteModule.supabaseClient);
    gh.lazySingleton<_i892.NoteRepo>(
      () => _i892.NoteRepoIMpl(client: gh<_i454.SupabaseClient>()),
    );
    return this;
  }
}

class _$NoteModule extends _i136.NoteModule {}
