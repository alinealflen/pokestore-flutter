# 🛒 PokeStore Flutter

![Flutter](https://img.shields.io/badge/Flutter-3.44-blue)
![Dart](https://img.shields.io/badge/Dart-3.12-blue)
![Status](https://img.shields.io/badge/Status-Em%20Desenvolvimento-yellow)

Aplicação desenvolvida em Flutter para estudo de arquitetura, consumo de APIs REST e gerenciamento de estado.

Os dados são obtidos através da PokeAPI e utilizados para simular um catálogo de produtos.

## 🚀 Tecnologias

- Flutter
- Dart
- Dio
- Provider
- Clean Architecture
- Git e GitHub

## 📱 Funcionalidades Planejadas

- [x] Criação do projeto
- [x] Configuração do GitHub
- [x] Consumo da PokeAPI
- [x] Listagem de produtos
- [x] Tela de detalhes
- [x] Busca de produtos
- [ ] Favoritos
- [ ] Tratamento de erros
- [ ] Gerenciamento de estado com Provider

## 🏗️ Arquitetura

```text
lib/
├── core/
│   ├── constants/
│   ├── services/
│   ├── theme/
│   └── utils/
│
├── features/
│   └── pokemon/
│       ├── data/
│       │   ├── datasources/
│       │   ├── mappers/
│       │   ├── models/
│       │   └── repositories/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       │
│       └── presentation/
│           ├── pages/
│           ├── providers/
│           └── widgets/
│
└── main.dart
```

## 🌐 API

https://pokeapi.co/

## ▶️ Executando o projeto

```bash
flutter pub get
flutter run
```

## 🎯 Objetivo

Este projeto foi criado para atualização técnica em Flutter e construção de portfólio, aplicando conceitos utilizados em projetos profissionais.
