class SalaryInfo 
  attr_reader :title, :min, :max
  def initialize(info)
    @title = info[:job][:title]
    @min = format_currency(info[:salary_percentiles][:percentile_25].round(2))
    @max = format_currency(info[:salary_percentiles][:percentile_75].round(2))
  end

  def format_currency(num)
    full_num, decimal = num.to_s.split(".")
    begin_format = full_num.chars.reverse.each_slice(3)
    add_commas = begin_format.map(&:join).join(",").reverse
    final = [add_commas, decimal].compact.join(".")
    final.prepend("$")
  end
end