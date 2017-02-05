# frozen_string_literal: true
class Operation
  def in_transaction
    result = nil
    ActiveRecord::Base.transaction do
      result = yield
    end
    result
  end

  def self.run(*params)
    new(*params).run
  end
end
