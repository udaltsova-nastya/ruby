# frozen_string_literal: true

# Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы,
# которые подключаются автоматически при вызове include в классе:
# Методы класса:
#   - instances, который возвращает кол-во экземпляров данного класса
# Инастанс-методы:
#   - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора.
# При этом данный метод не должен быть публичным.
module InstanceCounter
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
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  # :nodoc:
  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end
  end
end
