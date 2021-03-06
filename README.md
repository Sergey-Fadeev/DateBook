Приложение "Ежедневник"

  Поддержка платформ - iPhone.
  Ориентация - портретная.
  Поддержка версий - iOS 12+.
  
  Приложение выполнено в архитектуре MVVM с использованием кастомного обсервера, созданного по аналогии с реактивным фреймворком Combine, не поддерживаемый в IOS 12. UI написан с использованием Storyboard/Xib и Autolayout. Переходы по экранам осуществляется с помощью NavigationController, данные хранятся в локальном хранилище Realm.
  Приложение представляет из себя ежедневник в котором присутствуют 3 экрана: экран с календарем и почасовым списком дел на выбранный в календаре день,
экран с подробным описанием дела и эеран для создания и сохранения дела.

Руководство пользователя.
  Первый экран состоит из кастомного календаря который представляет из себя коллекцию для месяца текущей даты. Выбранный пользователем
по нажатию день месяца выделяется цветом, после чего в таблице ниже отображаются почасово все запланированные дела. Выбор месяца отличного от текущего
осуществляется двумя кнопками перелистывающими месяц в меньшую или большую сторону. Удаление запланированного дела осуществляется свайпом ячейки с выбранным делом влево и нажатием кнопки "Удалить". Переход на экран сохранения дела осуществляется нажатием на кнопку "Добавить". Переход на экран с подробным описанием дела
происходит после нажатия на ячейку таблицы с необходимым делом.
  Экран добавления задания состоит из двух полей для ввода заголовка дела и его описания, а так же из двух пикеров для даты начала и окончания дела.
Сохранение дела с последующим возвращением на главный экран осуществляется по нажатию на кнопку "Сохранить". В случае если выбранное для сохранения
время уже занято, пользвателю показывается оповещение о невозможности сохранения дела для данного времени, в таком случае нужно либо выбрать другое время для сохранения либо на главном экране из таблицы удалить до этого сохраненное дело.
  Экран с подробной информацией представляет из себя текстовые поля: заголовок дела, описание дела, дата начала и окончания дела.
