// ignore_for_file: unused_local_variable

import 'package:baatcheet/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:baatcheet/core/network/connection_checker.dart';
import 'package:baatcheet/core/secrets/app_secrets.dart';
import 'package:baatcheet/features/auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:baatcheet/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:baatcheet/features/auth/domain/repositories/auth_repository.dart';
import 'package:baatcheet/features/auth/domain/usecases/current_user.dart';
import 'package:baatcheet/features/auth/domain/usecases/user_login.dart';
import 'package:baatcheet/features/auth/domain/usecases/user_sign_up.dart';
import 'package:baatcheet/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:baatcheet/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:baatcheet/features/home/data/respository/chat_repositiry_implementation.dart';
import 'package:baatcheet/features/home/domain/repositories/chat_repository.dart';
import 'package:baatcheet/features/home/domain/usecases/channels.dart';
import 'package:baatcheet/features/home/domain/usecases/send_message.dart';
import 'package:baatcheet/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'init_dependencies.main.dart';
