class CashRegister
  def initialize(discount=0)
    @total = 0
    @discount = discount
    @cart = {}
    @last_item = []
  end

  attr_accessor :total, :discount

  def add_item(name, price, quantity=1)
    @last_item = [name, price, quantity]
    if @cart[name]
      @cart[name][:quantity] += quantity
    else
      @cart[name] = {price: price, quantity: quantity}
    end
    @total += (price * quantity)
  end

  def apply_discount
    @total = @total - @total * @discount / 100
    if @discount == 0
      return "There is no discount to apply."
    else
      return "After the discount, the total comes to $#{@total}."
    end
  end

  def items
    output = []
    @cart.each do |item, data|
      data[:quantity].times do
        output << item
      end
    end
    output
  end

  def void_last_transaction
    @total -= @last_item[1] * @last_item[2]
    @cart[@last_item[0]][:quantity] -= @last_item[2]
    if @cart[@last_item[0]][:quantity] == 0
      @cart.delete(@last_item[0])
    end
    @last_item = []
  end
end
