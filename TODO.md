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

### Ambiance

- AmbienceManager : manages music
  - Linked to :
    - CombatManager : manage ambient music when a fight starts

### World life

- WorldManager : manages NPC spawning, wildlife, day cycle

## Animations

## Graphics

### Models

- Some houses

### Sprites

