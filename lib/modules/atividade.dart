class Welcome9 {
  Welcome9({
    required this.atividade,
  });

  Atividade atividade;
}

class Atividade {
  Atividade({
    required this.title,
    required this.description,
    required this.atividadeHasQuestao,
  });

  String title;
  String description;
  List<AtividadeHasQuestao> atividadeHasQuestao;
}

class AtividadeHasQuestao {
  AtividadeHasQuestao({
    required this.questao,
  });

  Questao questao;
}

class Questao {
  Questao({
    required this.id,
    required this.title,
    required this.questionType,
    required this.resposta,
  });

  String id;
  String title;
  String questionType;
  List<Resposta> resposta;
}

class Resposta {
  Resposta({
    required this.id,
    required this.alt,
    required this.description,
    required this.isCorrect,
  });

  String id;
  String alt;
  String description;
  bool isCorrect;
}
