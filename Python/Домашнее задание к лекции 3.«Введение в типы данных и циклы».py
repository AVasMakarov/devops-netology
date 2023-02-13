# First
print('First task')
boys = ['Peter', 'Alex', 'John', 'Arthur', 'Richard',]
girls = ['Kate', 'Liza', 'Kira', 'Emma', 'Trisha']
boys.sort()
girls.sort()
length_boys = len(boys)
length_girls = len(girls)
if length_boys == length_girls:
    print('Идеальные пары:')
    for boys, girls in zip(boys, girls):
        print(f'{boys} и {girls}')
else : print('Кто-то может остаться без пары!')

# Second
print()
print('Second task')
cook_book = [
  ['салат',
      [
        ['картофель', 100, 'гр.'],
        ['морковь', 50, 'гр.'],
        ['огурцы', 50, 'гр.'],
        ['горошек', 30, 'гр.'],
        ['майонез', 70, 'мл.'],
      ]
  ],
  ['пицца',
      [
        ['сыр', 50, 'гр.'],
        ['томаты', 50, 'гр.'],
        ['тесто', 100, 'гр.'],
        ['бекон', 30, 'гр.'],
        ['колбаса', 30, 'гр.'],
        ['грибы', 20, 'гр.'],
      ],
  ],
  ['фруктовый десерт',
      [
        ['хурма', 60, 'гр.'],
        ['киви', 60, 'гр.'],
        ['творог', 60, 'гр.'],
        ['сахар', 10, 'гр.'],
        ['мед', 50, 'мл.'],
      ]
  ]
]
person = 5
for dish,receipt in cook_book:
    print(dish.capitalize() + ':')
    for ingridients in receipt:
        print(f'{ingridients[0]}, {str(ingridients[1]*person)}{ingridients[2]}')
    print()
