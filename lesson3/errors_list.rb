module ErrorsList
  protected

  attr_reader :errors_list

  # добавляет ошибку в список ошибок
  def add_error(error_message)
    @errors_list ||= []
    @errors_list << error_message
  end

  # возвращает true, если нет ошибок
  def valid?
    @errors_list.nil?
  end

  # возвращает сообщение обо всех ошибках
  def errors_message
    @errors_list.join("; ")
  end

  # в случае, если есть ошибки валидации - выбрасывает исключение ArgumentError
  def validate!
    raise ArgumentError, errors_message unless valid?
  end
end
