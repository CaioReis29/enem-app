import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  String get msg;

  @override
  List<Object?> get props => [];
}

class NoConnection extends Failure{
  @override
  String get msg => "Oops! Você não tem conexão à internet!";
}

class ApiFailure extends Failure {
  @override
  String get msg => "Desculpe! No momento não é possível acessar o servidor. Tente novamente mais tarde...";
}

class LocalDBNotFound extends Failure {
  @override
  String get msg => "Desculpe! Não foi possível acessar os dados offline, procure acesso à internet e carregue os dados.";
}