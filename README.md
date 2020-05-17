## 1. Conteúdo

-   [1. Conteúdo](#1-conteúdo)
-   [2. O Projeto](#2-o-projeto)
-   [3. Design](#3-design)
-   [4. Testes](#4-testes)
    -   [4.1. Unitários](#41-unitários)
-   [5. Dependências](#5-dependências)
    -   [5.1. CocoaPods](#51-cocoapods)
        -   [5.1.1. Moya](#511-moya)
        -   [5.1.2. Kingfisher](#512-kingfisher)
        -   [5.1.3. Realm](#513-Realm)


## 2. O Projeto

Arquitetura: **MVVM**

O Projeto foi desenvolvido utilizando o framework SwiftUI que possibilita o desenvolvimento de interfaces de maneira declarativa além de oferecer suporte a visualização do layot em tempo real. O SwiftUI ofeece suporte nativo para implementação do paradigma da programação reativa.

A arquitetura adotada foi o MVVM pois proporciona um baixo acoplamento e favorece a execução de testes. Sua caracteristica principal é a separação de toda regra de negócio da camada de exibição.

## 3. Design

O desing do applicativo representa uma versão atualizada do design proosto pela Tembici. Foi utilziada a palheta de cores proposta no desafio aplicada em cima do tema dark do iOS.

<p align="center">
    <img src="screen/home.png" width="150" height="350" alt="screen" />
    <img src="screen/favorites.png" width="150" height="350" alt="screen" />
    <img src="screen/details.png" width="150" height="350" alt="screen" />

</p>

## 4. Testes

### 4.1. Unitários

Foram implementados testes unitários em todas as requisições de rede 

## 5. Dependências

### 5.1. CocoaPods

#### 5.1.1. [Moya](https://github.com/Moya/Moya)

As requisiçoes foram implemtadas utilizando o Moya pois o mesmo oferece uma grande abstração das requisições, inspirada no conceito de encapsular solicitações de rede de maneira segura, tipicamente usando enumerações, que fornece confiança ao trabalhar com a camada de rede. o Moya tem como um grande benefício a facilidade de executar testes nas requisições.

#### 5.1.2. [Kingfisher](https://github.com/onevcat/Kingfisher)

Ferramanta que auxilia o carregamentpo imagens de maneira assíncrona e implementa recussos de cache.

#### 5.1.3. [Realm](https://github.com/realm/realm-cocoa)

Foi implementado o banco de dados Realm para a persistencia dos dados na aplicação.

