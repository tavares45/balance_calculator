class BalanceCalculator
  def initialize(balance_currently, users_data)
    @balance_currently = balance_currently.to_f
    @users = format_users(users_data)
  end

  def calculate
    total_balance_of_users = @users.values.sum.round(2)

    if total_balance_of_users <= @balance_currently.round(2)
      {
        status: :ok,
        message: "Cada usuário ainda possui o saldo de: #{formatted_users} e o saldo atual é: R$ #{@balance_currently}"
      }
    else
      diff = (total_balance_of_users - @balance_currently).round(2)
      {
        status: :error,
        message: "A soma dos saldos dos usuários difere do saldo atual em R$ #{diff}"
      }
    end
  end

  private

  def format_users(users_data)
    users_data.each_with_object({}) do |user, hash|
      name = user[:name]
      balance = user[:balance].to_f
      spend = user[:spend].to_f
      value = balance - spend
      hash[name] = value.round(2)
    end
  end

  def formatted_users
    @users.map { |name, value| "#{name} R$ #{value}" }.join(", ")
  end
end
