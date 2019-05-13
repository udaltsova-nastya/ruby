# frozen_string_literal: true

# Создать модуль, который позволит указывать название компании-производителя и получать его.
# Подключить модуль к классам Вагон и Поезд
module Manufacturer
  def manufacturer
    @manufacturer
  end

  # производитель указывается один раз, повторный вызов метода не меняет производителя
  def manufacturer=(manufacturer)
    # rubocop:disable Naming/MemoizedInstanceVariableName
    # Рубокоп говорит:
    # Memoized variable @manufacturer does not match method name manufacturer=. Use @manufacturer= instead.
    # Но такой вариант выдает синтаксическую ошибку
    @manufacturer ||= manufacturer
    # rubocop:enable Naming/MemoizedInstanceVariableName
  end
end
