# Dig Dug

Trabalho 01 de **DCC148- Desenvolvimento de Jogos**. Um jogo inspirado em **Dig Dug**, desenvolvido  utilizando a Godot Engine. O jogo consiste em menu inicial, uma fase com os requisitos do trabalho e os menus de vitória e derrota.

## 🎮 Como jogar

Comando

Ação

**↑ ↓ ← →** (setas direcionais)

Movimentar o personagem e cavar túneis

**Espaço**

Lançar a bomba de ar para inflar os inimigos

**Objetivo:** cavar túneis para aumentar a pontuação  e usar a bomba de ar para inflar os inimigos e vencer o jogo.

## 📚 Referências

Materiais consultados durante o desenvolvimento e a implementação dos códigos. As referências estão organizadas por assunto para facilitar a consulta.

### Movimento e animações

-   [4-way directional movement instead of 8-way — Godot Forum](https://forum.godotengine.org/t/4-way-directional-movement-instead-of-8-way/41697)
-   [Making a sprite be animated under two conditions — Godot Forum (resposta 9)](https://forum.godotengine.org/t/making-a-sprite-be-animated-under-two-conditions/98788/9)
-   [Making a sprite be animated under two conditions — Godot Forum (resposta 7)](https://forum.godotengine.org/t/making-a-sprite-be-animated-under-two-conditions/98788/7)
-   [How do I check if a particular animation in an AnimationPlayer is playing or not? — Godot Forum](https://forum.godotengine.org/t/how-do-i-check-if-a-particular-animation-in-an-animationplayer-is-playing-or-not/28880/5)
-   [My death animation doesnt play — Godot Forum](https://forum.godotengine.org/t/my-death-animation-doesnt-play/44918/6)

### TileMap, TileMapLayer e interação com tiles

-   [Coding with TileMapLayers: The Fundamentals — YouTube](https://www.youtube.com/watch?v=qXngcKtoKNE&t=562s)
-   [How would I detect a collision on a specific Tile Type? — Godot Forum](https://forum.godotengine.org/t/how-would-i-detect-a-collition-on-a-specific-tile-type/20824/3)
-   [Trying to remove a tile after collision with player — Godot Forum](https://forum.godotengine.org/t/trying-to-remove-a-tile-after-collision-with-player/123547/2)
-   [Get the coordinates of a collision in 2D — Godot Forum](https://forum.godotengine.org/t/get-the-coordinates-of-a-collision-in-2d/10216/2)
-   [Problem with gathering custom data from tiles in a side view 2D game — Godot Forum (resposta 4)](https://forum.godotengine.org/t/problem-with-gathering-custom-data-from-tiles-in-a-side-view-2d-game/87002/4)
-   [Problem with gathering custom data from tiles in a side view 2D game — Godot Forum (tópico)](https://forum.godotengine.org/t/problem-with-gathering-custom-data-from-tiles-in-a-side-view-2d-game/87002)

### Colisões e formas de colisão

-   [How to make CollisionShape2D match the current frame in AnimatedSprite2D — Godot Forum](https://forum.godotengine.org/t/how-to-make-collision-shape-2d-match-current-frame-in-animated-sprite-2d/52228/6)
-   [2D Melee Combat in Godot 4 using AnimationPlayer and Collision Shapes — YouTube](https://www.youtube.com/watch?v=8EVHNbgQCBg&t=673s)
-   [[absolute beginner] How do I change my CollisionShape dynamically according to an animated sprite? — Reddit](https://www.reddit.com/r/godot/comments/dlob17/absolute_beginner_how_do_i_change_my/)
-   [Any way to change collision shape per sprite frame? — Godot Forum](https://forum.godotengine.org/t/any-way-to-change-collision-shape-per-sprite-frame/27105)
-   [Any way to change collision shape per sprite frame? — Godot Forum (resposta 4)](https://forum.godotengine.org/t/any-way-to-change-collision-shape-per-sprite-frame/27105/4)
-   [How to change the size of the collision shape in script — Godot Forum](https://forum.godotengine.org/t/how-to-change-the-size-of-the-collision-shape-in-script/18153)

### Navigation Agent - caminhos e colisões

-   [Navigation Agent e Navigation Layers](https://www.youtube.com/watch?v=Zl7xIkimu84)
-   [Fix: Godot CharacterBody2D Stuck On Tile Corners — Bugnet Blog](https://bugnet.io/blog/fix-godot-character-body-2d-stuck-on-tile-corners)
-   [NavigationAgent2D getting stuck at corners — Godot Forum](https://forum.godotengine.org/t/navigationagent2d-getting-stuck-at-corners/108352)
-   [Fix Navigation Agents Stuck on TileMap Corners in Godot 3.5 — YouTube](https://www.youtube.com/watch?v=nD8mDr8X7Nw&t=22s)

----------
## ⚙️ Estrutura do Projeto

**Pastas** 
O projeto segue a estrutura padrão de pastas dividindo entre uma pasta de Asses outra para cenas e por ultimo uma pasta para os scripts.

**Código**
Tentei manter ao máximo o padrão com as variáveis em inglês, snake case, mantendo a separação de responsabilidade e utilizando os sinais da engine pra quando os scripts necessitavam conversar entre si.
 

