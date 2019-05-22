# frozen_string_literal: true

# Содержит метод класса validate. Этот метод принимает в качестве параметров имя проверяемого атрибута,
# а также тип валидации и при необходимости дополнительные параметры.Возможные типы валидаций:
#   - presence - требует, чтобы значение атрибута было не nil и не пустой строкой
#   - format (при этом отдельным параметром задается регулярное выражение для формата).
# Требует соответствия значения атрибута заданному регулярному выражению.
#  type (третий параметр - класс атрибута). Требует соответствия значения атрибута заданному классу.
#  Содержит инстанс-метод validate!, который запускает все проверки (валидации),
# указанные в классе через метод класса validate. В случае ошибки валидации выбрасывает исключение с сообщением о том,
# какая именно валидация не прошла
# Содержит инстанс-метод valid? который возвращает true, если все проверки валидации прошли успешно и false,
# если есть ошибки валидации.
# К любому атрибуту можно применить несколько разных валидаторов, например
# validate :name, :presence
# validate :name, :format, /A-Z/
# validate :name, :type, String
# Все указанные валидаторы должны применяться к атрибуту
# Допустимо, что модуль не будет работать с наследниками.
# Подключить эти модули в свои классы и продемонстрировать их использование.
# Валидации заменить на методы из модуля Validation.
module Validation
  ValidationError = Class.new(StandardError)
  PresenceError = Class.new(ValidationError)
  FormatError = Class.new(ValidationError)
  TypeError = Class.new(ValidationError)

  # Модуль говорит: когда меня (self) включают (included) в какой-то класс (klass)
  # мне нужно
  # 1. подключить методы из ClassMethods в klass в качестве методов класса
  # 2. подключить методы из InstanceMethods в klass в качастве инстанс-методов
  def self.included(klass)
    klass.extend ClassMethods
    klass.send :include, InstanceMethods
  end

  # :nodoc:
  module ClassMethods
    # Доступные форматы для аргумента type в validate
    AVAILABLE_TYPES = %i[presence format type].freeze

    def validate(attribute, type, option = nil)
      raise ArgumentError, "Указан неверный тип проверки" unless AVAILABLE_TYPES.include?(type)

      # Мы создаем массив проверок на уровне класса и добавляем туда всю переданную информацию
      # Сами проверки будет выполнять метод validate!
      @validations ||= []
      @validations << { attribute: attribute, type: type, option: option }
    end
  end

  # :nodoc:
  module InstanceMethods
    def validate!
      class_validations.each do |validation|
        attribute, type, option = validation.values_at(:attribute, :type, :option)

        # attribute - имя проверяемого атрибута, например :number
        # value - значение атрибута, например "abc-12"
        value = instance_variable_get("@#{attribute}")

        send("validate_#{type}", attribute, value, option)
      end
    end

    def valid?
      validate!
      true
    rescue ValidationError
      false
    end

    private

    # instance-метод, который возвращает список проверок,
    # объявленных с помощью методов класса validate
    def class_validations
      @class_validations ||= self.class.instance_variable_get(:@validations) || []
    end

    def validate_presence(attribute, value, _option)
      return if !value.nil? && value != ""

      raise Validation::PresenceError, "Не указано значение аттрибута #{attribute}"
    end

    def validate_type(attribute, value, klass)
      return if value.is_a?(klass)

      raise Validation::TypeError, "Значение аттрибута #{attribute} должно принадлежать классу #{klass}"
    end

    def validate_format(attribute, value, pattern)
      return if pattern.match?(value)

      raise Validation::FormatError, "Значение аттрибута #{attribute} должно соответствовать шаблону"
    end
  end
end
