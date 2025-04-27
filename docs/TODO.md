# To-do list

## Gameplay

### Exploration

### Progression

- FFTA(2)-like system : learn skills over time by using certain pieces of equipment
  - Swords, axes, hammers, etc. : combat arts, special moves
  - Grimoires, staves, etc. : spellcasting
  - Armor pieces : defensive & dodging skills

### Combat

- CombatManager : starts and stops fights between actors, manages AI decision-making in a fight
  - Called by actors when engaging fights
  - Raises signals :
    - when fight starts, which actors are in it, is player concerned
    - when fight stops, who won, who is alive
- Implement different weapons : swords, rapiers, hammers, whips, bows, 1-handed, 2-handed, dual wield

#### Weapon types

Smth like Monster Hunter : somewhat exotic weapons with each having its own specifics

#### Daggers

dual wielding, quick hits, lots of stabbing

#### Sword



#### Rapier

#### Longsword

#### Warhammer

#### (Cross?)bow

#### Spear

#### Whip

#### Shield

#### Spells





### Ambiance

- AmbienceManager : manages music
  - Linked to :
    - CombatManager : manage ambient music when a fight starts

### World life

- WorldManager : manages NPC spawning, wildlife, day cycle

## Animations

- 

## Graphics

### Models

- Some houses
- Weapons
- 

### Sprites



# Notes

## Magic system

### Spells

Player can learn spells.

A spell is identified by a sequence of glyphs.

Casting a spell costs magic points, or health points when MP are depleted.

Magic points regenerate over time, or with potions.

### Glyphs

Heat/Frost/Carbonic/Metallic (H/F/C/M)

Celsius/Kelvin/Covalence/Metal (Ce/Ke/Co/Me) OR Celsius/Kelvus/Covas/Metas ? idk

Examples :

- H -> Fire I, H/H -> Fire II, H/H/H -> Fire III
- F -> Ice I, F/F -> Ice II, F/F/F -> Ice III
- M -> Thunder I, M/M -> Thunder II, M/M/M -> Thunder III
- C -> Heal I, C/C -> Heal II, C/C/C -> Heal III
- H/F -> 

### Spells list

| Name                    | Description                            | Glyphs | Notes |
| ----------------------- | -------------------------------------- | ------ | ----- |
|                         | **Offensive spells**                   |        |       |
| Fire I                  | Ball of fire                           | H      |       |
| Fire II                 | Column of fire                         | HH     |       |
| Fire III                | Massive fiery explosion                | HHH    |       |
| Ice I                   | Stalactite                             | F      |       |
| Ice II                  | Ice spikes bursting from ground        | FF     |       |
| Ice III                 | Literal ice block bursting from ground | FFF    |       |
| Thunder I               | Electrical spark from above            | M      |       |
| Thunder II              | Electrical thunder from the clouds     | MM     |       |
| Thunder III             | Zeus took your words personally.       | MMM    |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         | **Disadvantageous spells**             |        |       |
| Poison                  | head-sized cloud of venomous gas       | HM     |       |
| Poison II               | Body-sized cloud of corrosive gas      | HMM    |       |
| Slow                    | Exhausts and weakens one's muscles     | CFF    |       |
| **Advantageous spells** |                                        |        |       |
| Speed                   |                                        |        |       |
| Strength                |                                        |        |       |
| Antidote                |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         | **Defensive spells**                   |        |       |
| Heal I                  | Heals a concussion or a small cut      | C      |       |
| Heal II                 | Heals an external hemorrhage           | CC     |       |
| Heal III                | Heals broken bones                     | CCC    |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |
|                         |                                        |        |       |


### UI

- Open spellbook : opens a radial menu with X runes
- Click on a rune : opens another radial menu with X more runes
- Right click : goes back to the previous menu/cancels the spell if it was the first rune
- Close spellbook : closes the radial menu and casts the spell corresponding to the selected runes, if possible/exists
- Cancel spell : closes the radial menu, no effect
